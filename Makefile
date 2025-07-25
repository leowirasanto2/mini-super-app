ROOT := $(shell pwd)

bootstrap:
	cd $(ROOT)/MiniSAPlayground && pod install

build:
	ROOT=$(ROOT) bash $(ROOT)/Scripts/build-workspace.sh