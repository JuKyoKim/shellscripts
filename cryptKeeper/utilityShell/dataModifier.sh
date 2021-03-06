#!/bin/bash

# ===== GLOBAL_VAR ===== #

DEFAULT_HASH_BIT_RATE=256
DEFAULT_ACCOUNT_DATA_PREFORM_PATH=$HOME/shellscripts/cryptKeeper/dataSchemas/accountDataPreformat.txt

# ===== FUNCTIONS ===== #

function hashString(){
	# ARGUMENT 1 = THE STRING TO BE HASHED!
	# ARGUMENT 2 = BIT RATE ITS GOING TO BE HASHED INTO!
	# RETURNS HASHED STRING
	echo $1 | shasum -a $2 | awk '{print $1}'
}

function hashFile(){
	# ARGUMENT 1 = BIT RATE YOU WANT TO HASH IT IN
	# ARGUEMNT 2 = PATH TO FILE
	shasum -a $1 $2
}

function validateHashKey(){
	# simple if conditional that returns false or true
	if [[ $1 = $2 ]]; then
		echo true;
	else
		echo false;
	fi
}

function base64Encode(){
	#ARGUMENT 1 = PATH TO FILE or pipe in String?
	base64 $1
}

function base64Decode(){
	#ARGUMENT 1 = encoded b64 string
	echo "$1" | base64 --decode
}

function writeToFile(){
	#ARGUMENT 1 = item to write
	#ARGUMENT 2 = path to file
	# example
	# testvar="$(userAccountDataFormat),$(userAccountDataFormat)"
	# writeToFile "$(userDataFormat test test1234test "do you like pie sir?" "$(echo $testvar)")" ~/Desktop/test.json
	
	echo $1 > $2
}

function userDataFormat(){
	# ARGUMENT 1 = username
	# ARGUMENT 2 = custom autogenerated hash key
	# ARGUMENT 3 = sec question
	# ARGUMENT 4 = userAccountDataFormat
	cat<<-EOF
		{
			"account_holder":"$1",
			"account_secret_key":"$2",
			"security_question":"$3",
			"user_accounts":[
				$4
			]	
		}
	EOF
}

function userAccountDataFormat(){
	# ARGUMENT 1 = service name (url or app name)
	# ARGUMENT 2 = username or login name
	# ARGUMENT 3 = password
	# ARGUMENT 4 = notes about the service
	cat<<-EOF
		{
			"service":"$1",
			"username":"$2",
			"password":"$3",
			"notes":"$4"
		}
	EOF
}

function populateUserAccountData(){
	vim $DEFAULT_ACCOUNT_DATA_PREFORM_PATH
}

function main(){
	while read line; do
		echo $line | grep -e '.*:\s.*'

		# regexr.com/3rbig
	done <<< "$(cat $DEFAULT_ACCOUNT_DATA_PREFORM_PATH)"
}

main