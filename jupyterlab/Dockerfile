FROM amazoncorretto:8

RUN yum -y update
RUN yum -y install tar  wget curl git zip

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

CMD ["/bin/bash"]

