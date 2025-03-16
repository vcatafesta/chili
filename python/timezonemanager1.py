#!/usr/bin/env python

import os
import sys
import subprocess
import re
import unicodedata
from zoneinfo import ZoneInfo, available_timezones


class TimezoneManager:
    def __init__(self):
        self.use_color = True  # Controle para ativar/desativar cores
        self.colors = {
            "red": "\033[91m",
            "green": "\033[92m",
            "yellow": "\033[93m",
            "blue": "\033[94m",
            "reset": "\033[0m",
        }

    def colorize(self, text, color):
        if not self.use_color:
            return text  # Retorna texto sem cor se `--nocolor` estiver ativo
        return f"{self.colors.get(color, self.colors['reset'])}{text}{self.colors['reset']}"

    def check_root(self):
        if os.geteuid() != 0:
            print(
                self.colorize(
                    "Este script precisa ser executado com privilégios de superusuário (root).",
                    "red",
                )
            )
            sys.exit(1)

    def remove_accents(self, text):
        return "".join(
            c
            for c in unicodedata.normalize("NFD", text)
            if unicodedata.category(c) != "Mn"
        )

    def normalize_string(self, s):
        """
        Remove acentos, divide por espaços ou underscores,
        capitaliza a primeira letra de cada palavra e junta com underscore.
        Ex: "sao paulo" ou "sao_Paulo" -> "Sao_Paulo"
        """
        s_clean = self.remove_accents(s)
        # Divide por espaço ou underscore (qualquer quantidade)
        words = re.split(r"[\s_]+", s_clean)
        # Capitaliza cada palavra e filtra palavras vazias
        words = [word.capitalize() for word in words if word]
        return "_".join(words)

    def normalize_timezone_input(self, input_str):
        # Normaliza a entrada para o formato desejado, ex: "Sao_Paulo"
        norm_input = self.normalize_string(input_str)

        # Se a entrada já incluir uma barra, assumimos que o usuário passou a timezone completa
        if "/" in input_str:
            for tz in available_timezones():
                if tz == input_str:
                    return tz

        matches = []
        for tz in available_timezones():
            # Separa a timezone em partes (ex: "America/Sao_Paulo" -> ["America", "Sao_Paulo"])
            parts = tz.split("/")
            if len(parts) < 2:
                continue  # pula timezones que não possuem divisão (como "UTC")
            # Normaliza a parte da cidade (último componente)
            norm_city = self.normalize_string(parts[-1])
            if norm_city == norm_input:
                matches.append(tz)

        if len(matches) == 1:
            return matches[0]
        elif len(matches) > 1:
            # Se houver múltiplos matches, podemos optar por retornar o primeiro
            # ou implementar uma lógica de desambiguação
            return matches[0]

        # Caso não encontre nenhuma correspondência
        script_name = os.path.basename(sys.argv[0])
        print(self.colorize("Erro: Timezone não encontrada.", "red"))
        print(
            self.colorize(
                f"Use '{script_name} -l' para listar os timezones disponíveis.",
                "yellow",
            )
        )
        sys.exit(1)

    def set_timezone(self, timezone: str):
        try:
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

    def list_timezones(self):
        print(self.colorize("Timezones disponíveis:\n", "yellow"))
        for tz in sorted(available_timezones()):
            print(self.colorize(tz, "blue"))

    def show_usage(self):
        script_name = os.path.basename(sys.argv[0])
        print(self.colorize(f"Uso: python {script_name} <Região/Cidade>", "yellow"))
        print("\nOpções:")
        print(
            self.colorize(
                "    -l, --list          # Lista todos os timezones disponíveis", "blue"
            )
        )
        print(
            self.colorize(
                "    -c, --config        # Exibe configurações atuais", "blue"
            )
        )
        print(
            self.colorize("    -n, --nocolor       # Desativa cores na saída", "blue")
        )
        print(
            self.colorize(
                "    -h, --help          # Mostra esta mensagem de ajuda", "blue"
            )
        )
        print("\nExemplos de uso:")
        print(self.colorize(f"    {script_name} America/Sao_Paulo", "blue"))
        print(self.colorize(f"    {script_name} Europe/Lisbon", "blue"))
        print(self.colorize(f"    {script_name} Asia/Tokyo", "blue"))

    def main(self):
        if len(sys.argv) < 2:
            self.show_usage()
            sys.exit(1)

        args = sys.argv[1:]

        # Processa as flags primeiro
        if "-n" in args or "--nocolor" in args:
            self.use_color = False
        if "-h" in args or "--help" in args:
            self.show_usage()
            sys.exit(0)
        if "-c" in args or "--config" in args:
            subprocess.run(["timedatectl"], check=True)
            sys.exit(0)
        if "-l" in args or "--list-timezones" in args:
            self.list_timezones()
            sys.exit(0)

        # Filtra os argumentos que não são opções (não começam com '-')
        non_option_args = [arg for arg in args if not arg.startswith("-")]

        if not non_option_args:
            self.show_usage()
            sys.exit(1)

        # Junta todos os argumentos não-opção em uma única string para formar o nome da cidade
        timezone_input = " ".join(non_option_args)

        self.check_root()
        timezone = self.normalize_timezone_input(timezone_input)
        self.set_timezone(timezone)
        self.sync_time()
        self.sync_hwclock()

        print(self.colorize("Configuração de timezone concluída com sucesso.", "green"))
        subprocess.run(["timedatectl"], check=True)


if __name__ == "__main__":
    manager = TimezoneManager()
    manager.main()
