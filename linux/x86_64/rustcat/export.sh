# 1. 컨테이너 생성 (실행은 안 함)
id=$(docker create --platform linux/amd64 rustcat-static-builder)

# 2. 바이너리 복사 (경로 주의: /usr/local/cargo/bin/rcat)
docker cp $id:/usr/local/cargo/bin/rcat ./rcat-static

# 3. 임시 컨테이너 삭제
docker rm -v $id
