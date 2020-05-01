#!/bin/bash
# Install Python 2 kernel
#conda create -n py2 -c conda-forge  python=2.7 -y
source /mnt/jupyter/conda/etc/profile.d/conda.sh

conda activate py2
#sudo yum install -y gcc
python -v
python -m ipykernel install --user --name=firstEnv

# Install libraries for Python

pip install paramiko nltk scipy numpy scikit-learn pandas

#conda deactivate
#source  /mnt/jupyter/conda/bin/activate
#python  --name py2 --display-name "Python2"

