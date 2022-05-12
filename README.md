## Video:
[![2022-05-12-20:38:15.png](https://raw.githubusercontent.com/halitAKAYDIN/LfiScan/main/2022-05-12-20%3A38%3A15.png)](https://youtu.be/r-R5ot_tOQs "LFI Scanner")

## Description
```
A simple Script tests for LFI (Local File Inclusion) via Curl 
```

## Requirements:
```
curl
```

## Installation:
```bash
1. git clone https://github.com/halitAKAYDIN/LfiScan.git
2. cd LfiScan
3. chmod +x lfiscan.sh
```

## Usage:
```bash
bash ./lfiscan.sh -h

bash ./lfiscan.sh -u "http://example.com/index.php?page=" 

bash ./lfiscan.sh -u "http://example.com/index.php?page=" -c "PHPSESSID=;" -w wordlist.txt

bash ./lfiscan.sh -u "http://example.com/index.php?page=" -c "PHPSESSID=;" -w wordlist.txt -t 5
```

## Testing:
```bash
bash ./lfiscan.sh -u "http://spacesec/dvwa/vulnerabilities/fi/?page=" -c "PHPSESSID=0lkh0q867sv9sv8n7156a06i9e; security=low" -w linux.txt -t 3

███████ ██████   █████   ██████ ███████ ███████ ███████  ██████ 
██      ██   ██ ██   ██ ██      ██      ██      ██      ██      
███████ ██████  ███████ ██      █████   ███████ █████   ██      
     ██ ██      ██   ██ ██      ██           ██ ██      ██      
███████ ██      ██   ██  ██████ ███████ ███████ ███████  ██████
linktr.ee/hltakydn                            coded by hLtAkydn
                                                  Version: v0.6

# Attacking targets without mutual consent is illegal! ########

===================Local File Inclusion Scanner=================

[*] [HST] spacesec code: 200
[*] [RPT] Report Path: /tmp/lfiscan/spacesec

[/] [SCN] Scan in Progress (45/2310)
[!] [LFI] http://spacesec/dvwa/vulnerabilities/fi/?page=/../etc/apache2/apache2.conf

[?] Continue Scanning? [Y/n] 
```

## Disclaimer:
```
This tool is for educational purposes only.
We are not responsible for any illegal usage of this tool.
```
