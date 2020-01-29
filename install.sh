#!/bin/bash
#
# Author(s):  btnz
# URL:        https://github.com/btnz-k/multi_config
################################################################################

# List packages vital to the start process
reqpackage="python-apt python3-apt aptitude ansible"
USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)

# make sure this is running as sudo
if [ `whoami` != root ]; then
    echo Please run this script as root or using sudo
    exit
fi

# Presents the Users with a Quick Notice Prior to the Installation
tee <<-NOTICE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛  INSTALLING: Multi-Config by BTNZ
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTICE

# Generate a Pause
sleep 3

# Make Critical Folders
mkdir -p ~/.screen/{logs,caps} ~/client/recon 

tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛  Installing Core Packages - Please Standby
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

DEBIAN_FRONTEND=noninteractive apt-get install $reqpackage -yqq 2>&1 >> /dev/null

tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛  Installing Packages Required by Tools - Please Standby
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

ansible-playbook ./ansible/installPackages.yml

tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛  Cloning Tools - Please Standby 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

ansible-playbook ./ansible/cloneTools.yml

tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛  Configuring Tools - Please Standby 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

curl -o "$USER_HOME/.screenrc" "https://gist.githubusercontent.com/btnz-k/5cc3e77d12dca2e93ca10ba9b6d4c56a/raw/2f8f4185f7e1eee60be17b4fbc00f5aa676cb5a8/.screenrc"
curl -o "$USER_HOME/.bashrc" "https://gist.githubusercontent.com/btnz-k/c79f19b59cc605c0c1ad82ddfcd87abc/raw/14d234bd59797066d14d6c379148d820e9e75f04/.bashrc"

chown -R 1000:1000 ~/.screen/{logs,caps} ~/client/recon /opt/
ansible-playbook ./ansible/setupTools.yml

tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ Finished!

  Restart shell for best experience!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
