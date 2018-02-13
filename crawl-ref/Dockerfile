#ARG version

ARG web_path=/usr/local/apache2/htdocs
ARG shared_dir=${web_path}/rcs
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

ENV base_repo dcss_spicy
ENV crawl_repo https://github.com/jeremygurr/$base_repo.git

WORKDIR ${checkout_dir}
RUN git clone "$crawl_repo" -b "$version" crawl

WORKDIR ${crawl_ref}/source
RUN make install -j6 SHAREDDIR=${shared_dir} prefix=${web_path} USE_DGAMELAUNCH=y WEBTILES=y

FROM httpd
ARG web_path
ARG shared_dir
ARG crawl_ref

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
    libz-dev pkg-config \
    ttf-dejavu-core \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 crawl && useradd -N -s /usr/sbin/nologin -u 1000 -g crawl crawl

RUN mkdir -p ${shared_dir}/running ${shared_dir}/ttyrecs
COPY --from=build_base ${web_path}/ ${web_path}/
COPY --from=build_base ${crawl_ref}/settings/init.txt ${web_path}
COPY webstuff/ ${web_path}

WORKDIR ${web_path}

RUN ./hydrate config.py && rm hydrate
RUN cp -a apache2/ /etc/apache2/
RUN chown -R crawl:crawl ${web_path}

USER crawl


