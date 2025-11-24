FROM alpine:latest AS builder

RUN apk add --no-cache \
    build-base \
    linux-headers \
    autoconf \
    automake \
    openssl-dev openssl-libs-static \
    libssh2-dev libssh2-static \
    zlib-dev zlib-static \
    libpsl-dev libpsl-static

ENV NMAP_VERSION=7.94
RUN wget https://nmap.org/dist/nmap-${NMAP_VERSION}.tar.bz2 && \
    tar -xjf nmap-${NMAP_VERSION}.tar.bz2 && \
    cd nmap-${NMAP_VERSION}

WORKDIR /nmap-${NMAP_VERSION}

RUN ./configure \
    --prefix=/usr \
    --without-zenmap \
    --without-ndiff \
    --with-liblua=included \
    --with-libpcap=included \
    --with-pcre=included \
    --with-libdnet=included \
    --with-libz=/usr \
    --with-openssl=/usr \
    --with-libssh2=/usr \
    LDFLAGS="-static" \
    && make -j$(nproc)

RUN make install DESTDIR=/tmp/install

WORKDIR /release
RUN \
    cp /tmp/install/usr/bin/nmap . && \
    cp /tmp/install/usr/bin/ncat . && \
    cp /tmp/install/usr/bin/nping . && \
    cp -r /tmp/install/usr/share/nmap/scripts . && \
    cp -r /tmp/install/usr/share/nmap/nselib . && \
    cp /tmp/install/usr/share/nmap/nmap-os-db . && \
    cp /tmp/install/usr/share/nmap/nmap-services . && \
    cp /tmp/install/usr/share/nmap/nmap-service-probes . && \
    cp /tmp/install/usr/share/nmap/nmap-mac-prefixes . && \
    cp /tmp/install/usr/share/nmap/nmap-protocols . && \
    cp /tmp/install/usr/share/nmap/nmap-rpc .

RUN ldd nmap | grep "not a dynamic executable" && \
    ldd ncat | grep "not a dynamic executable" && \
    ldd nping | grep "not a dynamic executable" || echo "Static build check failed"

RUN tar -czf nmap-suite-static.tar.gz *
