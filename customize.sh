##############
# Config Vars
##############

# Set this to true if you don't want to mount the system folder
SKIPMOUNT=false

# Set this to true if you want to debug the installation
DEBUG=true

###############
# Replace List
###############

# List all directories you want to directly replace in the system
# Construct your list in the following example format
REPLACE_EXAMPLE="/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework"

# Construct your own list here
REPLACE=""

##############
# Permissions
##############

set_permissions() {
  set_perm_recursive "$MODPATH/system" 0 0 0777 0755
}

#######
# Main
#######

SKIPUNZIP=1
unzip -qjo "$ZIPFILE" 'common/functions.sh' -d $TMPDIR >&2
. $TMPDIR/functions.sh