#!/bin/bash
#
# Author(s):  btnz
# URL:        https://github.com/btnz-k/multi_config
################################################################################

# List packages vital to the start process
reqpackage="python-apt python3-apt aptitude ansible"

# Presents the Users with a Quick Notice Prior to the Installation
tee <<-NOTICE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  INSTALLING: Multi-Config by BTNZ
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTICE

# Generate a Pause
sleep 3

# Make Critical Folders
mkdir -p ~/.screen/{logs,caps} ~/client/recon /opt/multi/{stage,data,logs} /opt/multi/var/install
chmod 775 ~/.screen/{logs,caps} ~/client/recon /opt/multi/{stage,data,logs} /opt/multi/var/install
chown 1000:1000 ~/.screen/{logs,caps} ~/client/recon /opt/multi/{stage,data,logs} /opt/multi/var/install

tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛  Configuring Base Packages - Please Standby
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
#reqpackage="python-apt python3-apt aptitude ansible"
DEBIAN_FRONTEND=noninteractive apt-get install $reqpackage -yqq 2>&1 >> /dev/null

tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛  Installing Required Packages - Please Standby
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF


tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛  Updating the Server - Please Standby 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF



############################################################################################


tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ Finished - Basic Updates
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

ansible-playbook /opt/multi/stage/clone.yml
bash /opt/multi/stage/cloner/solo/update.sh





# Copy Starting Commands for PGBlitz
path="/pg/stage/alias"
cp -t /bin $path/plexguide $path/pg $path/pgblitz

# Verifying the Commands Installed
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛  Verifiying Started Commands Installed via @ /bin
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

# Installation fails if the pgblitz command is not in the correct location
file="/bin/pgblitz"
if [ ! -e "$file" ]; then

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! The PGBlitz Installer Failed ~ http://pgblitz.wiki
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Please Reinstall PGBlitz by running the Command Again! This step is to
ensure that everything is working prior to the install!
Ensure that you utilizing the correct versions of linux as described on
the installation page!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EXITING!!!
EOF
exit
fi

# If nothing failed, notify the user that installation passed!
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️  PASSED! The PGBlitz Command Installed! ~ http://pgblitz.wiki
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

# creates a blank var; if this executes; pgblitz will go through the install process
touch /pg/var/new.install

chmod 775 /bin/plexguide /bin/pgblitz /bin/pg
chown 1000:1000 /bin/plexguide /bin/pgblitz /bin/pg

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
↘️  Start AnyTime By Typing >>> pgblitz [or] plexguide [or] pg
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF