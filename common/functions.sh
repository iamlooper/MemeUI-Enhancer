############
# Functions
############

setup_native_libs() {
  case "$ARCH" in
    arm64)
      mv -f "$MODPATH"/libs/arm64-v8a/* "$MODPATH/libs"
      rm -rf "$MODPATH/libs/arm64-v8a" "$MODPATH/libs/armeabi-v7a" "$MODPATH/libs/x86" "$MODPATH/libs/x86_64"
      ;;
    arm)
      mv -f "$MODPATH"/libs/armeabi-v7a/* "$MODPATH/libs"
      rm -rf "$MODPATH/libs/armeabi-v7a" "$MODPATH/libs/arm64-v8a" "$MODPATH/libs/x86" "$MODPATH/libs/x86_64"
      ;;
    x86)
      mv -f "$MODPATH"/libs/x86/* "$MODPATH/libs"
      rm -rf "$MODPATH/libs/x86" "$MODPATH/libs/armeabi-v7a" "$MODPATH/libs/arm64-v8a" "$MODPATH/libs/x86_64"
      ;;
    x64)
      mv -f "$MODPATH"/libs/x86_64/* "$MODPATH/libs"
      rm -rf "$MODPATH/libs/x86_64" "$MODPATH/libs/armeabi-v7a" "$MODPATH/libs/x86" "$MODPATH/libs/arm64-v8a"
      ;;
  esac
}

#######
# Main
#######

# Debugging
"$DEBUG" && set -x || set +x

# Don't install module if not in boot mode
"$BOOTMODE" || abort "- Installation not supported in recovery!"

# Extract files
ui_print "- Extracting module files"
unzip -o "$ZIPFILE" -x 'META-INF/*' 'common/functions.sh' -d $MODPATH >&2

# Skip mount
"$SKIPMOUNT" && touch "$MODPATH/skip_mount"

# Install
ui_print "- Installing"
[ -f "$MODPATH/common/install.sh" ] && . $MODPATH/common/install.sh

# Set permissions
ui_print "- Setting permissions"
set_perm_recursive "$MODPATH" 0 0 0755 0644
set_perm_recursive "$MODPATH/system/bin" 0 2000 0755 0755
set_perm_recursive "$MODPATH/system/xbin" 0 2000 0755 0755
set_perm_recursive "$MODPATH/system/system_ext/bin" 0 2000 0755 0755
set_perm_recursive "$MODPATH/system/vendor/bin" 0 2000 0755 0755 u:object_r:vendor_file:s0
set_permissions

# Cleanup
ui_print "- Cleaning up"
rm -rf \
  "$MODPATH/common" \
  "$MODPATH/LICENSE" \
  "$MODPATH/customize.sh" \
  "$MODPATH/changelog.md" \
  "$MODPATH/README.md" \
  "$MODPATH/system/placeholder" \
  "$MODPATH"/.git*