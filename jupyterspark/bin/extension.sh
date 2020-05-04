#!/bin/bash


pwd 
whoami
cd /mnt/jupyter
source "conda/bin/activate"  JupyterSystemEnv
jupyter lab clean
source ~/.bashrc

pip install jupyter-lsp
jupyter --version
jupyter labextension install @krassowski/jupyterlab-lsp          
#jupyter labextension install @ijmbarr/jupyterlab_spellchecker
jupyter labextension install @jupyterlab/toc
jupyter labextension install @aquirdturtle/collapsible_headings
#jupyter labextension install @krassowski/jupyterlab_go_to_definition
jupyter labextension install @jupyter-widgets/jupyterlab-manager@2.0
# INSTALL S3 BROWSER (https://github.com/IBM/jupyterlab-s3-browser)
pip install jupyterlab-s3-browser
jupyter labextension install jupyterlab-s3-browser

