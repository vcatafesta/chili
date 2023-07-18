#!/bin/bash
. /lib/lsb/init-functions

if [ $(id -u) != 0 ]; then
	echo "$0 script need to run as root!"
	exit 1
fi

trap "exit 1" SIGHUP SIGINT SIGQUIT SIGTERM
LFSVERSION="full-1.0"

LOCALDIR=$PWD
TEMPDIR=$LOCALDIR/lfsisofull
ISOLINUXDIR=$LOCALDIR/livecd/isolinux
DISTRONAME="CHILIOS"
LABEL="ChiliOS"
#LFS=/mnt/lfs
LFS=/mnt/full
DIAHORA=`date +"%d%m%Y-%T" | sed 's/://g'`
#OUTPUT=chilios-$LFSVERSION-livecd-$DIAHORA.iso
OUTPUT=live.iso

isolinux_files="chain.c32 isolinux.bin ldlinux.c32 libutil.c32 reboot.c32 menu.c32 vesamenu.c32 isohdpfx.bin isolinux.cfg libcom32.c32 poweroff.c32 efi.img"

log_wait_msg "Criando diretorio temporario..."
#rm -fr $TEMPDIR
#mkdir -p $TEMPDIR/{filesystem,isolinux,boot,boot/grub,efi/boot}

log_wait_msg "Copiando alguns necessarios arquivos..."
#for file in $isolinux_files; do
#	cp $ISOLINUXDIR/$file $TEMPDIR/isolinux
#done
#cp /boot/grub/efiboot.img $TEMPDIR/isolinux
#cp /boot/grub/bootx64.efi $TEMPDIR/efi/boot

echo "$DISTRONAME" > $TEMPDIR/isolinux/venomlive
#[ -d livecd/virootfs ] && cp -aR livecd/virootfs $TEMPDIR

KERNEL=/boot/vmlinuz-$(uname -r)
INITRD=/boot/initrd-$(uname -r).img
DESTKERNEL=$TEMPDIR/boot/vmlinuz
DESTINITRD=$TEMPDIR/boot/initrd

log_wait_msg "Copiando kernel $KERNEL to $DESTKERNEL..."
#cp -f $KERNEL $TEMPDIR/boot/vmlinuz
#cp -f $KERNEL $LFS/boot/
#rm -f $LFS/boot/vmlinuz

log_wait_msg "Copiando initrd $INITRD to $DESTINITRD..."
#cp -f $INITRD $TEMPDIR/boot/initrd
#cp -f $INITRD $LFS/boot/
#rm -f $LFS/boot/initrd

pushd $LFS/boot
#ln -sf vmlinuz-$(uname -r) vmlinuz
#ln -sf initrd-$(uname -r).img initrd
popd

log_wait_msg "Criando filesystem squashfs..."
rm -f $TEMPDIR/filesystem/root.sfs
#mksquashfs $LFS $TEMPDIR/filesystem/root.sfs -ef exclude_dir -b 1048576 -comp xz -Xdict-size 100% \
#mksquashfs $LFS $TEMPDIR/filesystem/root.sfs -ef exclude_dir -b 1M -comp zstd -Xcompression-level 1
#mksquashfs $LFS $TEMPDIR/filesystem/root.sfs -ef exclude_dir -b 1M -comp lzma
mksquashfs $LFS $TEMPDIR/filesystem/root.sfs -ef exclude_dir -b 1M -comp lz4 -Xhc
log_wait_msg "Excluindo .iso antigo..."
rm -f $OUTPUT

log_wait_msg "Criando iso $OUTPUT..."

#MBR
#xorriso -as mkisofs                                 \
#		-r -J -joliet-long                          \
#		-l -cache-inodes                            \
#		-isohybrid-mbr $ISOLINUXDIR/isohdpfx.bin    \
#		-partition_offset 16                        \
#       -iso-level 3                                \
#		-volid "${LABEL}"                           \
#		-b isolinux/isolinux.bin                    \
#		-c isolinux/boot.cat                        \
#		-no-emul-boot                               \
#		-boot-load-size 4                           \
#		-boot-info-table                            \
#		-o $OUTPUT                                  \
#		$TEMPDIR

#hibrido MBR/EFI
# "-boot-load-size 4 -boot-info-table" deve ser escrito antes de "-eltorito-alt-boot", porque eles servem como opções de modificação para "-b". 
# Depois de "-eltorito-alt-boot" vem o reino de "-e". 
# Lá você precisa de outra opção "-no-emul-boot" (como em "-b") para evitar a mensagem de erro sobre tamanhos de emulação de disquete. 
# Mas não use "-boot-load-size" ou "-boot-info-table" para a imagem EFI
#xorriso -as mkisofs -r                              \
#		-J -l -b isolinux/isolinux.bin             \
#		-c isolinux/boot.cat                        \
#		-no-emul-boot                               \
#		-isohybrid-mbr $ISOLINUXDIR/isohdpfx.bin    \
#       -eltorito-alt-boot                          \
#		-no-emul-boot                               \
#       -e isolinux/efiboot.img                     \
#       -no-emul-boot                               \
#        -isohybrid-gpt-basdat                       \
#		-volid "${LABEL}"                           \
#		-o $OUTPUT                                  \
#		$TEMPDIR

xorriso -as mkisofs \
  -o live.iso \
  -isohybrid-mbr $ISOLINUXDIR/isohdpfx.bin    \
  -c isolinux/boot.cat \
  -b isolinux/isolinux.bin \
   -no-emul-boot -boot-load-size 4 -boot-info-table \
  -eltorito-alt-boot \
  -e isolinux/efi.img \
   -no-emul-boot \
   -isohybrid-gpt-basdat \
   $TEMPDIR

#rm -fr $TEMPDIR
log_success_msg2 "Arquivo iso $OUTPUT criado com sucesso!"
