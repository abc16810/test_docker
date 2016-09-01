FROM centos
MAINTAINER wsm <wangsenmao@xdja.com>

RUN yum install -y epel-release;yum clean all 
RUN yum install -y \
python-pip \
openssh-server
 

RUN /usr/bin/pip install supervisor
COPY supervisord.conf   /etc/
COPY sshd.conf /etc/supervisord.d/
COPY functions /etc/
COPY wsm.sh /sbin/  
RUN chmod 755 /sbin/wsm.sh

RUN  useradd admin
RUN  echo "admin:admin" | chpasswd


EXPOSE 22

ENV RUNTIME_DIR /etc
ENV LOG_DIR /var/log
ENTRYPOINT ["/sbin/wsm.sh"]

CMD ["start"]
