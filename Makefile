all: dep patch

dep:
	git submodule update --init --recursive
	git submodule update --force --remote
	git submodule foreach -q --recursive 'git reset --hard'

patch:
	cd harbor && sh -c "curl https://github.com/Project-HAMi/HAMi/compare/master...morlay:multi-arch.patch | git apply -v"

