FROM debian:stretch
MAINTAINER Vitaly Kovalyshyn "v.kovalyshyn@webitel.com"

ENV FS_MAJOR 1.8
ENV FS_VERSION 1.8.5
ENV REFRESHED_AT 2019-03-11

RUN apt-get update && apt-get -y --quiet --force-yes upgrade \
    && apt-get install -y --quiet --force-yes gnupg2 wget \
    && wget -O - https://files.freeswitch.org/repo/deb/freeswitch-1.8/fsstretch-archive-keyring.asc | apt-key add - \
    && echo "deb http://files.freeswitch.org/repo/deb/freeswitch-1.8/ stretch main" > /etc/apt/sources.list.d/freeswitch.list \
    && echo "deb-src http://files.freeswitch.org/repo/deb/freeswitch-1.8/ stretch main" >> /etc/apt/sources.list.d/freeswitch.list \
    && gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.11/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.11/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && apt-get update && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV LANG en_US.utf8

RUN groupadd -r freeswitch && useradd -r -g freeswitch freeswitch

COPY LICENSE /LICENSE
