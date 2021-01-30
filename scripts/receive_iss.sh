#!/bin/bash

### Run as a normal user
if [ $EUID -eq 0 ]; then
    echo "This script shouldn't be run as root."
    exit 1
fi

## import common lib
. "$HOME/.noaa-v2.conf"
. "$HOME/.tweepy.conf"
. "$NOAA_HOME/scripts/common.sh"

if pgrep "rtl_fm" > /dev/null
then
    log "There is an already running rtl_fm instance but I dont care for now, I prefer this pass" "INFO"
    pkill -9 -f rtl_fm
fi

# $1 = Satellite Name
# $2 = Frequency
# $3 = FileName base
# $4 = TLE File
# $5 = EPOC start time
# $6 = Time to capture
# $7 = Satellite max elevation

log "Starting rtl_fm record" "INFO"
timeout "${6}" /usr/local/bin/rtl_fm ${BIAS_TEE} -M fm -f 145.8M -s 48k -g $GAIN -E dc -E wav -E deemp -F 9 - | sox -t raw -r 48k -c 1 -b 16 -e s - -t wav "${NOAA_AUDIO_OUTPUT}/${3}.wav" rate 11025

if [ -f "$NOAA_HOME/scripts/demod.py" ]; then
    log "Decoding ISS pass" "INFO"
    python3 "$NOAA_HOME/scripts/demod.py" "${NOAA_AUDIO_OUTPUT}/${3}.wav" "${IMAGE_OUTPUT}/"
    decoded_pictures="$(find ${IMAGE_OUTPUT}/ -iname "${3}*png")"
    img_count=0
    for image in $decoded_pictures; do
        log "Decoded image: $image" "INFO"
        ((img_count++))
    done

    if [ "$img_count" -gt 0 ]; then
        /usr/bin/convert -thumbnail 300 "${IMAGE_OUTPUT}/${3}-0.png" "${IMAGE_OUTPUT}/thumb/${3}-0.png"
        sqlite3 "$DB_FILE" "insert into decoded_passes (pass_start, file_path, daylight_pass, sat_type, img_count) values ($5,\"$3\",1,2,$img_count);"
        pass_id=$(sqlite3 "$DB_FILE" "select id from decoded_passes order by id desc limit 1;")
        if [ -n "$CONSUMER_KEY" ]; then
            log "Posting to Twitter" "INFO"
            if [ "$img_count" -eq 1 ]; then
                python3 $NOAA_HOME/scripts/post.py "$1 ${START_DATE} Resolución completa: https://weather.reyni.co/detail.php?id=$pass_id" "$7" "${IMAGE_OUTPUT}/${3}-0.png"
            elif [ "$img_count" -eq 2 ]; then
                /usr/bin/convert -thumbnail 300 "${IMAGE_OUTPUT}/${3}-1.png" "${IMAGE_OUTPUT}/thumb/${3}-1.png"
                python3 $NOAA_HOME/scripts/post.py "$1 ${START_DATE} Mas imagenes: https://weather.reyni.co/detail.php?id=$pass_id" "$7" "${IMAGE_OUTPUT}/${3}-0.png" "${IMAGE_OUTPUT}/${3}-1.png"
            fi
        fi
        sqlite3 "$DB_FILE" "update predict_passes set is_active = 0 where (predict_passes.pass_start) in (select predict_passes.pass_start from predict_passes inner join decoded_passes on predict_passes.pass_start = decoded_passes.pass_start where decoded_passes.id = $pass_id);"
    fi
fi