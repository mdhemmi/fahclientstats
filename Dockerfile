FROM ubuntu:18.04
MAINTAINER Michael Hempel, hemmi@xmsoft.de

ENV LAST_UPDATE=2020-03-25

RUN apt-get update && \ 
    apt-get upgrade -y

# Tools necessary for installing and configuring Ubuntu

RUN apt-get install -y \
    tzdata \
    apt-utils \
    locales  

# Timezone
RUN echo "Europe/Berlin" | tee /etc/timezone && \
    ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Locale with UTF-8 support

RUN echo de_DE.UTF-8 UTF-8 >> /etc/locale.gen && \
    locale-gen && \
    update-locale LC_ALL=de_DE.UTF-8 LANG=de_DE.UTF-8
ENV LANG de_DE.UTF-8
ENV LANGUAGE de_DE:en
ENV LC_ALL de_DE.UTF-8

# expect and perl

RUN apt-get install -y \
    telnet \
    expect \
    perl \
    make \
    gcc \
    libjson-perl && \
    rm -rf /var/lib/apt/lists/*

RUN cpan install JSON::Parse

ENV fahquery /opt/fahclientstats/fahquery.sh
ENV config /opt/fahclientstats/config.json
ENV fahstats /opt/fahclientstats/fahstats.pl

VOLUME /opt/fahclientstats

COPY fahquery.sh /opt/fahclientstats/fahquery.sh
COPY fahstats.pl /opt/fahclientstats/fahstats.pl

CMD ["/opt/fahclientstats/fahstats.pl"]
