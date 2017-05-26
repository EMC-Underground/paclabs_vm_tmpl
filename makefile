all: build

validate:
	packer validate -var-file=variables ubuntu_16.04.json
build:  validate
	packer build --on-error="cleanup" -var-file=variables ubuntu_16.04.json
debug:  validate
	PACKER_LOG=1 packer build --on-error="cleanup" -var-file=variables ubuntu_16.04.json
