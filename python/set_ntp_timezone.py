#!/usr/bin/env python
import subprocess
import sys
import re
from zoneinfo import ZoneInfo, available_timezones
from datetime import datetime

def colorize(text, color):
    colors = {
        "red": "\033[91m",
        "green": "\033[92m",
        "yellow": "\033[93m",
        "blue": "\033[94m",
        "reset": "\033[0m"
    }
    return f"{colors.get(color, colors['reset'])}{text}{colors['reset']}"

def normalize_timezone_input(input_str):
    normalized = re.sub(r'[^a-zA-Z0-9]', '_', input_str).lower()
    for tz in available_timezones():
        tz_normalized = tz.lower().replace("_", " ")
        if normalized in tz_normalized or normalized.replace("_", " ") in tz_normalized:
            return tz
    print(colorize("Erro: Timezone não encontrado.", "red"))
    sys.exit(1)

def set_timezone(timezone: str):
    try:
        # Verifica se o timezone é válido
        tz = ZoneInfo(timezone)
        print(colorize(f"Definindo timezone para: {timezone}", "blue"))
        
        # Atualiza o timezone do sistema
        subprocess.run(["timedatectl", "set-timezone", timezone], check=True)
        print(colorize("Timezone atualizado com sucesso.", "green"))
    except Exception as e:
        print(colorize(f"Erro ao definir o timezone: {e}", "red"))
        sys.exit(1)

def sync_time():
    try:
        print(colorize("Habilitando sincronização NTP...", "blue"))
        subprocess.run(["timedatectl", "set-ntp", "true"], check=True)  # Ativa a sincronização NTP
        print(colorize("Sincronização NTP ativada com sucesso.", "green"))
    except Exception as e:
        print(colorize(f"Erro ao ativar a sincronização NTP: {e}", "red"))
        sys.exit(1)

def sync_hwclock():
    try:
        print(colorize("Atualizando o hardware clock...", "blue"))
        subprocess.run(["hwclock", "--systohc"], check=True)
        print(colorize("Hardware clock atualizado com sucesso.", "green"))
    except Exception as e:
        print(colorize(f"Erro ao atualizar o hardware clock: {e}", "red"))
        sys.exit(1)

def main():
    if len(sys.argv) != 2:
        print(colorize("Uso: python script.py <Cidade/Região>", "yellow"))
        sys.exit(1)
    
    raw_input = sys.argv[1]
    timezone = normalize_timezone_input(raw_input)
    set_timezone(timezone)
    sync_time()
    sync_hwclock()
    subprocess.run(["timedatectl"], check=True)
    print(colorize("Processo concluído com sucesso!", "green"))

if __name__ == "__main__":
    main()
