FROM alpine:latest AS builder

# 1. 패키지 설치
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

# 2. Configure 설정
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

# 3. 결과물 모으기
RUN make install DESTDIR=/tmp/install

# 4. 최종 반출용 폴더(/release)에 파일 복사
# 수정됨: nmap-*.db 와일드카드 제거 -> nmap-os-db 명시적 복사
WORKDIR /release
RUN \
    # 1) 실행 파일
    cp /tmp/install/usr/bin/nmap . && \
    cp /tmp/install/usr/bin/ncat . && \
    cp /tmp/install/usr/bin/nping . && \
    # 2) 핵심 디렉토리
    cp -r /tmp/install/usr/share/nmap/scripts . && \
    cp -r /tmp/install/usr/share/nmap/nselib . && \
    # 3) 데이터 파일 (여기가 수정되었습니다)
    cp /tmp/install/usr/share/nmap/nmap-os-db . && \
    cp /tmp/install/usr/share/nmap/nmap-services . && \
    cp /tmp/install/usr/share/nmap/nmap-service-probes . && \
    cp /tmp/install/usr/share/nmap/nmap-mac-prefixes . && \
    cp /tmp/install/usr/share/nmap/nmap-protocols . && \
    cp /tmp/install/usr/share/nmap/nmap-rpc .

# 5. 정적 빌드 검증
RUN ldd nmap | grep "not a dynamic executable" && \
    ldd ncat | grep "not a dynamic executable" && \
    ldd nping | grep "not a dynamic executable" || echo "Static build check failed"

# 6. 압축 (선택)
RUN tar -czf nmap-suite-static.tar.gz *
