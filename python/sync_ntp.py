#!/usr/bin/env python3
import subprocess

def sync_time():
    try:
        subprocess.run(["pkexec", "timedatectl", "set-ntp", "true"], check=True)
        print("Hora sincronizada com sucesso!")
    except subprocess.CalledProcessError:
        print("Erro ao sincronizar a hora.")

if __name__ == "__main__":
    sync_time()
