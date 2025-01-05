function runcdrom() {
	/usr/bin/qemu-system-x86_64 \
		-monitor stdio \
		-smp "$(nproc)" \
		-k pt-br \
		-machine accel=kvm \
		-m 4096 \
		-cdrom "$1" \
		-hda "/archlive/qemu/hda.img" \
		-boot once=d,menu=off \
		-net nic \
		-net user \
		-rtc base=localtime \
		-name "runcdrom"
}
