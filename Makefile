export VERSION = $(shell cat version)

all: dep patch

dep:
	rm -rf ./HAMi*
	git clone --depth=1 -b ${VERSION} https://github.com/Project-HAMi/HAMi.git
	cd ./HAMi && git submodule update --init

patch:
	cd ./HAMi && sh -c "curl https://github.com/Project-HAMi/HAMi/compare/${VERSION}...morlay:patch-${VERSION}.patch | git apply -v"

build:
	cd ./HAMi && SHORT_VERSION=${VERSION} ./hack/build.sh