#!/bin/bash

RED='\033[1;31m'
GRN='\033[1;32m'
YEL='\033[1;33m'
BLU='\033[1;34m'
PUR='\033[1;35m'
NC='\033[0m' # No Color

### Basic Steps Post-setup
#Clean, upgrade and update the system.  Should be rolling Kali when complete
echo -e "${GRN} Building gears ${NC}"
echo -e "${GRN} This may take some time ${NC}"
apt clean && apt update && apt upgrade && apt dist-upgrade -y

echo "syntax on" >> /root/.vimrc

#Tools
apt install scrub #sanitize the trash
# Either get the secure_trash.sh file from github or create locally. [http://www.nullsec.us/first-x-things-to-do-after-installing-kali-linux/]
# .Net Core for attacking network protocols: https://www.microsoft.com/net/learn/get-started/linux/debian9

git clone https://github.com/leebaird/discover /opt/discover/  && cd /opt/discover && ./update.sh #Discover Scripts

#SMBexec no longer seems to be maintained.  Consider removing or finding an alternative.
git clone https://github.com/brav0hax/smbexec.git /opt/smbexec && cd /opt/smbexec && ./install.sh


## TOR ##
echo -e "${GRN} Planting onion seeds ${NC}"
echo -e "${GRN} Give it a second to grow ${NC}"
apt install tor

echo -e "${RED} TOR Install complete ${NC}"
echo -e "${GRN} Bringin TOR Service ${NC}"
service tor start

echo -e "${GRN} Installing nethogs ${NC}"
apt install nethogs -y
ls

#Environment Prep
echo -e "${YEL} Java Env Prep ${NC}"
wget -O JavaVersion.jsp http://www.java.com/en/download/linux_manual.jsp
CurrentJava=$(cat JavaVersion.jsp |grep "Download Java software for Linux x64" |grep -v RPM |sort -u |grep -Po '(?<=href=")[^"]*')
jre_filename=$(wget -S --spider $CurrentJava |&grep jre |grep -Po '(?<=File=)[^&]*'|sort -u)  #pulls current jre name.  Hopfully.  
wget -O $jre_filename $CurrentJava
tar xzvf $jre_filename

mv $jre_filename /opt/jre
cd /opt/$jre_filename

update-alternatives --install /usr/bin/java java /opt/jre*/bin/java 1
update-alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.s­o mozilla-javaplugin.so /opt/jre*/lib/amd64/libnpjp2.so 1
update-alternatives --set java /opt/jre*/bin/java
update-alternatives --set javac /opt/jre*/bin/javac
update-alternatives --set mozilla-javaplugin.so /opt/jre*/lib/amd64/libnpjp2.so

echo -e "${GRN} java env complete ${NC}"
echo -e "${RED} Check ${BLU}logfile.log${RED} for errors ${NC}"  # I Could just capture all errors and print them when done

##ENV Stuff
