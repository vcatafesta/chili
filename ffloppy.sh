#!/usr/bin/env bash
# shellcheck shell=bash disable=SC1091,SC2039,SC2166

ffloppy() {
	IMG=$1
	[[ -f $IMG ]] || { echo "Imagem $IMG não encontrada!"; exit 1; }
#	qemu-system-i386 -drive file=$IMG,format=raw,index=0,if=floppy
#	qemu-system-x86_64 -drive file=$IMG,index=0,if=floppy,format=raw
#	qemu-system-x86_64 -blockdev driver=file,node-name=f0,filename=$IMG -device floppy,drive=f0
	qemu-system-x86_64 -fda $IMG
}


