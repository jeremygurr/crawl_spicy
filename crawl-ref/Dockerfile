ARG web_host=crawl.ufetubus.com
ARG crawl_repo=https://github.com/jeremygurr/crawl_spicy.git
ARG version

ARG web_path=/usr/www
ARG user_data=/var/crawl
ARG shared_dir=${user_data}/rcs
ARG checkout_dir=/usr/src
ARG crawl_ref=${checkout_dir}/crawl/crawl-ref

# this gcc can be latest, we just pin it to a version for consistency and rebuild speed
#   so if it doesn't work, just update to the latest version and pin it to that
FROM alpine:3.7 as os_base
RUN apk add --no-cache \
    alpine-sdk \
    bash \
    bison \
    flex \
    perl \
    vim 

#    libfreetype6-dev \
#    liblua5.1-0-dev \
#    libncursesw5-dev \
#    libpng-dev \
#    libsdl2-dev \
#    libsdl2-image-dev \
#    libsdl2-mixer-dev \
#    libsqlite3-dev \
#    libz-dev \ 
#    pkg-config \
#    ttf-dejavu-core \
#    advancecomp \
#    pngcrush \
#    && rm -rf /var/lib/apt/lists/*

FROM os_base as build_base
ARG web_path
ARG shared_dir
ARG checkout_dir
ARG crawl_ref
ARG crawl_repo
ARG version

RUN apk add --no-cache \
    libpng-dev \
    pngcrush
WORKDIR ${checkout_dir}
RUN git clone -q "$crawl_repo" -b "$version" crawl
WORKDIR ${crawl_ref}/source
RUN git submodule update --init
RUN make -j6 SHAREDDIR=${shared_dir} prefix=${web_path} USE_DGAMELAUNCH=y WEBTILES=y

#COPY CREDITS.txt ${crawl_ref}/
#COPY settings ${crawl_ref}/settings
# two separate commands to make debugging the install phase much more efficient
RUN make webserver install -j6 SHAREDDIR=${shared_dir} prefix=${web_path} USE_DGAMELAUNCH=y WEBTILES=y

# old version
#FROM nginx:1.13.9 as crawlweb
# new nginx
#FROM nginx:1.13.9-alpine as crawlweb

FROM python:2-alpine3.7 as crawlweb
ARG web_host
ARG web_path
ARG shared_dir
ARG crawl_ref
ARG user_data

VOLUME ${user_data}

LABEL maintainer="jeremy.gurr@gmail.com"

ENV LANG=C.UTF-8

# alpine version
RUN apk add --no-cache \
    bash \
    nginx

SHELL [ "/bin/bash", "-c" ]

#RUN apk add --no-cache \
#    build-essential libncursesw5-dev bison flex liblua5.1-0-dev \
#    libsqlite3-dev libz-dev pkg-config libsdl2-image-dev libsdl2-mixer-dev \
#    libsdl2-dev libfreetype6-dev libpng-dev ttf-dejavu-core

#  debian version
#RUN apt-get update \
#    && apt-get install -y \
#    apt-utils \
#    bison \
#    curl \
#    flex \
#    fonts-dejavu-core \
#    libfreetype6-dev \
#    liblua5.1-0-dev \
#    libncursesw5-dev \
#    libpng-dev \
#    libsdl2-dev \
#    libsdl2-image-dev \
#    libsdl2-mixer-dev \
#    libsqlite3-dev \
#    libz-dev \
#    pkg-config \
#    vim \
#    procps \
#    python \
#    python-setuptools \
#    python-dev \
#    build-essential \
#    wget \
#    && rm -rf /var/lib/apt/lists/*

#RUN mkdir -p /etc/pki/tls/certs \
#    && wget http://curl.haxx.se/ca/cacert.pem -O /etc/pki/tls/certs/ca-bundle.crt \
#    && easy_install pip \
#    && pip install tornado==3.2.2

RUN mkdir -p /etc/pki/tls/certs \
    && pip install tornado==3.2.2

RUN addgroup -g 1000 crawl \
  && adduser -D -s /bin/sh -u 1000 -G crawl crawl \
  && addgroup -g 1001 crawl-dev \
  && adduser -D -s /bin/sh -u 1001 -G crawl-dev crawl-dev

COPY --from=build_base ${crawl_ref}/source/webserver/ ${web_path}/webserver/
COPY --from=build_base ${web_path}/ ${web_path}/
COPY --from=build_base ${crawl_ref}/settings/init.txt ${web_path}
COPY docker/webstuff/ ${web_path}/
COPY docker/webstuff/banner.html ${web_path}/webserver/templates/
COPY docker/webstuff/index.html ${web_path}/webserver/

WORKDIR ${web_path}

ENV conf_path /etc/nginx
ENV uid 1000
ENV gid 1000
ENV crawl_port 8081
ENV nginx_port 80

EXPOSE ${crawl_port}
EXPOSE ${nginx_port}

RUN rm config.py 2>/dev/null; true \
  && ./hydrate config.py init-player.sh nginx/conf.d/default.conf launch \
  && chmod a+x launch \
  && mv config.py webserver/ \
  && cp -a nginx/conf.d/* /etc/nginx/conf.d/ \
  && chown -R crawl:crawl ${web_path} ${user_data}

WORKDIR ${shared_dir}
CMD /usr/www/launch

