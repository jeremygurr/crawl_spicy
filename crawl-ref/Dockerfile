#ARG version

ARG web_path=/usr/www
ARG user_data=/var/crawl
ARG shared_dir=${user_data}/rcs
ARG checkout_dir=/usr/src
ARG crawl_ref=${checkout_dir}/crawl/crawl-ref

FROM gcc as os_base
RUN apt-get update && apt-get install -y \
    bison \
    flex \
    libfreetype6-dev \
    liblua5.1-0-dev \
    libncursesw5-dev \
    libpng-dev \
    libsdl2-dev \
    libsdl2-image-dev \
    libsdl2-mixer-dev \
    libsqlite3-dev \
    libz-dev \ 
    pkg-config \
    ttf-dejavu-core \
    && rm -rf /var/lib/apt/lists/*

# for png compression, but I'm not sure this works right, seems to be breaking things
#    advancecomp \
#    pngcrush \

FROM os_base as build_base
ARG web_path
ARG shared_dir
ARG checkout_dir
ARG crawl_ref
ARG version

#ENV base_repo crawl_spicy
#ENV crawl_repo https://github.com/jeremygurr/$base_repo.git

WORKDIR ${checkout_dir}
#RUN git clone "$crawl_repo" -b "$version" crawl
COPY docs ${crawl_ref}/docs
COPY source ${crawl_ref}/source

WORKDIR ${crawl_ref}/source
RUN make distclean
RUN make -j6 SHAREDDIR=${shared_dir} prefix=${web_path} USE_DGAMELAUNCH=y WEBTILES=y

COPY CREDITS.txt ${crawl_ref}/
COPY settings ${crawl_ref}/settings
# two separate commands to make debugging the install phase much more efficient
RUN make webserver install -j6 SHAREDDIR=${shared_dir} prefix=${web_path} USE_DGAMELAUNCH=y WEBTILES=y

FROM nginx as crawlweb
ARG web_path
ARG shared_dir
ARG crawl_ref
ARG user_data

VOLUME ${user_data}

LABEL maintainer="jeremy.gurr@gmail.com"

# load the latest packages
RUN apt-get update 

# fix locale
ENV LANG=C.UTF-8
#RUN apt-get install -y locales 
#RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales 

RUN apt-get install -y \
    bison \
    flex \
    fonts-dejavu-core \
    libfreetype6-dev \
    liblua5.1-0-dev \
    libncursesw5-dev \
    libpng-dev \
    libsdl2-dev \
    libsdl2-image-dev \
    libsdl2-mixer-dev \
    libsqlite3-dev \
    libz-dev \
    pkg-config \
    vim \
    procps 

#    python-tornado \
#    python-tornado=3.2.2 \

RUN apt-get install -y \
    python

RUN apt-get install -y \
    python-setuptools \
    python-dev \
    build-essential 

RUN apt-get install -y wget

RUN mkdir -p /etc/pki/tls/certs \
    && wget http://curl.haxx.se/ca/cacert.pem -O /etc/pki/tls/certs/ca-bundle.crt \
    && easy_install pip

RUN pip install tornado==3.2.2

# clean up apt cache
RUN rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 crawl \
  && useradd -N -s /bin/bash -u 1000 -g crawl crawl \
  && groupadd -g 1001 crawl-dev \
  && useradd -N -s /bin/bash -u 1001 -g crawl-dev crawl-dev

COPY --from=build_base ${crawl_ref}/source/webserver/ ${web_path}/webserver/
COPY --from=build_base ${web_path}/ ${web_path}/
COPY --from=build_base ${crawl_ref}/settings/init.txt ${web_path}
COPY docker/webstuff/ ${web_path}/

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

