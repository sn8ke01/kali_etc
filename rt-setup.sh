#!/bin/bash

RED='\033[1;31m'
GRN='\033[1;32m'
YEL='\033[1;33m'
BLU='\033[1;34m'
PUR='\033[1;35m'
NC='\033[0m' # No Color

apt update

## Repos ##

# Trsusted Sec
git clone https://github.com/trustedsec/ptf /opt/ptf
cd /opt/ptf && ./ptf
use modules /exploitation/install_update_all
use modules /intelligence-gathering/install_update_all
use modules /post-exploitation/install_update_all
use modules /powershell/install_update_all
use modules /vulnerability-analysis/install_update_all

git clone https://github.com/trustedsec/unicorn.git /opt/unicorn

# Empire - PowerShell and Python #
git clone https://github.com/EmpireProject/Empire.git /opt/Empire
