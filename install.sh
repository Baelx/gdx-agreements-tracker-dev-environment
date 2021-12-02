#! /bin/bash

# Stop running the script if any process throws an error.
set -e

# Colours.
ACTION_CYAN='\033[0;36m'
SUCCESS_GREEN='\033[0;32m'
ERROR_RED='\033[0;31m'
NO_COLOR='\033[0m'

# Helper function to output coloured message on a new line.
format_status_message() {
    COLOR=$2
    printf "${COLOR}$1${NO_COLOR}\n"
}

# Find environment variables needed for symlink creation.
set_up_environment_variables() {
    format_status_message "Locating environment variables that point to gdx-agreements-tracker repositories." $ACTION_CYAN
    # Look for .env in the same directory.
    if [ -f .env ]
    then
        # Instantiate environment variables.
        export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
        format_status_message "COMPLETE" $SUCCESS_GREEN
    else
        # Throw errors if there are issues getting the env vars.
        if [ ]
        then
            format_status_message "ERROR. Couldn't parse agreement tracker API or Front-end locations. Environment variables appear empty." $ERROR_RED
        else
            format_status_message "ERROR. Couldn't parse agreement tracker API or Front-end locations. Did you provide an .env file with absolute paths for these repositores?" $ERROR_RED
        fi
        exit 1
    fi
}

# Sets up symlinks to GDX Agreements tracker repositories.
set_up_symlinks() {
    format_status_message "Setting up symlinks to project gdx-agreements-tracker repositories..." $ACTION_CYAN
    if [ -L "./gdx-agreements-tracker-api" ] && [ -L "./gdx-agreements-tracker-front-end" ];
    then
        printf "Symlinks already in place.\n"
    else
        ln -s $GDX_AGREEMENT_TRACKERS_API_DIR gdx-agreements-tracker-api
        ln -s $GDX_AGREEMENT_TRACKERS_FRONT_END_DIR gdx-agreements-tracker-front-end
        printf "Symlinks created.\n"
    fi
    format_status_message "COMPLETE" $SUCCESS_GREEN
}

# Docker compose build the apps, set up network, volumes, etc.
build_apps() {
    format_status_message "Building api and front-end..." $ACTION_CYAN
    docker-compose build
    format_status_message "COMPLETE" $SUCCESS_GREEN
}

# Installation flow.
set_up_environment_variables
set_up_symlinks
build_apps
