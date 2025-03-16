#!/usr/bin/python3
# -*- coding: utf-8 -*-

#!/usr/bin/env python3

import os
import sys
import subprocess


def check_arguments():
    """Verifica se os argumentos foram passados corretamente."""
    if len(sys.argv) < 4:
        print(f"Uso: {sys.argv[0]} <partição> <partição_efi> <ponto de montagem>")
        sys.exit(1)


def check_partition(partition):
    """Verifica se a partição existe."""
    if not os.path.exists(partition):
        print(f"Erro: A partição '{partition}' não existe!")
        sys.exit(1)


def create_directory(directory):
    """Cria o diretório de instalação, se não existir."""
    if not os.path.isdir(directory):
        print(f"Criando diretório '{directory}'...")
        try:
            os.makedirs(directory, exist_ok=True)
        except Exception as e:
            print(f"Erro ao criar '{directory}': {e}")
            sys.exit(1)


def mount_subvolumes(partition, install_dir):
    """Monta os subvolumes no diretório de instalação."""
    subvolumes = ["@", "@home", "@cache", "@log", "@swapfc"]

    for subvol in subvolumes:
        mount_point = os.path.join(
            install_dir, subvol.lstrip("@")
        )  # Remove '@' do nome
        os.makedirs(mount_point, exist_ok=True)

        print(f"Montando {partition} em {mount_point} com subvolume={subvol}...")
        cmd = [
            "sudo",
            "mount",
            "-o",
            f"compress=zstd,subvol={subvol}",
            partition,
            mount_point,
        ]

        try:
            subprocess.run(cmd, check=True)
        except subprocess.CalledProcessError:
            print(f"Erro ao montar {subvol} em {mount_point}!")
            sys.exit(1)


def mount_efi(efi_partition, install_dir):
    """Monta a partição EFI."""
    efi_mount_point = os.path.join(install_dir, "boot/efi")
    os.makedirs(efi_mount_point, exist_ok=True)

    print(f"Montando partição EFI {efi_partition} em {efi_mount_point}...")
    cmd = ["sudo", "mount", efi_partition, efi_mount_point]

    try:
        subprocess.run(cmd, check=True)
    except subprocess.CalledProcessError:
        print(f"Erro ao montar a partição EFI em {efi_mount_point}!")
        sys.exit(1)


if __name__ == "__main__":
    check_arguments()

    partition = sys.argv[1]
    efi_partition = sys.argv[2]
    install_dir = sys.argv[3]

    check_partition(partition)
    check_partition(efi_partition)
    create_directory(install_dir)

    mount_subvolumes(partition, install_dir)
    mount_efi(efi_partition, install_dir)

    print("✅ Montagem concluída com sucesso!")
