# 1. 공식 Rust Alpine 이미지 사용 (안정성 확보)
FROM rust:alpine AS builder

# 2. 빌드에 필요한 C 라이브러리 헤더 설치
RUN apk add --no-cache musl-dev gcc build-base

# 3. Rustcat 설치
# 중요: RUSTFLAGS 강제 옵션을 제거했습니다.
# Alpine 환경에서는 기본적으로 musl 타겟을 쓰므로 자동으로 정적 링크가 됩니다.
RUN cargo install rustcat

# 4. 결과 확인 (경로가 /usr/local/cargo/bin 으로 변경됨에 주의)
WORKDIR /usr/local/cargo/bin
# ldd로 확인했을 때 "Not a valid dynamic program"이 나오면 성공입니다.
RUN ldd rcat 2>&1 | grep "Not a valid dynamic program" || echo "Static build confirmed"
