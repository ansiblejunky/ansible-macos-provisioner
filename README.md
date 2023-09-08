# Ansible macOS Provisioner

This repo helps provision a brand new or existing `macOS` system.

Some basics before you begin to provision your system. This tool requires `Ansible` and `Homebrew` to perform the installations. Why these tools? Ansible is a beautiful automation software. Homebrew is the best package management software for macOS systems. These two are meant for each other when it comes to provisioning a macOS.  If I lost you already, don't worry about it. The tool installs all dependencies necessary for a beautiful easy automated installation. So kick back and relax.

## Step 1 - Prepare

Prepare system:

- (optional) System Preferences -> Trackpad -> Disable "Force Click and haptic feedback"
- Launch Mac App Store and authenticate using your Apple iCloud Account
- Launch Terminal app
  - Run `git` command to install x-tools
  - Clone this repo: `git clone https://github.com/ansiblejunky/ansible-macos-provisioner.git`
  - Configure [vim](https://www.linode.com/docs/guides/introduction-to-vim-customization/) editor: `cp data/.vimrc ~/.vimrc`
- Run `./install_system.sh` to install basic system requirements such as `x-tools`
- Run `./install_brew.sh` to install homebrew package manager on your Mac
- Run `./install_python.sh` to install a python environment using `pyenv` and `ansible`
- Backup/Restore to New Laptop
  - Launch backup software on old system
  - Select backup of specific folders
  - Perform the backup to external device (USB Harddrive, Cloud, etc)
  - Install your backup software on new system: `brew install carbon-copy-cloner`
  - Register the software
  - Restore to the new system
  - Copy manually other selected files/folders (`.ssh` folder, `.` files, etc)

## Step 2 - Automation

Install the software:

- Customize the [software defined](./data/vars.yml) for your system
- Run `ansible-playbook -v install_software.yml --ask-become-pass` to install software. Some software will require your password so this asks for it in the beginning so you can go get a coffee
- Done!

## Step 3 - Post Configuration

Other things not automated yet, but common tasks to take care of.

- Browser configuration
  - Launch Brave Browser
  - Configure Sync to get extensions, tabs, settings from old laptop browser
  - Navigate to Brave -> History to get opened tabs that were synced from old laptop
- Yubikey configuration (see instructions below)
- iTerm2 configuration
  - Preference -> Advanced -> Mouse Tab, set `Scroll wheel sends arrow keys when in alternate screen mode` to Yes
  - Configure zsh: `cp data/.zprofile ~/.zprofile`
  - Install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh#basic-installation)
- WebCatalog configuration; install these apps
  - Gmail
  - Google Keep
  - Chat GPT
  - Google Chat
- Conference tools configuration
  - Test all conference tools to ensure they can share screens and mic works, etc. (this usually requires a lot of approvals for Mac security)
- Printer configuration in System Preferences

## Visual Studio Code

The following is my custom configuration of VSCode:

[Extensions](https://code.visualstudio.com/docs/editor/extension-marketplace#_command-line-extension-management):

```shell
# Ansible
code --install-extension redhat.ansible
# TODO Highlight
code --install-extension wayou.vscode-todo-highlight
# VSCode Remote Developer
code --install-extension ms-vscode-remote.vscode-remote-extensionpack
# VSCode PDF Reader
code --install-extension tomoki1207.pdf
```

Settings (edit `$HOME/Library/Application\ Support/Code/User/settings.json`):

```json
{
  "window.title": "${rootName}${separator}${profileName}",
  "workbench.tree.indent": 20
}
```

Open Windows:

```shell
# Open windows with common folders
code ~/Projects/customers
code ~/Projects/ansible-automation-journey
code ~/Projects/ansible-role-template
code ~/Projects/ansible-project-template
code ~/Projects/ansible-networking
```


## Yubikey

Use the following steps to install and configure your Yubikey on your new Mac.

- Install Yubikey Manager tool: `brew install yubico-yubikey-manager`
- Start Yubikey Manager app
- Plug the Yubikey device into a Mac slot
- App should recognize it and display icon and firmware info
- Select "Applications" from the top

Slot 1 is for "short touch", Slot 2 is for "long touch" so you can setup 2 slots to manage 2 systems and out-of-the-box Yubikey configures slot 1 to work with their website. I don't care about connecting to Yubico and I prefer having the short touch mechanism, so I did the following...

- Select "Delete" on slot 1 to remove the existing configuration
- Select "Configure" on slot 1
- Select "OATH-HOTP" option
- To get a "Secret Key" we need to generate that from RH website
  - Connect to Red Hat's VPN using Viscosity software and your current FreeOTP app on your phone
  - Navigate to https://token.redhat.com/ and login using kerberos credentials
  - Select "Create Software Token" from left-hand panel
  - ensure "Generate OTP Key on the Server" is enabled
  - enter a Description of the token
  - enter the PIN you want (probably same you had before)
  - select "Enroll Token" button
  - Use the FreeOTP app on your phone to scan the QR code (it may ask for the issuer - use 'Red Hat')
- On the website, there is a link at the top to get the URL when you do not have a QR scanner. Use that and it shows you the Secret Key in the URL it generates. 
- Place the secret key string into the Yubico Manager app - the last we left it sitting on a page where it requests the secret key. Ensure it has 6 digits set as well.
- Select "Finish" on the Yubico Manager app and it configures the slot correctly.
- Go back to the Red Hat token.redhat.com site and use the testing page to test your PIN and TOKEN. If necessary sync the token. 
- You should get success on the sync and also testing it using the "TEST TOKEN" area on the bottom. 
- You're done! Dang!

## Where to find software

To find other homebrew software and formulae, use the following links.

- http://brewformulas.org
- http://macappstore.org/

For the best free Mac applications, look here: http://thriftmac.com

## Improvements

- TODO: Fix Ansible tasks for shortcuts, links
- Automate postman preferences and saved environments (export them and then import them)
- Automate iTerm2 preferences; for now backup your iTerm2 preferences using these commands
  - Copy preferences file: `cp ~/Library/Preferences/com.googlecode.iterm2.plist data/`
  - Convert from binary to XML format: `plutil -convert xml1 data/com.googlecode.iterm2.plist`
  - More information [here](https://apple.stackexchange.com/questions/111534/iterm2-doesnt-read-com-googlecode-iterm2-plist/111559#111559)
- Automate docked items
- Configure screen saver and wallpaper to point to `Pictures/images`
- Pages (verify book opens)
- GarageBand (transfer files)
- Register the Carbon Copy Cloner software
- Register Tuxera NTFS (for windows USB drives)
- Automate install of other stuff
  - Install Keka as archive utility (or izip)
  - Install and run Malwarebytes
  - Install and run Bitdefender Virus Scanner
  - Install and register Telegram
  - iBooks Author - verify books open; Documents/Books/...
  - BookWright (Blurb application)
  - Install and register easyHDR3
  - Install and register Panorama Maker
  - Install and register [Photomatix Pro 6](https://www.hdrsoft.com/download/photomatix-pro.html)
  - Amazon Music
  - Install printer and HP Easy Scan (verify scanner)
  - XnConvert (convert multiple images): `brew cask install xnconvert`
  - [Balena Etcher](https://www.balena.io/etcher/) disk burning tool: `brew cask install balenaetcher`
  - Install wireshark
  - Install gimp as image editor tool

## Notable Mac commandline tools

The following tools are some fun and useful tools I have found. Some come with the Mac OS and some can be installed.

### dot_clean

Mac file systems and FAT32. You might notice when working with FAT32 file systems (often on USB drives) that there are files created with a dot-underscore prefix (._). These are created in order to handle the different attributes that are managed by the different file systems. You can clean them using the not-so-famous 'dot_clean' tool that comes with the macOS.

```shell
cd /Volumes/USBDRIVE/
dot_clean -m .
```

### ditto

https://ss64.com/osx/ditto.html

### say

Use Ansible [say](https://docs.ansible.com/ansible/latest/collections/community/general/say_module.html) module to say things while the Playbook is running.

More information:
- https://ss64.com/osx/say.html
- https://pypi.python.org/pypi/SpeechRecognition/

Examples:

```shell
 # List all voices:
 say -v ?

 # List English-speaking voices:
 say --voice='?' |grep "en[_-]"

 say "Starting Ansible Automation" -v Samantha
 ```

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
