FROM rust:alpine AS builder

RUN apk add --no-cache musl-dev gcc build-base

RUN cargo install rustcat

WORKDIR /usr/local/cargo/bin
RUN ldd rcat 2>&1 | grep "Not a valid dynamic program" || echo "Static build confirmed"
