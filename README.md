# Packer image build files

The following templates are available:
- CentOS 7 - "make centos7"
- Ubuntu 16.04 - "make ubuntu16.04"

CentOS 7 builds against ESXi - see notes below.
Ubuntu builds against Virtualbox (I left all the files the same just organized into a directory)

## ESXi Builder

Packer builds directly agianst a single ESXi host, not against vCenter.

By default Packer supports esx5 (hw version 9).
The config files build with hw version 11 and OS type "centos-64".
HW version 13 (ESXi 6.5) supports OS type "centos7-64" but don't think it matters too much.

Packer doesn't  play nice with VMware Distributed Switches -
build on a host using a normal vSwitch.

The ESXi host you are building against requires the following to be done:

Enable Guest IP hack (allows Packer to infer the guest IP from ESXi):

> esxcli system settings advanced set -o /Net/GuestIPHack -i 1

Open the firewall ports for VNC:

> chmod 644 /etc/vmware/firewall/service.xml
> chmod +t /etc/vmware/firewall/service.xml

Append the VNC port range to /etc/vmware/firewall/service.xml:

> <service id="1000">
>   <id>packer-vnc</id>
>   <rule id="0000">
>     <direction>inbound</direction>
>     <protocol>tcp</protocol>
>     <porttype>dst</porttype>
>     <port>
>       <begin>5900</begin>
>       <end>6000</end>
>     </port>
>   </rule>
>   <enabled>true</enabled>
>   <required>true</required>
> </service>

Restore permissions and refresh the firewall:

> chmod 444 /etc/vmware/firewall/service.xml
> esxcli network firewall refresh
