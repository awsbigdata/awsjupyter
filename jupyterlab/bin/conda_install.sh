#!/bin/bash

set -x -v


unset SUDO_UID
# Install a separate conda installation via Miniconda
WORKING_DIR=/mnt/jupyter
mkdir -p "$WORKING_DIR"
wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh  -O "$WORKING_DIR/anaconda.sh"
bash "$WORKING_DIR/anaconda.sh" -b -u -p "$WORKING_DIR/conda"
rm -rf "$WORKING_DIR/anaconda.sh"
# Create a custom conda environment
source "$WORKING_DIR/conda/bin/activate"
pip install --quiet ipykernel
pip install --quiet s3contents

# Customize these lines as necessary to install the required packages
#conda install --yes numpy
#pip install --quiet boto

conda install --yes -c conda-forge jupyterlab

conda install --yes -c conda-forge jupyter


conda install --yes -c conda-forge nodejs



jupyter notebook --generate-config -y

cat <<EOT >> /home/jupyter/.jupyter/jupyter_notebook_config.py
import os
from s3contents import S3ContentsManager

c = get_config()

# Tell Jupyter to use S3ContentsManager for all storage.
c.NotebookApp.contents_manager_class = S3ContentsManager
#c.S3ContentsManager.access_key_id =None
#c.S3ContentsManager.secret_access_key =None
#c.S3ContentsManager.session_token = "<AWS Session Token / IAM Session Token>"
c.S3ContentsManager.bucket = os.environ["S3_BUCKET"]

# Optional settings:
c.S3ContentsManager.prefix = os.environ.get("S3_PREFIX", "notebooks/")

EOT


echo '{
  "NotebookApp": {
    "password": "sha1:eddc1cbfac1e:34b59c2d4d12f78e31874e40e2d0eb85520cad15"
  }
}' >/home/jupyter/.jupyter/jupyter_notebook_config.json

echo "completed"


