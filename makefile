
all:
    $(info Run make with the template you want to build eg "make centos7" or "make ubuntu16.04")

centos7-validate:
	packer validate -var-file=centos7-vars.json centos7.json
centos7: centos7-validate
	packer build -var-file=centos7-vars.json centos7.json

ubuntu16.04-validate:
	packer validate -var-file=ubuntu-variables.json ubuntu_16.04.json
ubuntu16.04:  ubuntu16.04-validate
	packer build --on-error="cleanup" -only=vmware-iso -var-file=ubuntu-variables.json ubuntu_16.04.json
ubuntu1604-debug:  ubuntu16.04-validate
	PACKER_LOG=1 packer build -only=vmware-iso --on-error="cleanup" -var-file=ubuntu-variables.json ubuntu_16.04.json
