FROM ubuntu:14.04
			 
RUN apt-get update

ENV DEFUALT_PASSWORD 55211

# RUN apt-get install -y vim
RUN apt-get install -y python-software-properties software-properties-common

RUN apt-get install -y software-properties-common
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
RUN add-apt-repository 'deb [arch=amd64,i386] http://ftp.kaist.ac.kr/mariadb/repo/10.1/ubuntu trusty main'

RUN apt-get update

ENV DEBIAN_FRONTEND noninteractive
RUN echo "mariadb-server-10.0 mysql-server/root_password password $DEFUALT_PASSWORD" | debconf-set-selections
RUN echo "mariadb-server-10.0 mysql-server/root_password_again password $DEFUALT_PASSWORD" | debconf-set-selections
RUN apt-get install -y mariadb-server
ADD ./config/my.cnf /etc/mysql/

# set locale ko_KR
RUN apt-get install -y language-pack-ko
RUN locale-gen ko_KR.UTF-8

ENV LANG ko_KR.UTF-8
ENV LANGUAGE ko_KR.UTF-8
ENV LC_ALL ko_KR.UTF-8

EXPOSE 3306

CMD /bin/bash	
ENTRYPOINT mysqld
