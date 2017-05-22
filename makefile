all: build

validate:
	packer validate ubuntu_16.04.json
build:  validate
	packer build --on-error="cleanup" ubuntu_16.04.json
