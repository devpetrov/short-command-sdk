#!/bin/bash

if [ ! -f "$( cd "$(dirname ${BASH_SOURCE[0]} )" >/dev/null 2>&1 && pwd )/config.sh" ]; then
    printf "Configuration file not found.\n"
    printf "Run cp config.sh.diff config.sh\n"
    printf "and edit your configuration.\n"
    return 1
fi

. "$( cd "$(dirname ${BASH_SOURCE[0]} )" >/dev/null 2>&1 && pwd )/defaults.sh"
. "$( cd "$(dirname ${BASH_SOURCE[0]} )" >/dev/null 2>&1 && pwd )/config.sh"

short-command-sdk ()
{    
    local DO_BUILD=0
    local DO_LOAD=0

    local OPTIND
    local OPTARG
    local OPTION
    while getopts "bs" OPTION; do
        case ${OPTION} in
            b) DO_BUILD=1;;
            s) DO_LOAD=1;;
        esac
    done

    local SDK_DIR="$( cd "$(dirname ${BASH_SOURCE[0]} )" >/dev/null 2>&1 && pwd )"
    local BUILDS_DIR="$SDK_DIR/builds"
    local OUTPUT_DIR_NAME="dev"

    local OUTPUT_DIR="$BUILDS_DIR/$OUTPUT_DIR_NAME"
    local OUTPUT_FILE="$OUTPUT_DIR/shoco.sh"
    local OUTPUT_HELPS_DIR="$OUTPUT_DIR/helps"

    if [ 1 -eq "$DO_BUILD" ]; then
        _short-command-sdk-build "$OUTPUT_DIR" "$OUTPUT_FILE" "$OUTPUT_HELPS_DIR"
    fi

    if [ 1 -eq "$DO_LOAD" ]; then
        _short-command-sdk-source "$OUTPUT_FILE"
    fi
}

_short-command-sdk-source ()
{
    . "$1"

    if [ 0 -eq "$?" ]; then
        printf "Build sourced in the current shell.\n"
        printf "You can test your modifications of Shoco (Short Command)\n"
    else
        printf "Failed to source latest build.\n"
    fi
}

_short-command-sdk-build ()
{
    local OUTPUT_DIR="$1"
    local OUTPUT_FILE="$2"
    local OUTPUT_HELPS_DIR="$3"

    printf "\nOutput directory:\n"
    printf "$OUTPUT_DIR\n"

    if [ -d $OUTPUT_DIR ]; then
        printf "\nRemoving existing content in the output directory...\n"
        rm -r $OUTPUT_DIR
    fi

    printf "Building...\n"

    if [ ! -d $OUTPUT_DIR ]; then
        mkdir -p $OUTPUT_DIR
    fi

    if [ ! -d $OUTPUT_HELPS_DIR ]; then
        mkdir -p $OUTPUT_HELPS_DIR
    fi

    touch $OUTPUT_FILE

    local FILE
    for FILE in $(find $SHOCO_SDK_CFG_PROJECT_DIR -type f ! -name '. ')
    do
        _short-command-sdk-append-file "$FILE"
    done

    cp $SHOCO_SDK_CFG_PROJECT_DIR/$SHOCO_SDK_CFG_LICENSE_FILE $OUTPUT_HELPS_DIR/license

    sed -i "s/___LATEST_VERSION_DATA_URL___/${SHOCO_SDK_CFG_LATEST_VERSION_DATA_URL//\//\\/}/" $OUTPUT_FILE

    printf "Build done.\n"
}

_short-command-sdk-append-file ()
{
    local FILE="$1"
    local DIR=$(dirname $FILE)

    if [ "$DIR" == "$SHOCO_SDK_CFG_PROJECT_DIR/shoco/helps" ]; then
        cp -f "$FILE" "$OUTPUT_HELPS_DIR/$(basename -- $FILE)"
    else
        sed -r 's/^[[:space:]]*#.*//' "$FILE" >> "$OUTPUT_FILE"
        printf "\n" >> "$OUTPUT_FILE"
    fi
}
