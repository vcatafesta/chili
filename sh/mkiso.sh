#!/bin/bash
. /lib/lsb/init-functions

if [ $(id -u) != 0 ]; then
	echo "$0 script need to run as root!"
	exit 1
fi

trap "exit 1" SIGHUP SIGINT SIGQUIT SIGTERM
LFSVERSION="minimal-1.0"

LOCALDIR=$PWD
TEMPDIR=/chili/lfsiso
ISOLINUXDIR=$LOCALDIR/livecd/isolinux
DISTRONAME="CHILIOS"
LABEL="ChiliOSLiveCD"
#LFS=/mnt/full
LFS=/mnt/lfs
DIAHORA=`date +"%d%m%Y-%T" | sed 's/://g'`
OUTPUT=chilios-$LFSVERSION-livecd-$DIAHORA.iso

#isolinux_files="libmenu.c32 chain.c32 isolinux.bin ldlinux.c32 libutil.c32 reboot.c32 menu.c32 isohdpfx.bin isolinux.cfg libcom32.c32 poweroff.c32 hdt.c32"
pushd /chili/livecd/isolinux
isolinux_files=$(echo *)
popd

log_wait_msg "Criando diretorio temporario..."
rm -fr $TEMPDIR
mkdir -p $TEMPDIR/{filesystem,isolinux,boot}

log_wait_msg "Copiando alguns necessarios arquivos..."
for file in $isolinux_files; do
	cp $ISOLINUXDIR/$file $TEMPDIR/isolinux
done

echo "$DISTRONAME" > $TEMPDIR/isolinux/venomlive
[ -d livecd/virootfs ] && cp -aR livecd/virootfs $TEMPDIR

KERNEL=/boot/vmlinuz-$(uname -r)
INITRD=/boot/initrd-$(uname -r).img
DESTKERNEL=$TEMPDIR/boot/vmlinuz
DESTINITRD=$TEMPDIR/boot/initrd

log_wait_msg "Copiando kernel $KERNEL to $DESTKERNEL..."
cp -f $KERNEL $TEMPDIR/boot/vmlinuz
cp -f $KERNEL $LFS/boot/
rm -f $LFS/boot/vmlinuz

log_wait_msg "Copiando initrd $INITRD to $DESTINITRD..."
cp -f $INITRD $TEMPDIR/boot/initrd
cp -f $INITRD $LFS/boot/
rm -f $LFS/boot/initrd

pushd $LFS/boot
ln -sf vmlinuz-$(uname -r) vmlinuz
ln -sf initrd-$(uname -r).img initrd
popd

log_wait_msg "Criando filesystem squashfs..."
mksquashfs $LFS $TEMPDIR/filesystem/root.sfs -b 1048576 -comp xz -Xdict-size 100% \

log_wait_msg "Excluindo .iso antigo..."
rm -f $OUTPUT

log_wait_msg "Criando iso $OUTPUT..."
xorriso -as mkisofs                                 \
		-r -J -joliet-long                          \
		-l -cache-inodes                            \
		-isohybrid-mbr $ISOLINUXDIR/isohdpfx.bin    \
		-partition_offset 16                        \
		-volid "${LABEL}"                           \
		-b isolinux/isolinux.bin                    \
		-c isolinux/boot.cat                        \
		-no-emul-boot                               \
		-boot-load-size 4                           \
		-boot-info-table                            \
		-o $OUTPUT                                  \
       	$TEMPDIR

#UFI
#xorriso -as mkisofs \
#  -o output.iso \
#  -isohybrid-mbr /usr/lib/syslinux/isohdpfx.bin \
#  -c isolinux/boot.cat \
#  -b isolinux/isolinux.bin \
#  -no-emul-boot -boot-load-size 4 -boot-info-table \
#  -eltorito-alt-boot \
#  -e isolinux/efiboot.img \
#  -no-emul-boot \
#  -isohybrid-gpt-basdat \
#  $TEMPDIR

log_success_msg2 "Arquivo iso $OUTPUT criado com sucesso!"
log_wait_msg "Aguarde, transferindo arquivo via SCP!"
scp $OUTPUT 10.0.0.68:/home/vcatafesta/Downloads/live.iso
evaluate_retval
