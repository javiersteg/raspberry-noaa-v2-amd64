![Raspberry NOAA](assets/header_1600_v2.png)

This is a port of original RASPBERRY NOAA V2 to convert it to compatible WITH AMD64 Architecture computers.

Thanks to the original developers.

/// IMPORTANT ///
IF YOU NEED HELP YOU CAN SEND ME A TELEGRAM: @javiersteg

PROBABLY METEOR M2 DECODE IS NOT WORKING WELL. SO I WILL TEST IT MORE

EXTRA REQUIRMENTS!!! READ THIS PART:
-After more testing. 100% Compatibility is SO: Debian Bullseye AMD64 (NON-FREE). Other SO will be tested and posted here. If you know more about this please report me. I'm not sure if this will work ON DEBIAN 11 (FREE). Actually working S.O: Debian 11 AMD64 (NON-FREE)

-You need to enter more commands. But i'm preparing it to be copy paste commands.

-It's recomended intermediate knowledge about Linux and Debian. 

-I'm trying to get a simple Virtualbox Machine to be more easier for the people to use this FORK.

-You need an user named "pi" and need to be SUDO. Therefore you need to be logged in this user.

/// IMPORTANT ///

Looking for support, wanting to talk about new features, or just hang out? Come chat with us on [Discord!](https://discord.gg/A9w68pqBuc)

**_This is a spinoff of the original [raspberry-noaa](https://github.com/reynico/raspberry-noaa) created by Nico - they have
graciously permitted me to push this project forward with a major refactor to enhance things such as usability, style, and general
updates. All original content has been preserved (as have all commits up to the point of this repo creation) to retain credit to the
original creators. Please see the "Credits" section of this README for additional info and contributions from the fantastic
NOAA/METEOR community!._**

Wanting to give this version a go but not sure what's involved to get from the original raspberry-noaa to raspberry-noaa-v2? Check
out this simple [migration document](docs/migrate_from_raspberry_noaa.md) that explains the few commands you need to run and retain
your original data!

Finally, if you're looking for one of the cheapest ways to get started from an antenna perspective, check out
[this post](https://jekhokie.github.io/noaa/satellite/rf/antenna/sdr/2019/05/31/noaa-satellite-imagery-sdr.html), specifically around
how to use a cheap rabbit ears antenna as a dipole for capturing NOAA and Meteor images!


# Super Easy setup: Use a maintained APPLIANCE OVA IN WINDOWS/LINUX/MAC OS

///// PLEASE REPORT ME THAT YOU DISCOVER THAT I CAN IMPROVE.

Want a really simple way to get up and running? 

Download the OVA with all installed: (I TESTED AND IT'S WORKING GREAT WITH NOAA, METEOR M2 I'm testing it)

You only need to change settings that match with yours and then schedule. Schedule with command: 

```bash
cd /home/pi/raspberry-noaa-v2
./scripts/schedule.sh -x
````

Link of OVA IMAGE (GOOGLE DRIVE) : https://drive.google.com/file/d/12VAiZjCVBp0H4zFBu0aApt5l8hTm5e_c/view?usp=sharing

OVA DETAILS:

It's recomended minium virtualbox managment knowledge. Ethernet adapter need to be in Bridge Mode to permit conecting to the web over house network.

-Size: 2102 MB

HASHES: 

  -MD5: a929957cb37a66e4b7b24f0c2da5d296  RASP_NOA_V2_AMD64.ova
  
  -SHA256: b8bbb1348509b894161a0b12902113f6f97f9c19a12a449054358c0ae9e83b3e  RASP_NOA_V2_AMD64.ova


## Quick Start - building latest from the source on this repo
/// IMPORTANT ///
To install you need to follow this Steps to get it working.

Want to build your own, but don't want all the nitty-gritty details? 
Here's the quick-start - if you have questions, continue reading the rest of this README or
reach out by submitting an issue:

```bash
# update os localisation settings / YOU SHOULD CONFIGURE YOUR LOCAL SETTINGS ON DEBIAN INSTALLATION OR AFTER : See this link for time zone https://linuxize.com/post/how-to-set-or-change-timezone-on-debian-10/
#See this link for LOCALES: https://serverfault.com/a/54599
#Now you need to be sudo. Be logged on "pi" USER. After this you can continue

#ADD i386 ARCHITECTURE TO BE USABLE BY RASPNOAAV2
sudo dpkg --add-architecture i386
sudo apt update

#INSTALL ANSIBLE, GIT AND RTL-SDR before.
sudo apt install -y ansible rtl-sdr git

# clone repository
cd $HOME
git clone https://github.com/javiersteg/raspberry-noaa-v2-amd64.git
mv raspberry-noaa-v2-amd64 raspberry-noaa-v2
cd raspberry-noaa-v2/

#UDEV RULES. Copy file example of RTL-SDR. Then activate it. (THIS IS USED TO ALLOW NON-ROOT USERS TO USE RTL-SDR DONGLE)
sudo cp udev/10-rtl-sdr.rules /etc/udev/rules.d/10-rtl-sdr.rules
sudo udevadm control --reload-rules

#INSTALL EXTRA FILES THAT DEBIAN NOT FOUND:
sudo apt remove libjpeg62-turbo     ##PROBABLY YOU HAVE OTHER VERSION. If it isn't "9". You need to launch this 2 commands replacing the number of version you've
sudo apt remove libjpeg62-turbo-dev 
sudo dpkg -i extra/*.deb
sudo apt install -y --fix-broken

# copy sample settings and update for your install /NOW YOU NEED TO PREPARE THIS FILE AS NORMAL INSTALLATION/
cp config/settings.yml.sample config/settings.yml
vi config/settings.yml

# perform install /FINALLY INSTALL.
sudo echo                           #####THIS WILL BE USED TO ACTIVATE SUDO BEFORE START TO INSTALL
./install_and_upgrade.sh
```

/// IMPORTANT ///

Once complete, follow the [migration document](docs/migrate_from_raspberry_noaa.md) if you want to migrate from the original raspberry-noaa
to this version 2 (keep your previous captures and make them visible).

In addition, if you have elected to run a TLS-enabled web server, see [THIS LINK](docs/tls_webserver.md) for some additional information
on how to handle self-signed certificates when attempting to visit your webpanel and enabling auth for the admin pages.

To see what occurred during a capture event, check out the log file `/var/log/raspberry-noaa-v2/output.log`.


## Compatibility

**NOTE: ONLY 64bit (AMD64) OS is supported : Recommended is 'Bullseye' Debian RELEASE, Probably ubuntu works (Server better thank desktop if isn't enough machine).**

This FORK is tested on Virtualbox Debian Machines, x64 Hardware with debian bullseye (non-free)

## wxtoimg License Terms Acceptance

Use of this framework assumes acceptance of the wxtoimg license terms and will automatically "accept" the terms as part of the installation.
You MUST review the license prior to installing this framework, which can be viewed under the "Terms and Conditions" section of the
[wxtoimg manual](https://wxtoimgrestored.xyz/downloads/wxgui.pdf). If you do not agree to the wxtoimg terms, please do not install or
use this framework.

## Prerequisites

Below are some prerequisites steps and considerations prior to installing this software:

1. Recomended all settings like Locale, Timezone.... Set for your needs.
3. You need git installed to clone the repository - this can be done via `sudo apt-get -y install git`.
4. It is recommended to change your `pi` user default password after logging into the system for the first time. While it is not
recommended that you expose a Pi instance to the public internet for access (unless you have a VERY strict process about security
patching, and even then it would still be questionable), updating your Pi user password is a decent first step for security.

## Upgrade

Want to get the latest and greatest content from the GitHub master branch? Easy - use the same script from the Install process
and all of your content will automatically upgrade (obviously you'll want to do this when there isn't a scheduled capture occurring
or about to occur). Note that once you pull the latest code down using git, you'll likely want to compare your `config/settings.yml`
file with the new code `config/settings.yml.sample` and include/incorporate any new or renamed configuration parameters.

**Note**: You can double-check that the configuration parameters in your `config/settings.yml` file are correctly aligned to the
expectations of the framework configurations (this is done by default now as part of the `install_and_upgrade.sh` script) by
running `./scripts/tools/validate_yaml.py config/settings.yml config/settings_schema.json`. The output of this script will
inform you whether there are any new configs that you need to add to your `config/settings.yml` file or if values provided for
parameters are not within range or of the expected format to help with reducing the strain on your eyes in comparing the files.

```bash
# pull down new code
cd $HOME/raspberry-noaa-v2/
git pull

# compare settings file:
#   config/settings.yml.sample with config/settings.yml
# and incorporate any changes/updates

# perform upgrade
./install_and_upgrade.sh
```

If you have elected to run a TLS-enabled web server, see [THIS LINK](docs/tls_webserver.md) for some additional information
on how to handle self-signed certificates when attempting to visit your webpanel and enabling auth for the admin pages.

## Post Install

There are and will be future "optional" features for this framework. Below is a list of optional capabilities that you may wish
to enable/configure with links to the respective instructions:

* [Update Image Annotation Overlay](docs/annotation.md)
* [Pruning Old Images](docs/pruning.md)
* [Database Backups](docs/db_backups.md)
* [Emailing Images (IFTTT)](docs/emailing.md)
* [Pushing Images to Discord](docs/discord_push.md)

## Changing Configurations After Install

Want to make changes to either the base station functionality or webpanel settings? Simply update the `config/settings.yml` file
and re-run `./install_and_upgrade.sh` - the script will take care of the rest of the configurations!

## Troubleshooting

If you're running into issues where you're not seeing imagery after passes complete or getting blank/strange images, you can check
out the [troubleshooting](docs/troubleshooting.md) document to try and narrow down the problem. In addition, you can inspect the log
output file in `/var/log/raspberry-noaa-v2/output.log` to investigate potential errors or issues during capture events.

## Additional Feature Information

The decoding model has been changed with release 1.8 to default to using GNURADIO based capture via Python for both Meteor 
(which was previously an option) and now also for NOAA. This will open the platform up for developers to integrate alternative hardware capture than rtl-sdr.

For additional information on some of the capabilities included in this framework, see below:

  - [Meteor M2 Full Decoding](docs/meteor.md)

## Credits

The NOAA/METEOR image capture community is a group of fantastic, experienced engineers, radio operators, and tinkerers that all contributed in some way, shape,
or form to the success of this repository/framework. Below are some direct contributions and call-outs to the significant efforts made:

* **[haslettj](https://www.instructables.com/member/haslettj/)**: Did the hard initial work and created the post to instruct on how to build the base of this framework.
    * [Instructables](https://www.instructables.com/id/Raspberry-Pi-NOAA-Weather-Satellite-Receiver/) post had much of the content needed to kick this work off.
* **[Nico Rey](https://github.com/reynico)**: Initial creator of the [raspberry-noaa](https://github.com/reynico/raspberry-noaa) starting point for this repository.
* **[otti-soft](https://github.com/otti-soft/meteor-m2-lrpt)**: Meteor-M 2 python functionality for image processing.
* **[NateDN10](https://www.instructables.com/member/NateDN10/)**: Came up with the major enhancements to the Meteor-M 2 receiver image processing in "otti-soft"s repo above.
    * [Instructables](https://www.instructables.com/Raspberry-Pi-NOAA-and-Meteor-M-2-Receiver/) post had the details behind creating the advanced functionality.
* **[Dom Robinson](https://github.com/dom-robinson)**: Meteor enhancements, Satvis visualizations, and overall great code written that were incorporated into the repo.
    * Merge of functionality into this repo was partially created using his excellent fork of the original raspberry-noaa repo [here](https://github.com/dom-robinson/raspberry-noaa).
    * Continued pushing the boundaries on the framework capabilities.
* **[Colin Kaminski](https://www.facebook.com/holography)**: MAJOR testing assistance and submission of various enhancements and documentation.
    * Continuous assistance of community members in their search for perfect imagery.
* **[Mohamed Anjum Abdullah](https://www.facebook.com/MohamedAnjum9694/)**: Initial testing of the first release.
* **[Kyle Keen](http://kmkeen.com/rtl-power/)**: Programming a lot of features for our RTL-SDR Drivers.
* **[Pascal P.](https://github.com/Cirromulus)**: Frequency/spectrum analysis test scripts for visualizing frequency spectrum of environment.
* **[Socowi's Time Functionality](https://stackoverflow.com/a/50434292)**: Time parser to calculate end date for scanner scripts.
* **[Vince VE3ELB](https://github.com/ve3elb)**: Took on the invaluable task to create fully working images of RN2 for the PI and maintains [https://qsl.net/ve3elb/RaspiNOAA/](https://qsl.net/ve3elb/RaspiNOAA/).
*  **[mihajlo2003petkovic](https://github.com/mihajlo2003petkovic)**: Updates to the web browser and general updating and debugging.
## Contributing

Pull requests are welcome! Simply follow the below pattern:

1. Fork the repository to your own GitHub account.
2. `git clone` your forked repository.
3. `git checkout -b <my-branch-name>` to create a branch, replacing with your actual branch name.
4. Do some awesome feature development or bug fixes, committing to the branch regularly.
5. `git push origin <my-branch-name>` to push your branch to your forked repository.
6. Head back to the upstream `jekhokie/raspberry-noaa-v2` repository and submit a pull request using your branch from your forked repository.
7. Provide really good details on the development you've done within the branch, and answer any questions asked/address feedback.
8. Profit when you see your pull request merged to the upstream master and used by the community!

Make sure you keep your forked repository up to date with the upstream `jekhokie/raspberry-noaa-v2` master branch as this will make
development and addressing merge conflicts MUCH easier in the long run.

Happy coding (and receiving)!
