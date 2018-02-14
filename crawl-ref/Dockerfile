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
    libz-dev pkg-config \
    ttf-dejavu-core \
    && rm -rf /var/lib/apt/lists/*

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
RUN make -j6 SHAREDDIR=${shared_dir} prefix=${web_path} USE_DGAMELAUNCH=y WEBTILES=y

COPY CREDITS.txt ${crawl_ref}/
COPY settings ${crawl_ref}/settings
# two separate commands to make debugging the install phase much more efficient
RUN make install -j6 SHAREDDIR=${shared_dir} prefix=${web_path} USE_DGAMELAUNCH=y WEBTILES=y

FROM nginx as crawlweb
ARG web_path
ARG shared_dir
ARG crawl_ref
VOLUME ${user_data}

LABEL maintainer="jeremy.gurr@gmail.com"

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
    python-tornado \
    ttf-dejavu-core \
    vim \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 crawl && useradd -N -s /usr/sbin/nologin -u 1000 -g crawl crawl

RUN mkdir -p ${shared_dir}/running ${shared_dir}/ttyrecs
COPY --from=build_base ${web_path}/ ${web_path}/
COPY --from=build_base ${crawl_ref}/settings/init.txt ${web_path}
COPY webstuff/ ${web_path}
COPY source/webserver/ ${web_path}/webserver/

WORKDIR ${web_path}

ENV conf_path /etc/nginx
ENV uid 1000
ENV gid 1000
ENV crawl_port 8081
ENV nginx_port 80

EXPOSE ${crawl_port}
EXPOSE ${nginx_port}

RUN ./hydrate config.py init-player.sh nginx/conf.d/default.conf launch \
  && chmod a+x launch \
  && mv config.py webserver/ \
  && cp -a nginx/conf.d/* /etc/nginx/conf.d/ \
  && chown -R crawl:crawl ${web_path} 

WORKDIR ${shared_dir}
CMD /usr/www/launch

