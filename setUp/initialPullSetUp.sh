#!/bin/bash

# ========== GLOBAL VARIABLES ==========


# write logic that setup all the source in to the bash profile
# need to write a readme file here
# need to update the readme in the highlevel directory

function writeToFile(){
	# first param is the text
	# second param is the file to be written to
	echo $1 >> $2
}

function prePopulatedProfile(){
	# list out shit i know im going to need to set up just the shell scripts
	# path to each shell script
	cat<<-EOF
		source $1
	EOF
}

function changePermission(){
	# list all files under shellscript directory
	# then filter out only the shell scripts
	# change permisson so each script is executable
	while read line; do
		chmod +x $line
	done <<< "$(find $HOME/shellscripts/* | grep .sh$)"
}

function sourceAliasAndExports(){
	# need to check if the line exists in some form or way

	local fileToModify="$HOME/.bash_profile"
	
	while read line; do
		echo "writing source for $line to $fileToModify"
		echo ""
		writeToFile "$(prePopulatedProfile $line)" $fileToModify
		echo ""
	# writing all sources from this specific pathing
	done <<< "$(find $HOME/shellscripts/bashProfileSources/* | grep .sh$)"
}

function main(){
	changePermission
	
	# this needs to be modified
	# catches exit 113 from validateSource method
	# it should be the ONLY method to exit with 113
	trap 'sourceAliasAndExports' 8
	validateSourcingIsNeeded

	echo "restart terminal session SetUp Complete"
}


function validateSourcingIsNeeded(){
	# booleans that will set the return condition
	local arrayOfSourceFound=()

	while read lsLine ; do
		# starts with text source | whitespace | anycharacter * | text export found somewhere in the middle | anycharacter * | ends with .sh
		# starts with text source | whitespace | anycharacter * | text alias found somewhere in the middle | anycharacter * | ends with .sh
		if [[ -z "$(egrep '^(source)\s\S*(export)\S*(.sh)$|^(source)\s.*(alias)\S*(.sh)$' $lsLine)" ]]; then
			# filter returned nothing
			arrayOfSourceFound+=(false)
		else
			# filter returned something
			arrayOfSourceFound+=(true)
		fi
	# egrep-ing the output of LS to look for profile OR rc file. grep -e can replace egrep if needed?
	# starts with "source" | whitespace | nonwhitespace * | .sh at the end 
	done <<< "$(ls -a -1 $HOME | egrep '\.bash+_[a-z]*.e$|.bashrc')"
	
	# exit conditions
	# IF BOTH RC AND PROFILE DOES NOT HAVE SOURCE return 8
	# IF ONE of them does have it return 0
	if [[ ${arrayOfSourceFound[0]} || ${arrayOfSourceFound[1]} ]]; then
		exit 0
	else
		exit 8
	fi
}

# setup flow
# - Pull or clone the repo
# - user is going to change permission on this shell file
# - user is going to set up his bash with whatever he needs
# - user is going to change permission on all shell scripts found inside this repo
# - user is going to install all dependencies (just the basics)

# start of script
main