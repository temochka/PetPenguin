#!/bin/bash
DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

source $DIR/install_linux.sh

################################################################################
header "# Configuring Git..."
################################################################################
git config --global user.name "Artem Chistyakov"
git config --global user.email "chistyakov.artem@gmail.com"
