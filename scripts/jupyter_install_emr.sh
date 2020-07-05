#!/bin/bash

set -x -v


unset SUDO_UID
##clean up old env
sudo rm -rf /emr/notebook-env/
# Install a separate conda installation via Miniconda
WORKING_DIR=/mnt/jupyter
mkdir -p "$WORKING_DIR"
wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh  -O "$WORKING_DIR/anaconda.sh"
bash "$WORKING_DIR/anaconda.sh" -b -u -p "$WORKING_DIR/conda"
rm -rf "$WORKING_DIR/anaconda.sh"
# Create a custom conda environment
source "$WORKING_DIR/conda/bin/activate"

conda update conda -y
conda update anaconda -y

conda create -n JupyterSystemEnv python=3.7 anaconda -y

source "$WORKING_DIR/conda/bin/activate"  JupyterSystemEnv

conda install --yes -c conda-forge ipykernel
conda install --yes -c conda-forge s3contents

# Customize these lines as necessary to install the required packages
#conda install --yes numpy
#pip install --quiet boto

conda install --yes -c conda-forge jupyterlab

conda install --yes -c conda-forge jupyter

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

. ~/.nvm/nvm.sh

nvm install node

node -e "console.log('Running Node.js ' + process.version)"

#conda install --yes -c conda-forge nodejs

jupyter notebook --generate-config -y

cat <<EOT >> $HOME/.jupyter/jupyter_notebook_config.py
import os
from s3contents import S3ContentsManager
import boto3
import logging

c = get_config()

##disble bot3 debug logs

boto3.set_stream_logger('botocore.vendored.requests', logging.ERROR)

# Tell Jupyter to use S3ContentsManager for all storage.
c.NotebookApp.contents_manager_class = S3ContentsManager
#c.S3ContentsManager.access_key_id =None
#c.S3ContentsManager.secret_access_key =None
#c.S3ContentsManager.session_token = "<AWS Session Token / IAM Session Token>"
c.S3ContentsManager.bucket ="srramasdesktop"

# Optional settings:
c.S3ContentsManager.prefix ="gluejupyter"

EOT


echo '{
  "NotebookApp": {
    "password": "sha1:eddc1cbfac1e:34b59c2d4d12f78e31874e40e2d0eb85520cad15"
  }
}' >$HOME/.jupyter/jupyter_notebook_config.json


jupyter --version

echo "completed"
##installing extensions
cd /mnt/jupyter
source "conda/bin/activate"  JupyterSystemEnv
jupyter lab clean
unalias pip
unalias python
conda install --yes -c conda-forge pip
pip install jupyterlab-s3-browser
pip install toree
export JAVA_HOME="/etc/alternatives/jre"
export HADOOP_HOME_WARN_SUPPRESS="true"
export HADOOP_HOME="/usr/lib/hadoop"
export HADOOP_PREFIX="/usr/lib/hadoop"
export HADOOP_MAPRED_HOME="/usr/lib/hadoop-mapreduce"
export HADOOP_YARN_HOME="/usr/lib/hadoop-yarn"
export HADOOP_COMMON_HOME="/usr/lib/hadoop"
export HADOOP_HDFS_HOME="/usr/lib/hadoop-hdfs"
export HADOOP_CONF_DIR="/usr/lib/hadoop/etc/hadoop"
export YARN_CONF_DIR="/usr/lib/hadoop/etc/hadoop"
export YARN_HOME="/usr/lib/hadoop-yarn"
export HIVE_HOME="/usr/lib/hive"
export HIVE_CONF_DIR="/usr/lib/hive/conf"
export HBASE_HOME="/usr/lib/hbase"
export HBASE_CONF_DIR="/usr/lib/hbase/conf"
export SPARK_HOME="/usr/lib/spark"
export SPARK_CONF_DIR="/usr/lib/spark/conf"
export PYTHONPATH="/usr/lib/spark/python:/usr/lib/spark/python/lib/PySpark.zip:/usr/lib/spark/python/lib/py4j-src.zip:/usr/share/aws/glue/etl/python/PyGlue.zip:$PYTHONPATH"
export PYSPARK_PYTHON=/usr/bin/python3
##installing scala
jupyter toree install --spark_home=$SPARK_HOME --sys-prefix
mkdir /mnt/test
conda create -n pyspark3 -c conda-forge  python=3.7 -y
conda activate pyspark3
conda install --yes -c conda-forge s3contents
conda install --yes -c conda-forge ipywidgets
conda install --yes -c conda-forge ipykernel
python -m ipykernel install --name pyspark3 --display-name "pyspark3" --user
conda deactivate
cd /mnt/jupyter
source "conda/bin/activate"  JupyterSystemEnv
jupyter labextension install jupyterlab-s3-browser
jupyter labextension install @jupyter-widgets/jupyterlab-manager
jupyter labextension install @jupyterlab/toc
jupyter lab --no-browser --ip=0.0.0.0 --port=9443 --NotebookApp.disable_check_xsrf=True --NotebookApp.allow_password_change=False --notebook-dir=/mnt/test 

