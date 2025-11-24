id=$(docker create --platform linux/amd64 nmap-suite-builder)

docker cp $id:/release ./nmap-kit

docker rm -v $id
