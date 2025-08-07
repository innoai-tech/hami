export VERSION := `cat version`

all: dep patch

dep:
    rm -rf ./HAMi*
    git clone -b {{ VERSION }} https://github.com/Project-HAMi/HAMi.git
    cd ./HAMi && git submodule update --init

[working-directory('HAMi')]
patch:
    git cherry-pick a612dd193f2b47cad084785c74b89b2d466e4b69
    git cherry-pick d2cef0875197150113e67a7d430a4f736d3f9883

export IMAGE := "ghcr.io/innoai-tech/hami"
export GOLANG_IMAGE := "golang:1.24-bullseye"
export HAMICORE_IMAGE := "docker.io/projecthami/hamicore:" + VERSION

[working-directory('HAMi')]
build:
    docker buildx build --push \
         --platform linux/amd64 \
         --platform linux/arm64 \
         --tag "{{ IMAGE }}:{{ VERSION }}" \
         --build-arg VERSION="{{ VERSION }}" \
         --build-arg GOLANG_IMAGE="{{ GOLANG_IMAGE }}" \
         --build-arg HAMICORE_IMAGE="{{ HAMICORE_IMAGE }}" \
         --build-arg DEST_DIR="/usr/local" \
         -f docker/Dockerfile.hamimaster .
