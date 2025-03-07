#!/bin/bash

BLUE_BOLD="\e[1;34m"
YELLOW_BOLD="\e[1;93m"
RESET="\e[0m"
RED="\e[1;91m"
GREEN="\e[1;92m"
WHITE="\e[1;97m"
PINK="\e[1;95m"

echo -e "
  ${BLUE_BOLD}1-${YELLOW_BOLD} Hash${RESET}
  ${BLUE_BOLD}2-${YELLOW_BOLD} IP Address${RESET}
  ${BLUE_BOLD}3-${YELLOW_BOLD} Domain${RESET}
  ${BLUE_BOLD}4-${YELLOW_BOLD} Web Address${RESET}
  ${BLUE_BOLD}5-${YELLOW_BOLD} Basic File Analysis${RESET}
  ${BLUE_BOLD}6-${YELLOW_BOLD} Full File Analysis${RESET}
"

function funecho(){
    echo -e  "${BLUE_BOLD}================================================================================${RESET}"
    echo -e  "${BLUE_BOLD}================================================================================${RESET}"
}

function funspace(){
    echo -e "\n"
}

function funcorrect(){
    echo -e "${GREEN}=========== CORRECT CHOICE ===========${WHITE}"
}

api_key="QhiUmXGhTrWTyyM/z8YBJA=="

while true; do
    read -p "$(echo -e ${WHITE}Enter Number: )" number

    case $number in
        1)
            funcorrect
            funspace
            read -p "Enter Hash: " hash
            funecho
            response=$(curl --request GET "https://opentip.kaspersky.com/api/v1/search/hash?request=$hash" --header "x-api-key: $api_key")
            funecho
            funspace
            echo "$response" | jq -r 'to_entries[] | 
                "========================================", 
                "Key    : " + .key, 
                "Value  : " + (.value | tostring), 
                "========================================"'
            break
            ;;
        2)
            funcorrect
            funspace
            read -p "Enter IP Address: " ip
            funecho
            response=$(curl --request GET "https://opentip.kaspersky.com/api/v1/search/ip?request=$ip" --header "x-api-key: $api_key")
            funecho
            funspace
            echo "$response" | jq -r 'to_entries[] | 
                "========================================", 
                "Key    : " + .key, 
                "Value  : " + (.value | tostring), 
                "========================================"'
            break
            ;;
        3)
            funcorrect
            funspace
            read -p "Enter Domain: " domain
            funecho
            response=$(curl --request GET "https://opentip.kaspersky.com/api/v1/search/domain?request=$domain" --header "x-api-key: $api_key")
            funecho
            funspace
            echo "$response" | jq -r 'to_entries[] | 
                "========================================", 
                "Key    : " + .key, 
                "Value  : " + (.value | tostring), 
                "========================================"'
            break
            ;;
        4)
            funcorrect
            funspace
            read -p "Enter Web Address: " web
            funecho
            response=$(curl --request GET "https://opentip.kaspersky.com/api/v1/search/url?request=$web" --header "x-api-key: $api_key")
            funecho
            funspace
            echo "$response" | jq -r 'to_entries[] | 
                "========================================", 
                "Key    : " + .key, 
                "Value  : " + (.value | tostring), 
                "========================================"'
            break
            ;;
        5)
            funcorrect
            funspace
            read -p "Enter Basic File Analysis Name: " basic_file
            read -p "Enter File Path: " file_path
            funecho
            response=$(curl --request POST "https://opentip.kaspersky.com/api/v1/scan/file?filename=$basic_file" --header "x-api-key: $api_key" --header 'Content-Type: application/octet-stream' --data-binary "@$file_path")
            funecho
            funspace
            echo "$response" | jq -r 'to_entries[] | 
                "========================================", 
                "Key    : " + .key, 
                "Value  : " + (.value | tostring), 
                "========================================"'
            break
            ;;
        6)
            funcorrect
            funspace
            read -p "Enter Full File Analysis Hash: " file_hash
            funecho
            response=$(curl --request POST "https://opentip.kaspersky.com/api/v1/getresult/file?request=$file_hash" --header "x-api-key: $api_key")funecho
            funspace
            echo "$response" | jq -r 'to_entries[] | 
                "========================================", 
                "Key    : " + .key, 
                "Value  : " + (.value | tostring), 
                "========================================"'
            break
            ;;
        *)
            echo -e "${RED}=========== INCORRECT CHOICE ===========${RESET}"
            ;;
    esac
done
