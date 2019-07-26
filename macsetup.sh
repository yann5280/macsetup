#! /bin/bash

txtflash=$(tput setaf 3) #yellow
txtblack=$(tput setaf 7)
todo="\n########\n# TODO #\n########\n"

############
# Top apps #
############

#Brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew analytics off
brew install bash-completion
brew tap caskroom/cask
brew tap buo/cask-upgrade
brew tap homebrew/cask-fonts
brew tap dteoh/sqa

#iTerm
brew cask install iterm2
open -a iTerm

#NordVPN
brew cask install nordvpn
open -a NordVpn

#Mac App Store command line interface
brew install mas

#Visual Studio Code
brew cask install visual-studio-code
code --install-extension Shan.code-settings-sync
code
brew cask install open-in-code
todo+="- move open-in-code in Finder's toolbar"
todo+="\n"

#Chrome
brew cask install google-chrome
open -a "Google Chrome"

#1Password
brew cask install 1password
open -a "1Password 7"

#Dropbox
brew cask install dropbox
open -a Dropbox

#Evernote
mas install 406056744
open -a Evernote

#Todoist
mas install 585829637
open -a Todoist

#Typora
brew cask install typora

#Alfred
brew cask install alfred
open -a "Alfred 3"
todo+="- Remove the spotlight keyboard shortcut and set the Alfred one"
todo+="\n"

#Amphetamine
mas install 937984704

#Bartender
brew cask install bartender
open -a "Bartender 3"

#Hammerspoon
brew cask install hammerspoon
rm -rf ${HOME}/.hammerspoon
ln -s ~/Documents/code/macsetup/init.lua ~/.hammerspoon/init.lua
open -a Hammerspoon

#Karabiner-Elements
brew cask install karabiner-elements
ln -s ~/Documents/code/macsetup/karabiner/ ~/.config

#Shush
mas install 496437906
open -a Sush

#Evernote
mas install 406056744
open -a Evernote

#Todoist
mas install 585829637
open -a Todoist

#Slack
brew cask install slack
open -a Slack

#Messenger
brew cask install Messenger

#Spotify
brew cask install spotify

#Slow Quit Apps
brew cask install slowquitapps

#Contexts
brew cask install contexts


######################
# Git configurations #
######################
git config --global user.name "Frédéric Harper"
git config --global user.email fharper@oocz.net
git config --global push.default current
git config --global difftool.prompt false
git config --global diff.tool vscode
git config --global difftool.vscode.cmd 'code --diff --wait $LOCAL $REMOTE'

gpg --list-secret-keys --keyid-format LONG
echo "Copy & paste your public key UUID listed below (line sec - after the /)"
read gpgUUID
git config --global user.signingkey $gpgUUID
git config --global commit.gpgsign true

curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

brew install git-lfs


######################
# Command line tools #
######################
npm install -g trash-cli
brew install wifi-password
git clone https://github.com/rupa/z.git ~/z
curl -sLo- http://get.bpkg.sh | bash


######################
# bash profile stuff #
######################
ln -s ~/Documents/code/macsetup/.bash_profile ~/.bash_profile
ln -s ~/Documents/code/macsetup/.bashrc ~/.bashrc
source ~/.bashrc


#####################
# OS Configurations #
#####################

#Dock: minimize window into application icon
defaults write com.apple.dock minimize-to-application -bool true

#Generate the locate database
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

#Show Users Library folder
chflags nohidden ~/Library/

#Create the symlinks between system folders and Dropbox before the sync start
mkdir ~/Dropbox
ln -s ~/Music/ ~/Dropbox
ln -s ~/Movies/ ~/Dropbox
ln -s ~/Downloads/ ~/Dropbox
ln -s ~/Documents/ ~/Dropbox

#Allow Apps from anywhere to be installed without warnings
sudo spctl --master-disable

#Disable the accent characters menu
defaults write -g ApplePressAndHoldEnabled -bool false

#Disable the look up & data detector on Trackpad
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool false
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerTapGesture -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -bool false

#Disable Mission Control and Exposé Gestures on Trackpad
defaults write com.apple.dock showAppExposeGestureEnabled -bool false
defaults write com.apple.dock showMissionControlGestureEnabled -bool false
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerVertSwipeGesture -bool false
defaults -currentHost write NSGlobalDomain com.apple.trackpad.fourFingerVertSwipeGesture -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerVertSwipeGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseTwoFingerDoubleTapGesture -bool false

#Disable Show Notification Center on Trackpad
defaults -currentHost write NSGlobalDomain com.apple.trackpad.twoFingerFromRightEdgeSwipeGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -bool false

#Disable Launchpad and Show Desktop Gestures on Trackpad
defaults write com.apple.dock showDesktopGestureEnabled -bool true
defaults write com.apple.dock showLaunchpadGestureEnabled -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.fourFingerPinchSwipeGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerPinchGesture -bool false
defaults -currentHost write NSGlobalDomain com.apple.trackpad.fiveFingerPinchSwipeGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadFiveFingerPinchGesture -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFiveFingerPinchGesture -bool false

echo -e "\n"
read -p "${txtflash}Deactivate the Force click and haptic feedback from Trackpad manually" -n1 -s
echo -e "\n"

echo -e "\n"
read -p "${txtflash}Deactivate Show recent applications in Dock from the Dock manually" -n1 -s
echo -e "\n"

#Activate Silent clicking
defaults write com.apple.AppleMultitouchTrackpad ActuationStrength -int 0

#Disable Guest Account
sudo defaults write /Library/Preferences/com.apple.AppleFileServer guestAccess -bool false
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool false

#Finder display settings
defaults write com.apple.finder FXArrangeGroupViewBy -string "Name"
defaults write com.apple.finder ShowRemovableMediaOnDesktop -boolean false
defaults write com.apple.finder ShowRecentTags -boolean false
defaults write com.apple.finder ShowHardDrivesOnDesktop -boolean false
defaults write com.apple.finder ShowStatusBar -boolean true
defaults write com.apple.finder FXEnableExtensionChangeWarning -boolean false
defaults write com.apple.finder ShowPathbar -bool true

#New Finder windows in my Downloads folder
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Downloads"

#Prevent .DS_Store File Creation on Network Volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

#Show all files extensions
defaults write -g AppleShowAllExtensions -bool true

#Volume - Don't play feedback on volume change
defaults write NSGlobalDomain com.apple.sound.beep.feedback -int 0

#Deactivate the Chrome Printing Dialog
defaults write com.google.Chrome DisablePrintPreview -bool true

#Add extra system menuitems
defaults write com.apple.systemuiserver menuExtras -array \
"/System/Library/CoreServices/Menu Extras/Volume.menu" \
"/System/Library/CoreServices/Menu Extras/Bluetooth.menu"

# Set computer name
sudo scutil --set ComputerName "lapta"
sudo scutil --set HostName "lapta"
sudo scutil --set LocalHostName "lapta"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "lapta"

#Expand save panel
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

#Search the current folder by default in Finder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

#Deactivate Play user interface sound effects
todo+="- Deactivate Play user interface sound effects"
todo+="\n"

#delete defaults apps
brew install dockutil
sudo rm -rf /Applications/Numbers.app
dockutil --remove 'Numbers' --allhomes
sudo rm -rf /Applications/Keynote.app
dockutil --remove 'Keynote' --allhomes
sudo rm -rf /Applications/Pages.app
dockutil --remove 'Pages' --allhomes
sudo rm -rf /Applications/GarageBand.app

#remove apps from dock
dockutil --remove 'Books' --allhomes
dockutil --remove 'Maps' --allhomes
dockutil --remove 'Reminders' --allhomes
dockutil --remove 'FaceTime' --allhomes
dockutil --remove 'Notes' --allhomes
dockutil --remove 'System Preferences' --allhomes
dockutil --remove 'Calendar' --allhomes
dockutil --remove 'Mail' --allhomes
dockutil --remove 'Contacts' --allhomes
dockutil --remove 'Siri' --allhomes
dockutil --remove 'Launchpad' --allhomes
dockutil --remove 'Safari' --allhomes
dockutil --remove 'App Store' --allhomes
dockutil --remove 'iTunes' --allhomes

#Kill apps
killall Finder
killall Dock
killall SystemUIServer

#Gray
brew cask install gray
todo+="- Change Chrome to light appareance with Gray"
todo+="\n"


#####################
# Install dev stuff #
#####################

#Install pip
curl https://bootstrap.pypa.io/get-pip.py > get-pip.py
sudo python get-pip.py
rm get-pip.py

#Ruby stuff
brew install rbenv
rbenv init
rbenv install 2.5.3
rbenv global 2.5.3

#Install Bundle (Gem/Ruby)
gem install bundler

#Xcode (before Antibody)
mas install 497799835
open -a Xcode

#Antibody
brew install getantibody/tap/antibody

#Git PR open
antibody bundle caarlos0/open-pr kind:path

#Gulp
npm install -g gulp-cli

#Hub (for Github)
brew install hub

#Docker
brew cask install docker
brew cask install kitematic

#Prevent code to show in Alfred
brew install tag
tag -a alfred:ignore -R ~/Documents/Code
cp -R ~/Documents/configs/Alfred\ -\ Code.workflow/ ~/Desktop/Alfred\ -\ Code.workflow/
open ~/Desktop/Alfred\ -\ Code.workflow/
tag -a alfred:ignore -R ~/Dropbox
cp -R ~/Documents/configs/Alfred\ -\ Dropbox.workflow/ ~/Desktop/Alfred\ -\ Dropbox.workflow/
open ~/Desktop/Alfred\ -\ Dropbox.workflow/
tag -a alfred:ignore -R ~/Music
cp -R ~/Documents/configs/Alfred\ -\ Music.workflow/ ~/Desktop/Alfred\ -\ Music.workflow/
open ~/Desktop/Alfred\ -\ Music.workflow/

#Generate a new public SSH key
ssh-keygen -t rsa -b 4096 -C "fharper@oocz.net"
ssh-add -K ~/.ssh/id_rsa
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
ssh-keyscan -t rsa bitbucket.org >> ~/.ssh/known_hosts
pbcopy < ~/.ssh/id_rsa.pub
open https://github.com/settings/keys
echo -e "${txtflash}Add SSH key to Github (copied in the clipboard)"
open https://bitbucket.org/account/user/fharper/ssh-keys/
read -p "${txtflash}Add SSH key to Bitbucket (copied in the clipboard)" -n1 -s
echo -e "\n"

#Node stuff
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash
nvm install v10.13.0
nvm alias default v10.13.0
npm install -g npm@latest
npm config set prefix /usr/local
npm config set editor code
npm config set sign-git-tag true
npm adduser
npm install -g express-generator
npm install -g nodemon
npm install -g npx
npm install -g npm-remote-ls

#DigitalOcean Specific
brew install doctl
doctl auth init
#AWS S3/DigitalOcean Spaces CLI
brew install s3cmd
s3cmd --configure

#Kubernetes CLI
brew install kubernetes-cli

#Nodeschool workshops (all)
npm install -g learnyou

#Java stuff
brew install jenv
brew cask install java
jenv add /Library/Java/JavaVirtualMachines/openjdk-11.0.1.jdk/Contents/Home/
jenv global openjdk64-11.0.1

#Go
brew install go

#Rust
curl https://sh.rustup.rs -sSf | sh

#JavaScript
npm install -g uglify-js

#HTML
npm install -g html-minifier

#CSS
npm install -g cssnano-cli

#Images
npm install -g imagemin-cli
npm install -g imagemin-pngquant
npm install -g imagemin-jpegtran

#Accessibility
npm install -g pa11y

#Git scripts
npm install -g git-open
npm install -g git-recent
npm install -g git-branch-status

#Python stuff
brew install pyenv
pyenv install 3.7.0
pyenv global 3.7.0

#Mysql Shell
brew cask install mysql-shell

#MongoDB
brew install mongodb

#YARN
brew install yarn

#ShellCheck
brew install shellcheck

#Projects contributions
npm install -g weallcontribute

#Ripgrep
brew install ripgrep

#Bundle Phobia
npm install -g bundle-phobia-cli

#Yeoman
npm install --global yo

#Quicklook JSON
brew cask install quicklook-json


############################
# Install the applications #
############################

#Antidote
todo+="- Download & install Antidote (see the link in 1Password) "
todo+="\n"

#AppCleaner
brew cask install appcleaner

#Asciinema
brew install asciinema

#AutoMute
mas install 1118136179

#Battery Stats for AirPods
mas install 1405763798

#Battle.net (Diablo II, World of Warcraft)
brew cask install battle-net
open -a /usr/local/Caskroom/battle-net/latest/Battle.net-Setup.app
ln -sf ~/Documents/misc/Diablo/ /Applications/Diablo\ II/save

#Boxer
brew cask install boxer

#Brave browser
brew cask install brave-browser

#Calibre
brew cask install calibre

#Camtasia
brew cask install camtasia
todo+="- Add your license to Camtasia"
todo+="\n"

#Cryptomator
brew cask install cryptomator

#DaisyDisk
brew cask install daisydisk
todo+="- Add your license to DaisyDisk"
todo+="\n"

#Deckset
brew cask install deckset

#Discord
brew cask install discord

#Duplicate Photo Fixer Pro
mas install 963642514

#FileZilla
brew cask install filezilla

#Firefox
brew cask install firefox

#Fliqlo screensaver
brew cask install fliqlo
defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName fliqlo path ~/Library/Screen\ Savers/Fliqlo.saver/ type 0

#Gimp
brew cask install gimp

#ICS split
#icssplit file.ics outfilename --maxsize=900000
pip3 install icssplit

#Keybase
brew cask install keybase

#Keycastr
brew cask install keycastr

#Krita
brew cask install krita

#Larch
gem install larch

#LZip
brew install lzip

#Mate Translate
mas install 1005088137

#Menubar Countdown
brew cask install menubar-countdown

#Moom
mas install 419330170
open -a Moom

#MindNode
mas install 992076693

#Noizio
mas install 928871589

#OpenEmu
brew cask install openemu

#Opera
brew cask install opera

#Parcel
mas install 639968404
open -a Parcel

#PDFSam Basic
brew cask install pdfsam-basic

#Pikka - Color Picker
mas install 1195076754

#Pocket
mas install 568494494
open -a Pocket

#Postman
brew cask install postman

#Prey
echo "Enter your Prey API key (found in the left corner of the Prey web dashboard settings page)"
read preyapi
HOMEBREW_NO_ENV_FILTERING=1 API_KEY="$preyapi" brew cask install prey
open /usr/local/lib/prey/current/lib/agent/utils/Prey.app --args -picture

#Rocket
brew cask install rocket

#Signal
brew cask install signal

#Sloth
brew cask install sloth

#Smallpdf
brew cask install smallpdf

#The Clock
mas install 488764545
open -a "The Clock"
todo+="- Remove the System Clock from the menubar"
todo+="\n"

#The Unarchiver
mas install 425424353

#TripMode
brew cask install tripmode
open -a TripMode

#Unrar
brew install unrar

#Vivaldi
brew cask install vivaldi

#VLC
brew cask install vlc

#WhatsApp
brew cask install whatsapp

#WiFi Explorer Lite
mas install 1408727408

#Zoom
brew cask install zoomus

#Zoom It
mas install 476272252

#####################
# Install the Fonts #
#####################
brew cask install font-fira-sans

for filename in ~/Documents/Programmes/Mac/Fonts/*.*; do
        echo $filename
    done
done


##########################################
# Change file type default association ###
##########################################
#How to find the app bundle identifier: 
# mdls /Applications/Photos.app | grep kMDItemCF
#How to find the Uniform Type Identifiers
# mdls -name kMDItemContentTypeTree /Users/fharper/Documents/init.lua
brew install duti
duti -s org.videolan.vlc public.mpeg-4 all #mp4
duti -s org.videolan.vlc com.apple.quicktime-movie all #mov
duti -s com.microsoft.VSCode public.plain-text all #txt
duti -s com.microsoft.VSCode dyn.ah62d4rv4ge8027pb all #lua
duti -s org.videolan.vlc public.avi all #avi
duti -s org.videolan.vlc public.3gpp all #3gp
duti -s com.apple.Preview com.nikon.raw-image all #NEF
duti -s com.microsoft.VSCode net.daringfireball.markdown all #Markdown
duti -s com.google.Chrome public.svg-image all #SVG
duti -s net.kovidgoyal.calibre org.idpf.epub-container all # ePub
duti -s com.microsoft.VSCode public.shell-script all #Shell script
duti -s com.microsoft.VSCode com.apple.log all #log
duti -s com.microsoft.VSCode public.comma-separated-values-text all #CSV
duti -s com.microsoft.VSCode public.data all #yml
duti -s com.microsoft.VSCode public.xml all #xml
duti -s com.microsoft.VSCode public.json all #json
duti -s com.microsoft.VSCode public.php-script all #php


#####################
# Add login items ###
#####################
osascript -e 'tell application "System Events" to make login item at end with properties {name: "Antidote", path:"/Applications/Antidote.app", hidden:false}'
osascript -e 'tell application "System Events" to make login item at end with properties {name: "CapSee", path:"/Applications/CapSee.app", hidden:false}'
osascript -e 'tell application "System Events" to make login item at end with properties {name: "Evernote", path:"/Applications/Evernote.app", hidden:false}'
osascript -e 'tell application "System Events" to make login item at end with properties {name: "Google Chrome", path:"/Applications/Google Chrome.app", hidden:false}'
osascript -e 'tell application "System Events" to make login item at end with properties {name: "Mate Translator ", path:"/Applications/Mate Translator.app", hidden:false}'
osascript -e 'tell application "System Events" to make login item at end with properties {name: "Menubar Countdown", path:"/Applications/Menubar Countdown.app", hidden:false}'
osascript -e 'tell application "System Events" to make login item at end with properties {name: "RightZoom", path:"/Applications/RightZoom.app", hidden:true}'
osascript -e 'tell application "System Events" to make login item at end with properties {name: "Todoist", path:"/Applications/Todoist.app", hidden:false}'
osascript -e 'tell application "System Events" to make login item at end with properties {name: "TweetDeck", path:"/Applications/TweetDeck.app", hidden:false}'
osascript -e 'tell application "System Events" to make login item at end with properties {name: "Pikka", path:"/Applications/Pikka.app", hidden:false}'

########################
# Add apps in the Dock #
########################
dockutil --add /Applications/Google\ Chrome.app/ --allhomes
dockutil --add /Applications/Visual\ Studio\ Code.app/ --allhomes
dockutil --add /Applications/iTerm.app/ --allhomes
dockutil --add /Applications/Evernote.app/ --allhomes
dockutil --add /Applications/Todoist.app/ --allhomes
dockutil --add /Applications/Messenger.app/ --allhomes
dockutil --add /Applications/1Password\ 7.app/ --allhomes
dockutil --add /Applications/Pocket.app/ --allhomes
dockutil --add /Applications/Spotify.app/ --allhomes
dockutil --add /Applications/Antidote\ 9.app/ --allhomes
dockutil --add /Applications/TweetDeck.app/ --allhomes
dockutil --add /Applications/Slack.app/ --allhomes

######################
# Order apps in Dock #
######################

#list them in inversed order)
dockutil --move 'Antidote' --position beginning --allhomes
dockutil --move '1Password' --position beginning --allhomes
dockutil --move 'Messages' --position beginning --allhomes
dockutil --move 'Messenger' --position beginning --allhomes
dockutil --move 'TweetDeck' --position beginning --allhomes
dockutil --move 'Photos' --position beginning --allhomes
dockutil --move 'Pocket' --position beginning --allhomes
dockutil --move 'Visual Studio Code' --position beginning --allhomes
dockutil --move 'iTerm' --position beginning --allhomes
dockutil --move 'Spotify' --position beginning --allhomes
dockutil --move 'Slack' --position beginning --allhomes
dockutil --move 'Todoist' --position beginning --allhomes
dockutil --move 'Evernote' --position beginning --allhomes
dockutil --move 'Google Chrome' --position beginning --allhomes


#################
# Manual TODO ###
#################

#Other apps
todo+="- Install Apps from the local folder"
todo+="\n"

todo+="\n"
todo+="(copied to keyboard)"
echo -e ${txtflash}$todo${txtblack}
echo -e $todo | pbcopy

#
# Backup of main folders (save some Dropbox transfer time)
#
# rsync -rtvlPh /Users/fharper/Movies/ /Volumes/fharper/Movies/ --delete && rsync -rtvlPh /Users/fharper/Downloads/ /Volumes/fharper/Downloads/ --delete && rsync -rtvlPh /Users/fharper/Pictures/ /Volumes/fharper/Pictures/ --delete && rsync -rtvlPh /Users/fharper/Music/ /Volumes/fharper/Music/ --delete && rsync -rtvlPh /Users/fharper/Documents/ /Volumes/fharper/Documents/ --delete
#
# Restore them on new computer
#
# rsync -rtvlPh /Volumes/fharper/Movies/  /Users/fharper/Movies/ --delete && rsync -rtvlPh /Volumes/fharper/Downloads/ /Users/fharper/Downloads/ --delete && rsync -rtvlPh /Volumes/fharper/Pictures/ /Users/fharper/Pictures/ --delete && rsync -rtvlPh /Volumes/fharper/Music/ /Users/fharper/Music/ --delete && rsync -rtvlPh /Volumes/fharper/Documents/ /Users/fharper/Documents/ --delete