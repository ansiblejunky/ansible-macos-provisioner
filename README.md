# Ansible OSX Provisioner


## Notes

Steps:
- Launch System Prefs app
	- Go to Trackpad
	- Disable "Force Click and haptic feedback"
- Authenticate in Mac App Store
- Launch Safari app
	- navigate to GitHub.com
	- login to GitHub.com
	- generate personal access token
- Launch Terminal app
	- change default shell
	   chsh -s /bin/bash
	- run `git` to install x-tools
	- Clone repo for osx-provisioner
		- `git clone <repo>`
		- authenticate using username + personal-access-token
	- Run `./initialize.sh` to prepare Mac with home-brew, pyenv, and install python virtualenv with ansible
	- Run `ansible-playbook playbook.yml --ask-become-pass` to install software
- Launch Google Chrome
	- login and sync (this gets extensions, and current tab/window state from previous laptop)
- Launch Duplicati app
	- login and restore from backup
- Other things
	- copy ssh keys from original laptop (maybe use bluetooth or ssh?)
        - setup Yubikey
        - Test all conference tools to ensure they can share screens and mic works, etc. (this usually requires a lot of approvals for Mac security)
	- REDHAT: Install Managed Software Center from Mojo to add VPN software, etc.
        - Configure printer in SysPrefs
        - Install VSCode extensions; configure Workspaces extension

TODO: migrate Itsycal preferences from one laptop to another
	- Copy/backup the following file from old laptop:
         cp ~/Library/Preferences/com.mowglii.ItsycalApp.plist <destination>
        - Run the following command to import the plist file (preferences)
         defaults import com.mowglii.ItsycalApp /Volumes/jwadleig/Library/Preferences/com.mowglii.ItsycalApp.plist
        - Disable clock in menubar from SysPref
        - Configure Slack (add workspaces)
        - Configure screen saver to point to ~/Pictures/images
        - Customize left panel of Finder application (add favoritate locations)

- Mac settings
# Reference this webpage for details
# https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/
# System Preferences > Dock > Automatically hide and show the Dock:
defaults write com.apple.dock autohide -bool true

TODO: install postman, and preferences and saved environments (export them and then import them)
TODO: add iterm2 installation steps and handle custom settings
brew cask install iterm2

TODO: installing virtualbox requires approval of software extension so it fails on first attempt
TODO: Install google chrome and extensions
TODO: Manage docked items automatically
 
TODO: remove pyenv pyenv-virtualenv from tasks.yml
TODO: maybe ignore_errors: true in case a brew install fails 

## Yubikey Installation

- download Yubikey Manager tool using homebrew
`brew cask install homebrew/cask-drivers/yubico-yubikey-manager`
- start Yubikey Manager app
- put Yubikey into Mac slot
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


##############################################################
# Prerequisites
#
# We need the Xcode Developer Tools because it provides tools like git and gcc.
# We will use the system provided Python installation to prepare
# it with pip (python package manager) and Ansible (automation tool).
# Using these tools we can automate the provisioning of our system.
# Mac OSX comes with a package management software called easy_install
# but this not the best. We will use the well known and preferred
# tool called Homebrew for installing and upgrading ALL of our software
# requirements. This is great because it will help us maintain our
# installations in the future - e.g. we can upgrade all of our software
# with one command. If you do not know about Homebrew, I suggest you learn
# about it.
##############################################################

## What?
So you just got a brand new Mac and you need all the good stuff to get it up and ready. Been there, done that. So let's not waist time searching around for the best software for your Mac. Just use my OSX-Provisioner tool and get that Mac ready within minutes. 

Take a look at the various tools that are automatically installed. I try to provide notes or links so you have an understanding as to why they are the best solution for your daily needs. 

Some basics before you begin to provision your system. This tool requires Ansible and Homebrew to perform the installations. Why these tools? Ansible is a beautiful automation software. Homebrew is the best package management software for Mac systems. These two are meant for each other when it comes to provisioning a Mac.  If I lost you already, don't worry about it. The tool installs all dependencies necessary for a beautiful easy automated installation. So kick back and relax.

> NOTE: If you already have software installed on your system you should have Homebrew manage these installations. To do that, you simply need to install the software using Homebrew. Typically it will replace the existing installation for you. If not, you might want to try the following tool: https://github.com/exherb/homebrew-cask-replace


## Why?


## How?
```
./start.sh
```

Lists software that is currently installed, and those that will be installed
```
./start.sh status
```

Want more? Have ideas for better tools?

## Where?
To find other homebrew software and formulae, use the following links.

- http://brewformulas.org
- http://macappstore.org/

For the best free Mac applications, look here: http://thriftmac.com

## Extras
If you really want to get fancy with your new laptop, order a laptop skin.
http://www.skinit.com/

NOTE: consider using https://github.com/square/maximum-awesome
NOTE: for zsh shell lovers, consider https://github.com/robbyrussell/oh-my-zsh
NOTE: consider the OSXC simple configuration tool for OS X (see below)

## Notes

### dot_clean
Mac file systems and FAT32. You might notice when working with FAT32 file systems (often on USB drives) that there are files created with a dot-underscore prefix (._). These are created in order to handle the different attributes that are managed by the different file systems. You can clean them using the not-so-famous 'dot_clean' tool that comes with the Mac OSX. 
```
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
