NAME="sensu-web-docker"
VERSION="v1.1.0"

docker build --build-arg VERSION="${VERSION}" --tag "${NAME}:${VERSION}" .
