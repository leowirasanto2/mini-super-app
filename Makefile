ROOT := $(shell pwd)

bootstrap:
	cd $(ROOT)/MiniSAPlayground && pod install

build:
	ROOT=$(ROOT) bash $(ROOT)/Scripts/build-workspace.sh

test:
	bash $(ROOT)/Scripts/test.sh