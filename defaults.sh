# Default settings.
# Each of them can be overridden in config.sh

# Path to the license file of Shoco (Short Command) relative to its src directory
SHOCO_SDK_CFG_LICENSE_FILE="../LICENSE"
SHOCO_SDK_CFG_DOWNLOAD_BASE_URL='https://getshoco.org'
SHOCO_SDK_CFG_LATEST_VERSION_DATA_URL="$SHOCO_SDK_CFG_DOWNLOAD_BASE_URL/latest"

# Glob patterns to match files that do not require --register-name directive.
# By default these are help files, files with assisting logic,
# the file with the shoco function.
read -r -d '' SHOCO_SDK_CFG_EXCLUDE_FROM_NAME_REGISTER <<'EXCLUDE'
shoco/helps/*
shoco/shoco.sh
[0-9][0-9][0-9]_*
*/[0-9][0-9][0-9]_*
EXCLUDE
