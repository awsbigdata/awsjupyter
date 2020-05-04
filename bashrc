export S3_BUCKET=srramasdesktop
export S3_PREFIX=gluejupyter

export MASTER=yarn
export SPARK_HOME=/usr/lib/spark
export HADOOP_CONF_DIR=/etc/hadoop/conf
export CLASSPATH=":/usr/lib/hadoop-lzo/lib/*:/usr/lib/hadoop/hadoop-aws.jar:/usr/share/aws/aws-java-sdk/*:/usr/share/aws/emr/emrfs/conf:/usr/share/aws/emr/emrfs/lib/*:/usr/share/aws/emr/emrfs/auxlib/*:/home/jupyter/awsglue/aws-glue-libs/gluejars/*:/usr/share/aws/redshift/jdbc/RedshiftJDBC.jar"

export SPARK_SUBMIT_OPTIONS="$SPARK_SUBMIT_OPTIONS --executor-memory 5G --driver-memory 5G"
export PYTHONPATH="/usr/lib/spark/python:/usr/lib/spark/python/lib/PySpark.zip:/usr/lib/spark/python/lib/py4j-src.zip:/home/jupyter/awsglue/aws-glue-libs/PyGlue.zip:$PYTHONPATH"

export PYSPARK_PYTHON=/usr/bin/python3
