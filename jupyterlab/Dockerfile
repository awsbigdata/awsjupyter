FROM amazoncorretto:8

RUN yum -y update
RUN yum -y install yum-utils wget curl git zip vim

RUN java -version

RUN mkdir -p /mnt/
RUN chmod 777 /mnt/
RUN useradd -ms /bin/bash jupyter
USER jupyter

WORKDIR /opt


COPY bin /opt/
RUN ls /opt/
RUN  /opt/conda_install.sh
ENV PATH=$PATH:/opt/

WORKDIR /mnt/

CMD ["/bin/bash","/opt/starter"]

