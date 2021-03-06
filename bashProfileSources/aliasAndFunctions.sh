#!/bin/bash

#LIST OF ALIAS

# for quick modification to my alias, bash profile, exports
alias modify_bash_profile="code $HOME/.bash_profile"
alias modify_bash_rc="code $HOME/.bashrc"
alias modify_alias_functions="code $HOME/shellscripts/bashProfileSources/aliasAndFunctions.sh"
alias modify_exports="code $HOME/shellscripts/bashProfileSources/exportList.sh"
alias runWTF='make -C $HOME/go/src/github.com/senorprogrammer/wtf/ run'
# airportCard control shortcut
alias network_device='networksetup -listallhardwareports'
alias turn_wifi_off='networksetup -setairportpower airport off'
# networksetup -setairportpower en0 off can be used instead
alias turn_wifi_on='networksetup -setairportpower airport on'
# networksetup -setairportpower en0 on can be used insteadexport PATH="$HOME/.rbenv/bin:$PATH"

# Generic shell command short cuts
alias findCommandPath="type -a"
alias deleteDownloads="rm -ri $HOME/Downloads/*"
#alias for opening another charles session
alias charlesNAOpen="open -na charles"
# to own the file (allow me to modify/execute)
alias permission="chmod +x "
# making ccat to cat
alias cat='ccat'

# ANDROID SDK alias'
alias uiautomator="$HOME/Library/Android/sdk/tools/bin/uiautomatorviewer"
alias listAllAVD="$HOME/Library/Android/sdk/emulator/emulator -list-avds"
alias startAndroidVirtualDevice="$HOME/Library/Android/sdk/emulator/emulator "

# android debug bridge command shortcuts
alias grabActivity="adb shell dumpsys window windows | grep -E 'mCurrentFocus|mFocusedApp'"
alias screenrecord='adb shell screenrecord /sdcard/recording.mp4'
alias pullRecording='adb pull /sdcard/recording.mp4; mv recording.mp4 $HOME/Desktop/; adb shell rm -rf /sdcard/recording.mp4'
alias screenshot='adb shell screencap /sdcard/Pictures/screenshot.png; adb pull /sdcard/Pictures/screenshot.png; mv screenshot.png $HOME/Desktop/; adb shell rm -rf /sdcard/Pictures/screenshot.png'
# for wireless ADB connection. This should help me logcat wirelessly allowing for multiple device connections
alias setDeviceTCPIP='adb tcpip 5555'

# ShellScript shortcuts
alias adbMulti='$HOME/shellscripts/adbMulti/adbMulti.sh'
alias uninstall='adbMulti uninstall'
alias hockey='$HOME/shellscripts/hockey/hockeyCLTool.sh'
alias depMan="$HOME/shellscripts/dependencyManager/dependencyManager.sh"
alias mtr="sudo mtr"
alias adbSingle='$HOME/shellscripts/adbSingle/adbSingle.sh'
alias convertVideoToGif="$HOME/shellscripts/external/video_to_gif_osx.sh"
alias crypter="$HOME/shellscripts/cryptKeeper/cryptKeeper.sh"

function decodebase64 (){
	echo "$1" | base64 --decode > ~/Desktop/decode.txt ; code ~/Desktop/decode.txt
	# open text file piping this data back
}

# mongodb shortcuts (commentted out since im not using)
# alias start_mongo="mongod"
# alias connect_mongo="mongo"


# kinesis command line functions
function runKinesisTest(){
	node ~/dev/charles_session_parser/kinesisrecords.js
}

function parseKinesisLogs(){
	Charles convert ~/Downloads/session.chls ~/Downloads/session.chlsj
	node ~/dev/charles_session_parser/kinesisrecords.js > ~/Desktop/kinesisFormatted.txt
	subl ~/Desktop/kinesisFormatted.txt
	mv ~/Downloads/session.* ~/Desktop/charles_logs/
}

function wipeKinesisData(){
	rm -rf ~/Desktop/charles_logs/*.*
	rm -rf ~/Desktop/kinesisFormatted.txt
}

# epoch time conversion
function epochConvert(){
	date -r "$(($1/1000))"
}

function consent_string_decode(){
	node /Users/tomkim/dev/daisybit/main.js "$1" "$2"
}


# running fuck on the last command - https://github.com/nvbn/thefuck
eval $(thefuck --alias fuck)

# Functions
function clearAppiumTestInstall(){
	adbMulti uninstall "$APPIUM_UNLOCK"
	adbMulti uninstall "$APPIUM_SETTING"
	adbMulti uninstall "$APPIUM_UIAUTO_SERV"
	adbMulti uninstall "$APPIUM_UIAUTO_SERV_TEST"
}
#Android command for setting app to idle state
function setIdle(){
	echo "Setting idle state on APP: $1"
	adb shell am set-inactive "$1" true
	adb shell dumpsys deviceidle force-idle
	echo "WAIT AT LEAST 2-3 MIN FOR APP TO HIT IDLE STATE!"
}
# https://askubuntu.com/questions/68175/how-to-create-script-with-auto-complete (adding auto complete options)
function autoCompHockeyCommand(){
	COMPREPLY=("download" "list" "list-version")
}
complete -F autoCompHockeyCommand hockey

# starting bandit
function startBandit(){
	ssh bandit$1@bandit.labs.overthewire.org -p 2220
}
# function to simplify git add and commits
function git_commit_super(){
	git add "$1"
	# adding esacpe character so the input isnt accepting it as multi arg
	git commit -m "\"$2\""
}