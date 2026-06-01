#!/bin/bash
# setup_environment.sh

echo "Setting up GravityOS Build Environment..."

# Update and install necessary build tools (AOSP requirements)
# This is a general list for Ubuntu/Debian environments
# sudo apt-get update
# sudo apt-get install -y git-core gnupg flex bison build-essential zip curl zlib1g-dev \
#   libncurses5 x11proto-core-dev libx11-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig

# Install repo tool if not present
if ! command -v repo &> /dev/null; then
    echo "Installing repo tool..."
    mkdir -p ~/bin
    curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
    chmod a+x ~/bin/repo
    export PATH=~/bin:$PATH
fi

echo "Environment setup complete. Please ensure you have at least 100GB+ disk space for a minimal sync."
