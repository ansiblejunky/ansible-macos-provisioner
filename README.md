# Ansible OSX Provisioner

This repo helps provision a brand new or existing Mac. It uses some initial manual steps that cannot or have not been automated and then some initializing (to prepare a `pyenv` with `ansible` in a virtual environment using Python 3). This is necessary in order to run the final automated step of the `ansible` playbook that installs and configures your Mac with your favorite software and configurations. 

Some basics before you begin to provision your system. This tool requires Ansible and Homebrew to perform the installations. Why these tools? Ansible is a beautiful automation software. Homebrew is the best package management software for Mac systems. These two are meant for each other when it comes to provisioning a Mac.  If I lost you already, don't worry about it. The tool installs all dependencies necessary for a beautiful easy automated installation. So kick back and relax.

> NOTE: If you already have software installed on your system you should have Homebrew manage these installations. To do that, you simply need to install the software using Homebrew. Typically it will replace the existing installation for you. If not, you might want to try the following tool: https://github.com/exherb/homebrew-cask-replace


## Installation

We need some initial manual steps because we cannot run Ansible without some basics and we definitely do **not** want to install Ansible in the system Python that comes with Mac OS!  So let's prepare things the right way.

- (optional) Launch System Prefs app
	- Go to Trackpad
	- Disable "Force Click and haptic feedback"
- Launch Mac App Store
	- Authenticate in Mac App Store
	- This is useful to automate installation of your Mac App Store purchases
- Launch Safari app
	- Navigate to GitHub.com
	- Login to GitHub.com
	- Generate personal access token
- Launch Terminal app
	- Change default shell
	   `chsh -s /bin/bash`
	- Run `git` to install x-tools
	- Clone repo for this repo (ansible-osx-provisioner)
		- `git clone <repo>`
		- authenticate using username + personal-access-token
	- Run `./initialize.sh` to prepare Mac with home-brew, pyenv, and install python virtualenv with ansible
	- Run `ansible-playbook playbook.yml --ask-become-pass` to install software
- Launch Google Chrome
	- Login and sync (this gets extensions, and current tab/window state from previous laptop)
- Launch your backup software
	- Login and restore from backup
- Other things
	- Copy ssh keys from original laptop (maybe use bluetooth or ssh?)
        - setup Yubikey
        - Test all conference tools to ensure they can share screens and mic works, etc. (this usually requires a lot of approvals for Mac security)
    - Configure printer in SysPrefs
    - Install VSCode extensions; configure Workspaces extension

## Red Hat Setup

The following are specific to a Red Hat laptop.

### Managed Software

Install Managed Software Center from Mojo to add VPN software, etc. To login to Mojo, you will need to already have your token setup on your phone to get into the VPN to access the Mojo site.

### Yubikey Installation

- download Yubikey Manager tool using homebrew
`brew cask install homebrew/cask-drivers/yubico-yubikey-manager`
- start Yubikey Manager app
- put Yubikey device into Mac slot
- app should recognize it and display icon and firmware info
- select "Applications" from top
- Slot 1 is for "short touch", Slot 2 is for "long touch" so you can setup 2 slots to manage 2 systems and out-of-the-box Yubikey configures slot 1 to work with their website.
- I don't care about connecting to Yubico and I prefer having the short touch mechanism, so I did the following...
- select "Delete" on slot 1 to remove the existing configuration
- select "Configure" on slot 1
- select "OATH-HOTP" option
- Connect to Red Hat's VPN using Viscosity software and your current FreeOTP app on your phone for the token (you need to be on VPN to create a new software token)
- select "Create Software Token" from left-hand panel
- ensure "Generate OTP Key on the Server" is enabled
- enter the PIN you want (probably same you had before)
- select "Enroll Token" button
- Use the FreeOTP app on your phone to scan the QR code (it may ask for the issuer - use 'Red Hat')
- On the website, there is a link at the top to get the URL when you do not have a QR scanner. Use that and it shows you the Secret Key in the URL it generates. 
- Place the secret key string into the Yubico Manager app - the last we left it sitting on a page where it requests the secret key. Ensure it has 6 digits set as well.
- Select "Finish" on the Yubico Manager app and it configures the slot correctly.
- Go back to the Red Hat token.redhat.com site and use the testing page to test your PIN and TOKEN. If necessary sync the token. 
- You should get success on the sync and also testing it using the "TEST TOKEN" area on the bottom. 
- You're done! Dang!

## Laptop Skin

If you really want to get fancy with your new laptop, I recommend to order a laptop [skin](http://www.skinit.com/).


## Where to find software

To find other homebrew software and formulae, use the following links.

- http://brewformulas.org
- http://macappstore.org/

For the best free Mac applications, look here: http://thriftmac.com

## Mac settings

To automate your specific Mac settings I recommend looking at this webpage for details.

[Change Mac OS User Preferences via Command Line](https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/)

For example:
```shell
# System Preferences > Dock > Automatically hide and show the Dock:
defaults write com.apple.dock autohide -bool true
```

## Improvements

- Automate postman preferences and saved environments (export them and then import them)
- automate iterm2 preferences
- installing virtualbox requires approval of software extension so it fails on first attempt
- Automate google chrome preferences and extensions
- Automate docked items
- maybe ignore_errors: true in case a brew install fails 
- Migrate Itsycal preferences from one laptop to another
	- Copy/backup the following file from old laptop:
         cp ~/Library/Preferences/com.mowglii.ItsycalApp.plist <destination>
	- Run the following command to import the plist file (preferences)
		defaults import com.mowglii.ItsycalApp /Volumes/jwadleig/Library/Preferences/com.mowglii.ItsycalApp.plist
	- Disable clock in menubar from SysPref
	- Configure Slack (add workspaces)
	- Configure screen saver to point to ~/Pictures/images
	- Customize left panel of Finder application (add favoritate locations)

## Notable Mac commandline tools

The following tools are some fun and useful tools I have found. Some come with the Mac OS and some can be installed.

### dot_clean
Mac file systems and FAT32. You might notice when working with FAT32 file systems (often on USB drives) that there are files created with a dot-underscore prefix (._). These are created in order to handle the different attributes that are managed by the different file systems. You can clean them using the not-so-famous 'dot_clean' tool that comes with the Mac OSX.

```shell
$ cd /Volumes/USBDRIVE/
$ dot_clean -m .
```

### ditto
https://developer.apple.com/legacy/library/documentation/Darwin/Reference/ManPages/man1/ditto.1.html

### say
https://developer.apple.com/legacy/library/documentation/Darwin/Reference/ManPages/man1/say.1.html
https://pypi.python.org/pypi/SpeechRecognition/

### caffeinate
https://developer.apple.com/legacy/library/documentation/Darwin/Reference/ManPages/man8/caffeinate.8.html

### banner
banner -w [the width of the banner in pixels] [your message]

### pbcopy and pbpaste
Provide copying and pasting to the pasteboard (the Clip-board) from command line
http://osxdaily.com/2007/03/05/manipulating-the-clipboard-from-the-command-line/

## Author

This was written by [John Wadleigh](http://ansiblejunky.com/), based on my personal need to automate everything.
