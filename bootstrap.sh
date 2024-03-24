#!/bin/bash

PROVISION_DIR="${HOME}/.provision"
cd ${PROVISION_DIR}

wget -O Miniforge3.sh "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh -b -p "${PROVISION_DIR}/conda"
source "${PROVISION_DIR}/conda/etc/profile.d/conda.sh"
conda activate
conda install -y ansible

wget https://github.com/huypn12/huypn-ansible-laptop/archive/refs/heads/main.zip
unzip main.zip
