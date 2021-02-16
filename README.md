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
  - NOTE: This is useful to automate installation of your Mac App Store purchases
  - Authenticate in Mac App Store
- Launch Safari app
  - NOTE: We don't have Google Chrome installed yet, so we use what we have. We will automate the install of our favorite browser using Ansible later.
  - Navigate to GitHub.com
  - Login to GitHub.com
  - Generate personal access token
- Launch Terminal app
  - Change default shell: `chsh -s /bin/bash`
  - Run `git` to install x-tools
  - Clone repo for this repo (ansible-osx-provisioner)
    - `git clone <repo>`
    - authenticate using username + personal-access-token
  - Run `./initialize.sh` to prepare Mac with home-brew, pyenv, and install python virtualenv with ansible
  - Run `ansible-playbook playbook.yml --ask-become-pass` to install software
- Launch Google Chrome
  - Login and sync (this gets extensions, and current tab/window state from previous laptop)
- Launch your backup software
  - Login and restore from backup? I prefer to auto install from fresh and only restore documents, etc.
- Other things
  - Copy ssh keys from original laptop (maybe use bluetooth or ssh?)
  - Setup Yubikey (see instructions below)
  - Test all conference tools to ensure they can share screens and mic works, etc. (this usually requires a lot of approvals for Mac security)
  - Configure printer in SysPrefs
  - Install VSCode extensions; configure Workspaces extension
    - Extensions
    - Settings:
      - WrapTabs
      - Workbench Decorations: Color
      - Workbench Decorations: Badges
      - Workbench › Tree: Indent = 30

## Red Hat Setup

The following are specific to a Red Hat laptop.

### Managed Software

Install Managed Software Center from Mojo to add VPN software, etc. To login to Mojo, you will need to already have your token setup on your phone to get into the VPN to access the Mojo site.

### Yubikey Installation

Use the following steps to install and configure your Yubikey on your new Mac.

- download Yubikey Manager tool using homebrew: `brew cask install homebrew/cask-drivers/yubico-yubikey-manager`
- start Yubikey Manager app
- put Yubikey device into Mac slot
- app should recognize it and display icon and firmware info
- select "Applications" from top
- Slot 1 is for "short touch", Slot 2 is for "long touch" so you can setup 2 slots to manage 2 systems and out-of-the-box Yubikey configures slot 1 to work with their website.

I don't care about connecting to Yubico and I prefer having the short touch mechanism, so I did the following...

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
- Automate iterm2 preferences
- Installing virtualbox requires approval of software extension so it fails on first attempt
- Automate google chrome preferences and extensions
- Automate docked items
- Maybe ignore_errors: true in case a brew install fails 
- Automate the activation of Tuxera NTFS software
- Migrate Itsycal preferences from one laptop to another
  - Copy/backup the following file from old laptop:  
    `cp ~/Library/Preferences/com.mowglii.ItsycalApp.plist <destination>`
  - Run the following command to import the plist file (preferences)  
    `defaults import com.mowglii.ItsycalApp /Volumes/jwadleig/Library/Preferences/com.mowglii.ItsycalApp.plist`
  - Disable clock in menubar from SysPref
- Configure Slack (add workspaces)
- Configure screen saver and wallpaper to point to `Pictures/_wallpapers_`
- Customize left panel of Finder application (add favoritate locations)
- startup windows VM and checkout if my visual studio application works at all and decide what to do with all of this stuff!? push to GitHub?
Projects/cleanup/siebel-visual-basic-projects
- Pages (verify book opens)
- GarageBand (transfer files)
- Register the Carbon Copy Cloner software
- Register Tuxera NTFS (for windows USB drives)
- Automate install of other stuff
  - Install Keka as archive utility (or izip)
  - Install and run Malwarebytes
  - Install and run Bitdefender Virus Scanner
  - Install and register Telegram
  - Install and register WhatsApp
  - iBooks Author - verify books open; Documents/Books/...
  - BookWright (Blurb application)
  - Install and register easyHDR3
  - Install and register Panorama Maker
  - Install and register [Photomatix Pro 6](https://www.hdrsoft.com/download/photomatix-pro.html)
  - Amazon Music
  - HP Easy Scan (verify scanner)
  - XnConvert (convert multiple images): `brew cask install xnconvert`
  - [Balena Etcher](https://www.balena.io/etcher/) disk burning tool: `brew cask install balenaetcher`
  - Install wireshark
  - Install tmux
  - Install nmap
  - Install ruby and rbenv to create ruby environment to manage github pages website using jekyll
  - Install dbeaver-community as DB manager tool
  - Install and configure keepassx using Brew `brew install keepassx`
  - Install gimp as image editor tool
- From App Store
  - Free MP4 Converter
  - Night Sky
  - Loopback (for external monitor sound)

## Notable Mac commandline tools

The following tools are some fun and useful tools I have found. Some come with the Mac OS and some can be installed.

### dot_clean

Mac file systems and FAT32. You might notice when working with FAT32 file systems (often on USB drives) that there are files created with a dot-underscore prefix (._). These are created in order to handle the different attributes that are managed by the different file systems. You can clean them using the not-so-famous 'dot_clean' tool that comes with the Mac OSX.

```shell
cd /Volumes/USBDRIVE/
dot_clean -m .
```

### ditto

https://ss64.com/osx/ditto.html

### say

https://ss64.com/osx/say.html
https://pypi.python.org/pypi/SpeechRecognition/

### caffeinate

https://ss64.com/osx/caffeinate.html

### banner

banner -w [the width of the banner in pixels] [your message]

### pbcopy and pbpaste

Provide copying and pasting to the pasteboard (the Clip-board) from command line
http://osxdaily.com/2007/03/05/manipulating-the-clipboard-from-the-command-line/

### Multiple File Renamer

You may need to rename multiple files at the same time, to conform to some naming convention. 

Option #1: Use the Finder and this [blog](https://tidbits.com/2018/06/28/macos-hidden-treasures-batch-rename-items-in-the-finder/)

Option #2: brew install rename
http://plasmasturm.org/code/rename/

## Author

This was written by [John Wadleigh](http://ansiblejunky.com/), based on my personal need to automate everything.
