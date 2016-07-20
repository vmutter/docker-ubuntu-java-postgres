FROM ubuntu:16.04
MAINTAINER Vinicius Mutter Erbetta <vinicius.me@gmail.com>

RUN apt-get update && apt-get upgrade -y

WORKDIR /opt

# Java
RUN apt-get install wget -y
RUN wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jre-8u91-linux-x64.tar.gz
RUN tar -xvzf jre-8u91-linux-x64.tar.gz
RUN rm -rf jre*.tar.gz
RUN update-alternatives --install /usr/bin/java java /opt/jre1.8.0_91/bin/java 100
RUN java -version
RUN apt-get purge wget -y

# Postgres
RUN apt-get install -y postgresql-9.5 postgresql-contrib-9.5
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.5/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.5/main/postgresql.conf

COPY entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]

EXPOSE 5432

VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
