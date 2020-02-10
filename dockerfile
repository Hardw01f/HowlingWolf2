FROM centos:7

RUN echo 'root:gandom' | chpasswd && yum update -y && yum clean all && yum install -y sudo 

RUN for num in `seq 1 9`; do useradd user$num; done

