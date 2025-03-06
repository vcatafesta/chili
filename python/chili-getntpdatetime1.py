#!/usr/bin/python
# -*- coding: utf-8 -*-
#
#  chili-getntpdatetime.py - atualiza a data e hora do sistema utilizando um servidor NTP,
#  ajusta o fuso horário conforme necessário e exibe as informações atualizadas em uma interface gráfica GTK.
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
from datetime import datetime
import pytz
import tzlocal

import os

print("DISPLAY:", os.environ.get("DISPLAY"))
print("XAUTHORITY:", os.environ.get("XAUTHORITY"))
print("DBUS_SESSION_BUS_ADDRESS:", os.environ.get("DBUS_SESSION_BUS_ADDRESS"))

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk


class TimeUpdater(Gtk.Window):
    def __init__(self):
        super().__init__(title="Sincronizar data e hora")
        self.set_border_width(10)
        self.set_default_size(400, 400)

        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=6)
        self.add(vbox)

        self.calendar = Gtk.Calendar()
        vbox.pack_start(self.calendar, False, False, 0)

        self.hour_adjustment = Gtk.Adjustment(
            value=datetime.now().hour, lower=0, upper=23, step_increment=1
        )
        self.hour_spinner = Gtk.SpinButton(adjustment=self.hour_adjustment)
        self.hour_spinner.set_numeric(True)
        self.hour_spinner.set_digits(0)
        self.hour_spinner.set_wrap(True)
        self.hour_spinner.connect("output", self.format_value_callback)
        vbox.pack_start(self.hour_spinner, False, False, 0)

        self.minute_adjustment = Gtk.Adjustment(
            value=datetime.now().minute, lower=0, upper=59, step_increment=1
        )
        self.minute_spinner = Gtk.SpinButton(adjustment=self.minute_adjustment)
        self.minute_spinner.set_numeric(True)
        self.minute_spinner.set_digits(0)
        self.minute_spinner.set_wrap(True)
        self.minute_spinner.connect("output", self.format_value_callback)
        vbox.pack_start(self.minute_spinner, False, False, 0)

        hbox_search = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=6)
        self.search_entry = Gtk.Entry()
        self.search_entry.set_placeholder_text("Buscar cidade/timezone")
        self.search_entry.connect("activate", self.on_search_activate)
        hbox_search.pack_start(self.search_entry, True, True, 0)

        self.search_button = Gtk.Button(label="Buscar")
        self.search_button.connect("clicked", self.on_search_activate)
        hbox_search.pack_start(self.search_button, False, False, 0)

        vbox.pack_start(hbox_search, False, False, 0)

        self.timezone_label = Gtk.Label()
        self.timezone_combobox = Gtk.ComboBoxText()
        self.populate_timezones()
        vbox.pack_start(self.timezone_combobox, False, False, 0)
        vbox.pack_start(self.timezone_label, False, False, 0)

        self.button = Gtk.Button(label="Sincronizar agora")
        self.button.connect("clicked", self.update_time)
        vbox.pack_start(self.button, False, False, 0)

        self.update_timezone()

    def format_value_callback(self, spin_button):
        value = int(spin_button.get_value())
        formatted = f"{value:02d}"
        spin_button.set_text(formatted)
        return True

    def populate_timezones(self):
        self.timezone_list = list(pytz.all_timezones)
        for tz in self.timezone_list:
            self.timezone_combobox.append_text(tz)

    def update_timezone(self):
        local_timezone = tzlocal.get_localzone()
        tz_name = (
            local_timezone.key
            if hasattr(local_timezone, "key")
            else str(local_timezone)
        )
        try:
            index = self.timezone_list.index(tz_name)
        except ValueError:
            index = 0
            tz_name = self.timezone_list[0]
        self.timezone_combobox.set_active(index)
        self.timezone_label.set_text(f"Timezone atual: {tz_name}")

    def on_search_activate(self, entry):
        search_text = self.search_entry.get_text().strip().lower().replace(" ", "_")
        found = False
        for idx, tz in enumerate(self.timezone_list):
            if search_text in tz.lower():
                self.timezone_combobox.set_active(idx)
                self.timezone_label.set_text(f"Timezone atual: {tz}")
                found = True
                break
        if not found:
            self.timezone_label.set_text("Nenhum timezone encontrado.")

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
        selected_timezone = self.timezone_combobox.get_active_text()
        if selected_timezone:
            year, month, day = self.calendar.get_date()
            hour = int(self.hour_spinner.get_value())
            minute = int(self.minute_spinner.get_value())
            new_time = datetime(year, month + 1, day, hour, minute)
            tz = pytz.timezone(selected_timezone)
            localized_time = tz.localize(new_time)
            time_str = localized_time.strftime("%Y-%m-%d %H:%M:%S")

            commands = [
                "timedatectl set-ntp false",
                f"timedatectl set-timezone {selected_timezone}",
                f"timedatectl set-time '{time_str}'",
                "timedatectl set-ntp true",
            ]

            if self.run_as_root(commands):
                print(
                    f"Data e hora atualizadas para {time_str} no fuso {selected_timezone}"
                )
            else:
                print("Falha ao atualizar data/hora.")


if __name__ == "__main__":
    win = TimeUpdater()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()
