sudo ip tuntap add tap0 mode tap user root
sudo ip addr add dev tap0 10.0.0/24
sudo ip link set tap0 up

# See https://pojntfx.github.io/go-isc-dhcp/
cat >/tmp/dhcpd.yaml <<EOF
dhcpd:
  device: tap0
  subnets:
    - netmask: 255.255.255.0
      network: 10.0.0.0
      nextServer: 10.0.0.1
      filename: undionly.kpxe
      range:
        start: 10.0.0.10
        end: 10.0.0.100
EOF
dhcpdctl apply -s ipxebuilderd.felix.pojtinger.com:80 -f /tmp/dhcpd.yaml

# See https://pojntfx.github.io/ipxebuilderd/
cat >/tmp/ipxe.yaml <<EOF
ipxe:
  platform: bin
  driver: undionly
  extension: kpxe
  script: |
    #!ipxe
    echo "Hello, world!"
EOF
ipxectl apply -s ipxebuilderd.felix.pojtinger.com:80 -f /tmp/ipxe.yaml
ipxectl get -s ipxebuilderd.felix.pojtinger.com:80 ba8d96a0-dfd7-4bee-87da-80cfcbc7d72b/bin/undionly.kpxe

mkdir -p /tftpboot
curl -Lo /tftpboot/undionly.kpxe http://minio.ipxebuilderd.felix.pojtinger.com/ipxebuilderd/7aca7db6-af24-4edb-a980-da74f4418333/bin/undionly.kpxe
atftpd --daemon --no-fork --bind-address 10.0.0.0 --port 69 /tftpboot

# In another terminal on the same host
sudo qemu-system-x86_64 -boot n -netdev tap,id=mynet0,ifname=tap0,script=no,downscript=no -device e1000,netdev=mynet0,mac=52:55:00:d1:55:01 -nographic -curses
