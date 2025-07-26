ROOT := $(shell pwd)

bootstrap:
	@echo "Checking for outdated pods..."
	cd $(ROOT)/MiniSAPlayground && pod outdated
	@echo "Installing pods..."
	cd $(ROOT)/MiniSAPlayground && pod install
	@echo "Bootstrap complete!"
	@echo "Building workspace..."
	$(MAKE) build

build:
	ROOT=$(ROOT) bash $(ROOT)/Scripts/build-workspace.sh

test:
	bash $(ROOT)/Scripts/test.sh