trap cleanup_working_dir EXIT

cleanup_working_dir() {
  [[ -d "${working_dir}" ]] && rm -rf -- "${working_dir}"
}

frv() {
  if [[ $# -lt 1 ]]; then
    cat <<EOF
Usage:
  frv file.iso
  frv file.img
  frv /dev/sdX
EOF
    return 1
  fi

  local ovmf_code='/usr/share/edk2/x64/OVMF_CODE.4m.fd'
  local ovmf_vars='/usr/share/edk2/x64/OVMF_VARS.4m.fd'
  [[ ! -f "${ovmf_vars}" ]] && {
    echo "ERROR: ${ovmf_vars} not found. Install edk2-ovmf."
    return 1
  }

  local working_dir
  working_dir="$(mktemp -dt frv.XXXXXXXXXX)"
  cp -av -- "${ovmf_vars}" "${working_dir}/OVMF_VARS.4m.fd"

  local qemu_common_options=(
    -machine type=q35,smm=on,accel=kvm,usb=on,pcspk-audiodev=snd0
    -cpu host
    -smp "$(nproc)"
    -name 'Chili'
    -m 8G
    -vga virtio
    -display gtk
    -device virtio-net-pci,netdev=net0
    -netdev user,id=net0
    -device intel-hda
    #-audiodev pa,id=snd0,server=localhost
    -audiodev none,id=snd0
    -device hda-output,audiodev=snd0
    -drive if=pflash,format=raw,unit=0,file=${ovmf_code},read-only=off
    -drive if=pflash,format=raw,unit=1,file=${working_dir}/OVMF_VARS.4m.fd
    -serial stdio
  )

  if [[ "${1}" =~ \.iso$ ]]; then
    qemu_options=(
      "${qemu_common_options[@]}"
      -cdrom "$1"
      -boot d
      -drive file=/archlive/qemu/hda.img,if=virtio,format=raw,cache=writeback
      -drive file=/archlive/qemu/hdb.img,if=virtio,format=raw,cache=writeback
      -drive file=/archlive/qemu/hdc.img,if=virtio,format=raw,cache=writeback
      -drive file=/archlive/qemu/hdd.img,if=virtio,format=raw,cache=writeback
    )
  else
    qemu_options=(
      "${qemu_common_options[@]}"
      -drive file="$1",if=virtio,format=raw
      -drive file=/archlive/qemu/hda.img,if=virtio,format=raw,cache=writeback
    )
  fi

  sudo qemu-system-x86_64 "${qemu_options[@]}"
}
