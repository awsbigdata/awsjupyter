from sivankumar86/jupyterlab:2.0


COPY bin /opt/

RUN  /opt/extension.sh


ENV S3_BUCKET=srramasdesktop
ENV S3_PREFIX=gluejupyter
ENV  PATH=$PATH:/mnt/jupyter/conda/bin/
