#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Este script gerencia a configuração de timezones e sincronização de tempo em sistemas Linux.

Funções principais:
1. **check_root()** - Verifica se o script está sendo executado com privilégios de superusuário (root).
2. **colorize(text, color)** - Adiciona cores à saída do terminal para tornar as mensagens mais visíveis.
3. **normalize_timezone_input(input_str)** - Normaliza o input do timezone fornecido, procurando uma correspondência na lista de timezones disponíveis.
4. **set_timezone(timezone)** - Define o timezone do sistema utilizando o comando 'timedatectl'.
5. **sync_time()** - Ativa a sincronização NTP (Network Time Protocol) para garantir que o relógio do sistema esteja atualizado.
6. **sync_hwclock()** - Atualiza o relógio de hardware do sistema.
7. **show_usage()** - Exibe a mensagem de uso do script com exemplos de como usá-lo corretamente.
8. **main()** - Ponto de entrada principal do script, onde as operações são executadas na ordem correta.

Fluxo geral de execução:
1. O script começa verificando se foi fornecido um parâmetro (o nome de uma cidade ou região representando um timezone).
2. Caso o parâmetro não seja fornecido ou seja inválido, ele exibe os exemplos de uso.
3. O script verifica se está sendo executado como root (necessário para realizar alterações de configuração).
4. O timezone é normalizado e validado.
5. O timezone é então configurado usando o comando `timedatectl`.
6. O script ativa a sincronização NTP e atualiza o relógio de hardware.
7. Finalmente, o status do `timedatectl` é exibido para confirmar as alterações feitas.

Exemplos de execução:
- Para definir o timezone como São Paulo (Brasil):
  python script.py America/Sao_Paulo
- Para definir o timezone como Lisboa (Portugal):
  python script.py Europe/Lisbon
- Para definir o timezone como Tóquio (Japão):
  python script.py Asia/Tokyo
- Caso o usuário passe um nome alternativo, como "Porto Velho" ou "São Paulo" (em português), o script também conseguirá identificar e configurar o timezone correto.
"""

import subprocess
import sys
import re
import os
from zoneinfo import ZoneInfo, available_timezones
from datetime import datetime


class TimezoneManager:
    def __init__(self):
        self.colors = {
            "red": "\033[91m",
            "green": "\033[92m",
            "yellow": "\033[93m",
            "blue": "\033[94m",
            "reset": "\033[0m",
        }

    def colorize(self, text, color):
        return f"{self.colors.get(color, self.colors['reset'])}{text}{self.colors['reset']}"

    def check_root(self):
        if not os.geteuid() == 0:
            print(
                self.colorize(
                    "Este script precisa ser executado com privilégios de superusuário (root).",
                    "red",
                )
            )
            sys.exit(1)

    def normalize_timezone_input(self, input_str):
        normalized = re.sub(r"[^a-zA-Z0-9]", "_", input_str).lower()
        for tz in available_timezones():
            tz_normalized = tz.lower().replace("_", " ")
            if (
                normalized in tz_normalized
                or normalized.replace("_", " ") in tz_normalized
            ):
                return tz
        print(self.colorize("Erro: Timezone não encontrado.", "red"))
        sys.exit(1)

    def set_timezone(self, timezone: str):
        try:
            tz = ZoneInfo(timezone)
            print(self.colorize(f"Definindo timezone para: {timezone}", "blue"))
            subprocess.run(
                ["sudo", "timedatectl", "set-timezone", timezone], check=True
            )
            print(self.colorize("Timezone atualizado com sucesso.", "green"))
        except Exception as e:
            print(self.colorize(f"Erro ao definir o timezone: {e}", "red"))
            sys.exit(1)

    def sync_time(self):
        try:
            print(self.colorize("Habilitando sincronização NTP...", "blue"))
            subprocess.run(["sudo", "timedatectl", "set-ntp", "true"], check=True)
            print(self.colorize("Sincronização NTP ativada com sucesso.", "green"))
        except Exception as e:
            print(self.colorize(f"Erro ao ativar a sincronização NTP: {e}", "red"))
            sys.exit(1)

    def sync_hwclock(self):
        try:
            print(self.colorize("Atualizando o hardware clock...", "blue"))
            subprocess.run(["sudo", "hwclock", "--systohc"], check=True)
            print(self.colorize("Hardware clock atualizado com sucesso.", "green"))
        except Exception as e:
            print(self.colorize(f"Erro ao atualizar o hardware clock: {e}", "red"))
            sys.exit(1)


    def show_usage(self):
        script_name = os.path.basename(sys.argv[0])  # Obtém apenas o nome do script
        print(self.colorize(f"Uso: python {script_name} <Cidade/Região>", "yellow"))
        print("\nExemplos de uso:")
        print(self.colorize(f"    {script_name} America/Sao_Paulo", "blue"))
        print(self.colorize(f"    {script_name} Europe/Lisbon", "blue"))
        print(self.colorize(f"    {script_name} Asia/Tokyo", "blue"))
        print(self.colorize(f"    {script_name} America/Porto_Velho", "blue"))
        print(self.colorize(f"    {script_name} Porto Velho", "blue"))
        print(self.colorize(f"    {script_name} porto velho", "blue"))
        sys.exit(1)

    def main(self):
        if len(sys.argv) < 2:
            self.show_usage()  # Se não houver parâmetros, mostra o usage e exemplos

        self.check_root()  # Verifica se o script está sendo executado como root

        raw_input = " ".join(
            sys.argv[1:]
        )  # Junta todos os argumentos como uma única string
        timezone = self.normalize_timezone_input(raw_input)
        self.set_timezone(timezone)
        self.sync_time()
        self.sync_hwclock()
        subprocess.run(["sudo", "timedatectl"], check=True)
        print(self.colorize("Processo concluído com sucesso!", "green"))


if __name__ == "__main__":
    manager = TimezoneManager()
    manager.main()
