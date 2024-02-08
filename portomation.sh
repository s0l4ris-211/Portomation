#!/bin/bash

banner() {
    echo -e "\e[0;35m _______  _______  _______ _________ _______  _______  _______ __________________ _______  _       \e[0m"
    echo -e "\e[0;35m(  ____ )(  ___  )(  ____ )\__   __/(  ___  )(       )(  ___  )\__   __/\__   __/(  ___  )( (    /|\e[0m"
    echo -e "\e[0;35m| (    )|| (   ) || (    )|   ) (   | (   ) || () () || (   ) |   ) (      ) (   | (   ) ||  \  ( |\e[0m"
    echo -e "\e[0;35m| (____)|| |   | || (____)|   | |   | |   | || || || || (___) |   | |      | |   | |   | ||   \ | |\e[0m"
    echo -e "\e[0;35m|  _____)| |   | ||     __)   | |   | |   | || |(_)| ||  ___  |   | |      | |   | |   | || (\ \) |\e[0m"
    echo -e "\e[0;35m| (      | |   | || (\ (      | |   | |   | || |   | || (   ) |   | |      | |   | |   | || | \   |\e[0m"
    echo -e "\e[0;35m| )      | (___) || ) \ \__   | |   | (___) || )   ( || )   ( |   | |   ___) (___| (___) || )  \  |\e[0m"
    echo -e "\e[0;35m|/       (_______)|/   \__/   )_(   (_______)|/     \||/     \|   )_(   \_______/(_______)|/    )_)\e[0m"
    echo
    echo -e "------------------------------------🚀 \e[0;32mWelcome to Portomation!\e[0m 🚀-----------------------------------"
    echo
    echo -e "\e[0;29mVersion: v2.0.1\e[0m"
    echo -e "\e[0;33mTool Name: Portomation\e[0m"
    echo -e "\e[1;31mDeveloped by oxrick_287\e[0m"
    echo
    echo -en "\e[1;37mPortomation is a tool for automating port scan. There are several tools like nmap, masscan, rustsacn \nand some more tools were used in this project. Hope you like it. Happy hacking 🙂!"
}

# Calling the banner function
banner

# Function to check if a command is available
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install these tool
install_tool() {

    local tool=$1
    case $tool in

        nmap)
        sudo apt-get update
        sudo apt-get install -y nmap
        ;;

        masscan)
        sudo apt-get update
        sudo apt-get install -y masscan
        ;;

        rustscan)
        sudo apt-get update
        wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb .
        sudo dpkg -i rustscan_2.0.1_amd64.deb
        ;;

        unicornscan)
        sudo apt-get update
        sudo apt install unicornscan
        ;;

        naabu)
        sudo apt-get update
        sudo apt install naabu
        ;;

        sandmap)
        sudo apt-get update
        sudo apt install sandmap
        ;;

        *)
        echo -e "\e[1;33m[!] Error: Unsupported tool.\e[0m" >&2
        exit 1
        ;;
    esac
}

# List of required tools
required_tools=("nmap" "masscan" "rustscan" "unicornscan" "naabu" "sandmap" "netcat" "nc")

# Check and install missing tools
for tool in "${required_tools[@]}"; do
    if ! command_exists "$tool"; then
        echo -en "\e[1;31m[-] $tool is not installed. Attempting to install...\e[0m"
        install_tool "$tool"
    fi
done

# Tool choice list for scanning
choice_list() {
    echo -e "\n\e[1;32m+-------------------------------------------+"
    echo -e "| \e[1;34mSelect an option from below:\e[0m              |"
    echo -e "+-------------------------------------------+"
    echo -e "| [1] \e[1;33mNmap\e[0m                                  |"
    echo -e "| [2] \e[1;33mRustscan\e[0m                              |"
    echo -e "| [3] \e[1;33mMasscan\e[0m                               |"
    echo -e "| [4] \e[1;33mUnicornscan (Eth0 only)\e[0m               |"
    echo -e "| [5] \e[1;33mNetcat / nc\e[0m                           |"
    echo -e "| [6] \e[1;33mNaabu\e[0m                                 |"
    echo -e "| [7] \e[1;33mSandmap (Metasploit-like)\e[0m             |"
    echo -e "| [8] \e[1;33mRun All (Except unicornscan & sandmap)\e[0m|"
    echo -e "| [0] \e[1;31mExit\e[0m                                  |"
    echo -e "+-------------------------------------------+\e[0m\n"
}

execution_fun() {
	local choice=$1

	case $choice in

		1) # nmap 
        echo -en "\e[0;32m[*] Do you want to run the default scan for nmap? (y/n):~ \e[0m"
        read run_default_scan
        echo -e "\n"

        if [ "$run_default_scan" == "y" ]; then 
            read -p "[+] Enter target IP:~ " target_ip
            output_file="default_scan.nmap"
            nmap -sC -T4 -vvv -A -p- $target_ip -oN $output_file
        else
            read -p "[+] Enter target IP:~ " target_ip 
            read -p "[+] Enter additional flags for nmap (e.g., '-sU -T3 -p1-100', '-sT -T5 -vv --min-rate' etc):~ " flags
            output_file="scan_result.nmap"
            nmap -sC -T4 -vvv -A -p- $target_ip $nmap_options -oN $output_file
        fi
        exit 0
        ;;

        2) # rustscan
        echo -en "\e[0;32m[*] Do you want to run the default scan for nmap? (y/n):~ \e[0m"
        read run_default_scan
        echo -en "\n"

        if [ "$run_default_scan" == "y" ]; then 
        	read -p "[+] Enter target IP:~ " target_ip
        	output_file="default_scan.rustscan"
        	echo -en "[+] Please wait few seconds to finish the scan...\n"
        	rustscan --verbose --accessible -a $target_ip -r1-65535 -u 65535 -b 10000 > $output_file
        	echo -en "[+] Scan finished! 🙂"
        else
			read -p "[+] Enter target IP:~ " target_ip 
        	read -p "[+] Enter additional flags for rustscan (e.g., '-u, --ulimit', '-p, --ports' etc):~ " flags
        	output_file="scan_result.rustscan"
        	echo -en "[+] Please wait few seconds to finish the scan...\n"
        	rustscan --verbose -a $target_ip $flags  > $output_file	
        	echo -en "[+] Scan finished! 🙂"
        fi
        exit 0
        ;;

        3) # masscan
        echo -en "\e[0;32m[*] Do you want to run the default scan for nmap? (y/n):~ \e[0m"
        read run_default_scan
        echo -en "\n"

        if [ "$run_default_scan" == "y" ]; then 
        	read -p "[+] Enter target IP:~ " target_ip
            read -p "[+] Enter target interface (e.g., 'tun0' or 'eth0' etc):~ " interface
        	output_file="default_scan.rustscan"
        	sudo masscan -p1-65535 $target_ip --open --rate 5000 -e $interface -oL $output_file
        else 
    		read -p "[+] Enter target IP (e.g., '10.10.14.57' or '2603:3001:2d00:da00::'):~ " target_ip
            read -p "[+] Enter target interface (e.g., 'tun0' or 'eth0' etc):~ " interface 
    		read -p "[+] Enter port or port range (e.g., 80,1-10000):~ " port
    		read -p "[+] Enter additional flags for masscan (e.g., '--range', '--ping', '--nmap' etc:~ " flags
    		output_file="scan_result.masscan"
    		sudo masscan -p$port $target_ip $flags -e $interface -oL $output_file
    	fi
    	exit 0
    	;; 

        4) # Unicornscan 
        echo -en "\e[0;32m[*] Do you want to run the default scan for nmap? (y/n):~ \e[0m"
        read run_default_scan
        echo -en "\n"

        if [ "$run_default_scan" == "y" ]; then
            read -p "[+] Enter target IP:~ " target_ip 
            read -p "[+] Enter target interface (e.g., 'eth0' or 'eth1' etc):~ " interface
            read -p "[+] Enter CIDR notation (e.g., 8, 16, 24, 32):~ " cidr_notation
            output_file="default_scan.unicornscan"
            sudo unicornscan -r1000 -mT -v -I -i $interface $target_ip/$cidr_notation > $output_file
        else
            read -p "[+] Enter target IP:~ " target_ip
            read -p "[+] Enter target interface (e.g., 'eth0' or 'eth1' etc):~ " interface
            read -p "[+] Enter CIDR notation (e.g., 8, 16, 24, 32):~ " cidr_notation 
    		read -p "[+] Enter additional flags for unicornscan:~ " flags 
            output_file="scan_result.unicornscan"
            sudo unicornscan $flags -i $interface $target_ip/$cidr_notation > $output_file
        fi
        exit 0
        ;;

        5) # Netcat
        echo -en "\e[0;32m[*] Do you want to run the default scan for nmap? (y/n):~ \e[0m"
        read run_default_scan
        echo -en "\n"

        if [ "$run_default_scan" == "y" ]; then 
            read -p "[+] Enter target IP:~ " target_ip
            netcat -v -w 1 $target_ip -z 20-100 | grep open
        else
            read -p "[+] Enter target IP:~ " target_ip
    		read -p "[+] Enter port or port range (e.g., 80,1-10000):~ " port_range 
    		read -p "[+] Enter additional flags for netcat:~ " flags
            netcat $flags $target_ip $port_range | grep open
        fi
        exit 0
        ;;

        6) # Naabu
        echo -en "\e[0;32m[*] Do you want to run the default scan for nmap? (y/n):~ \e[0m"
        read run_default_scan
        echo -en "\n"

        if [ "$run_default_scan" == "y" ]; then 
            read -p "[+] Enter target IP:~ " target_ip
            read -p "[+] Enter interface (e.g., 'tun0', 'eth0':~ " interface
            output_file="default_scan.naabu"
            naabu -p1-65535 $target_ip --open --rate 5000 -i $interface -oL $output_file
        else 
            read -p "[+] Enter target IP (e.g., '10.10.14.57' or '2603:3001:2d00:da00::'):~ " target_ip
            read -p "[+] Enter port or port range (e.g., 80,1-10000):~ " port
            read -p "[+] Enter additional flags for naabu (e.g., '-interface', '-top-ports', '-list' etc:~ " flags
            output_file="scan_result.naabu"
            naabu -p$port $target_ip $flags -e $interface -oL $output_file
        fi
        exit 0
        ;;

        7) # Sandmap
        echo -en "\e[0;32m [+] Executing Sandmap...\e[0m"
        sudo sandmap
        ;;

        8) # Run Everything (Except Unicornscan & Sandmap)
        read -p "[+] Enter Target IP:~ " target_ip
        echo

        echo -en "\e[1;32m[+] Executing Nmap...\e[0m"
        echo
        output_file="scan.namp"
        nmap -sC -T4 -vvv -A --top-ports 1000 --max-parallelism 100 $target_ip $nmap_options -oN $output_file

        echo -en "\e[1;32m[+] Executing Rustscan...\e[0m"
        echo
        output_file="scan.rustscan"
        rustscan --verbose --accessible -a $target_ip --top -t 2500 --ulimit 10000 --batch-size 65535 > $output_file
        echo -en "[+] Scan finished! 🙂"

        echo -en "\e[1;32m[+] Executing Masscan...\e[0m"
        echo
        read -p "[+] Enter interface (e.g., 'tun0', 'eth0'):~ "
        output_file="scan.masscan"
        sudo masscan -p1-65535 $target_ip --banners --open-only --rate 1000 -e $interface -oL $output_file

        echo -en "\e[1;32m[+] Executing Netcat Scanning (For top 100 ports)...\e[0m"
        echo
        netcat -v -w 1 $target_ip -z 20-100 | grep open

        echo -en "\e[1;32m[+] Executing Naabu...\e[0m"
        echo
        read -p "[+] Enter interface (e.g., 'tun0', 'eth0':~ " interface
        output_file="scan.naabu"
        naabu -v -p 1-65535 -host $target_ip -i $interface -nmap-cli 'nmap -sT -A -T4' -json --rate 10000 -o $output_file
        exit 0
        ;;

        0) # Exit
        echo -en "\e[0;32m[-] Exiting...\e[0m"
        exit 0
        ;;

        *) # Invalid option
        echo -en "\e[1;31m[-] Invalid option! Please enter a valid number.\e[0m"
        echo
        ;;
    esac
}

# Main script

while true; do
    choice_list
    echo -en "\e[1;34m[*] Select a choice for port scanning (0-8):~ \e[0m"
    read choice
    execution_fun $choice
done