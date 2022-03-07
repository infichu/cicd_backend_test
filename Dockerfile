FROM centos:7

ENV PYTHON_VERSION=3.8.12

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


WORKDIR /etc/yum.repos.d/
RUN curl http://mirrors.aliyun.com/repo/Centos-7.repo > CentOS-Base.repo \
    && yum clean all && yum makecache \
    && yum install -y epel-release \
    && yum clean all \
    && yum makecache \
    && yum repolist enabled \
    && yum repolist all\
    && yum -y install wget


WORKDIR /opt/
RUN yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel libffi-devel gcc* make \
    && wget https://www.python.org/ftp/python/3.8.12/Python-3.8.12.tgz \
    && tar -zxvf Python-3.8.12.tgz


WORKDIR /opt/Python-3.8.12/
RUN mkdir /usr/local/python3 && ./configure prefix=/usr/local/python3 && make && make install \
    && ln -s /usr/local/python3/bin/python3.8 /usr/bin/python3 \
    && ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3 \
    && pip3 install virtualenv \
    && ln -s /usr/local/python3/bin/virutalenv /usr/bin/virtualenv

WORKDIR /opt/
RUN mkdir cicd_backend_test

COPY . /opt/cicd_backend_test









