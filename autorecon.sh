#!/bin/bash

# Colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"

clear

echo -e "${CYAN}"
echo " █████╗ ██╗   ██╗████████╗ ██████╗ "
echo "██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗"
echo "███████║██║   ██║   ██║   ██║   ██║"
echo "██╔══██║██║   ██║   ██║   ██║   ██║"
echo "██║  ██║╚██████╔╝   ██║   ╚██████╔╝"
echo "╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝ "
echo " Automated Recon Framework"
echo -e "${RESET}"

if [ -z "$1" ]; then
    echo -e "${RED}Usage: ./autorecon.sh <target>${RESET}"
    exit
fi

TARGET=$1
REPORT="report_$TARGET.txt"

echo -e "${YELLOW}Target:${RESET} $TARGET"
echo -e "${GREEN}Saving report to $REPORT${RESET}"

echo "Recon Report for $TARGET" > $REPORT
echo "=============================" >> $REPORT

echo -e "\n${BLUE}[+] WHOIS Lookup${RESET}"
whois $TARGET | tee -a $REPORT

echo -e "\n${BLUE}[+] DNS Records${RESET}"
dig $TARGET ANY +noall +answer | tee -a $REPORT

echo -e "\n${BLUE}[+] NSLOOKUP${RESET}"
nslookup $TARGET | tee -a $REPORT

echo -e "\n${BLUE}[+] HTTP Headers${RESET}"
curl -I $TARGET 2>/dev/null | tee -a $REPORT

echo -e "\n${BLUE}[+] Nmap Top Ports Scan${RESET}"
nmap -F $TARGET | tee -a $REPORT

echo -e "\n${GREEN}[✓] Recon Completed${RESET}"
echo -e "${GREEN}[✓] Report saved to $REPORT${RESET}"
