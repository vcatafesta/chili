#!/usr/bin/python
# -*- coding: utf-8 -*-
#
#  chili-getntpdatetime.py - atualiza a data e hora do sistema utilizando um servidor NTP,
#  e exibe as informações atualizadas em uma interface gráfica GTK.
#
#  Created: 2019/08/22 - 12:05
#  Altered: 2024/11/15 - 03:05
#
#  Copyright (c) 2019-2024, Vilmar Catafesta <vcatafesta@gmail.com>
#  All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions
#  are met:
#  1. Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#  2. Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR AS IS'' AND ANY EXPRESS OR
#  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
#  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
#  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
#  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
#  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
#  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
#  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
#  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
##############################################################################

import gi
import subprocess
import os

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, Gdk
from datetime import datetime


class TimeUpdater(Gtk.Window):
    def __init__(self):
        super().__init__(title="Sincronizar data e hora")
        self.set_border_width(10)
        self.set_default_size(400, 300)

        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=6)
        self.add(vbox)

        self.button = Gtk.Button(label="Sincronizar com NTP agora")
        self.button.connect("clicked", self.update_time)
        vbox.pack_start(self.button, False, False, 0)

        # Mostrar o calendário e informações de data
        self.date_label = Gtk.Label(label="Data e Hora Atual")
        vbox.pack_start(self.date_label, False, False, 10)

        self.calendar = Gtk.Calendar()
        vbox.pack_start(self.calendar, True, True, 0)

        self.time_label = Gtk.Label(label="Hora Atual: " + self.get_current_time())
        vbox.pack_start(self.time_label, False, False, 10)

        self.update_time(None)

    def run_as_root(self, commands):
        """Executa múltiplos comandos com uma única chamada ao `pkexec`."""
        command_str = " && ".join(commands)
        try:
            result = subprocess.run(
                ["pkexec", "bash", "-c", command_str],
                check=True,
                text=True,
                capture_output=True,
            )
            print(f"Comando executado: {command_str}")
            print(f"Saída: {result.stdout.strip()}")
            return True
        except subprocess.CalledProcessError as e:
            print(f"Erro ao executar comandos: {command_str}")
            print(f"Saída de erro: {e.stderr.strip()}")
            return False

    def update_time(self, widget):
        # Comandos para atualizar a hora via NTP
        commands = [
            "timedatectl set-ntp true",  # Ativa o NTP para sincronizar automaticamente com servidores de tempo
            "hwclock --systohc",  # Atualiza o relógio do sistema (hardware)
        ]

        if self.run_as_root(commands):
            print("Data e hora sincronizadas com sucesso via NTP.")
        else:
            print("Falha ao sincronizar data/hora com NTP.")

        # Atualiza a data e hora na interface
        self.time_label.set_text("Hora Atual: " + self.get_current_time())

    def get_current_time(self):
        # Obtém a data e hora atual
        return datetime.now().strftime("%Y-%m-%d %H:%M:%S")


if __name__ == "__main__":
    win = TimeUpdater()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()
