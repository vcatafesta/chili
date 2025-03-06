#!/usr/bin/env python3
import gi
import subprocess
from datetime import datetime
import pytz

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class TimeUpdater(Gtk.Window):
    def __init__(self):
        super().__init__(title="Sincronizar data e hora")
        self.set_border_width(10)
        self.set_default_size(400, 350)

        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=6)
        self.add(vbox)

        # Mostrar o calendário
        self.calendar = Gtk.Calendar()
        vbox.pack_start(self.calendar, True, True, 0)

        # Caixa para mostrar a data
        self.date_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        self.date_label = Gtk.Label(label="Data Atual:")
        self.date_label.set_markup('<span size="small">Data Atual:</span>')
        self.date_box.pack_start(self.date_label, False, False, 0)
        self.date_value = Gtk.Label(label=self.get_current_date())
        self.date_value.set_markup('<span size="xx-large">' + self.get_current_date() + '</span>')
        self.date_box.pack_start(self.date_value, False, False, 0)
        vbox.pack_start(self.date_box, False, False, 10)

        # Caixa para mostrar a hora
        self.time_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        self.time_label = Gtk.Label(label="Hora Atual:")
        self.time_label.set_markup('<span size="small">Hora Atual:</span>')
        self.time_box.pack_start(self.time_label, False, False, 0)
        self.time_value = Gtk.Label(label=self.get_current_time())
        self.time_value.set_markup('<span size="xx-large">' + self.get_current_time() + '</span>')
        self.time_box.pack_start(self.time_value, False, False, 0)
        vbox.pack_start(self.time_box, False, False, 10)

        # ComboBox para selecionar a zoneinfo
        self.zone_info_combobox = Gtk.ComboBoxText()
        self.zone_info_combobox.set_entry_text_column(0)
        self.populate_zoneinfo()
        self.set_current_zoneinfo()

        # Caixa de busca e combobox (caixa horizontal)
        self.search_entry = Gtk.Entry()
        self.search_entry.set_placeholder_text("Buscar por zona")
        self.search_entry.connect("activate", self.on_search_activate)
        self.search_button = Gtk.Button(label="Buscar")
        self.search_button.connect("clicked", self.on_search_activate)
        search_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=6)
        search_box.pack_start(self.search_entry, True, True, 0)
        search_box.pack_start(self.search_button, False, False, 0)
        search_box.pack_start(self.zone_info_combobox, False, False, 0)
        vbox.pack_start(search_box, False, False, 10)

        # Botão para sincronizar
        self.button = Gtk.Button(label="Sincronizar com NTP agora")
        self.button.connect("clicked", self.update_time)
        vbox.pack_start(self.button, False, False, 0)

    def run_as_root(self, commands):
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
        # Obtém a zona selecionada no ComboBox
        selected_zone = self.zone_info_combobox.get_active_text()
        if selected_zone:
            commands = [
                f"timedatectl set-timezone {selected_zone}",
                "timedatectl set-ntp true",
                "hwclock --systohc",
            ]
            if self.run_as_root(commands):
                print(f"Data e hora sincronizadas com sucesso para a zona: {selected_zone}.")
            else:
                print(f"Falha ao sincronizar data/hora para a zona: {selected_zone}.")
        self.time_value.set_markup('<span size="xx-large">' + self.get_current_time() + '</span>')
        self.date_value.set_markup('<span size="xx-large">' + self.get_current_date() + '</span>')

    def get_current_time(self):
        return datetime.now().strftime("%H:%M:%S")

    def get_current_date(self):
        return datetime.now().strftime("%d/%m/%Y")

    def populate_zoneinfo(self):
        zone_list = self.get_zoneinfo_list()
        for zone in zone_list:
            self.zone_info_combobox.append_text(zone)

    def get_zoneinfo_list(self):
        result = subprocess.run(
            ["timedatectl", "list-timezones"],
            capture_output=True,
            text=True
        )
        return result.stdout.splitlines()

    def set_current_zoneinfo(self):
        result = subprocess.run(
            ["timedatectl", "show", "--property=Timezone", "--value"],
            capture_output=True,
            text=True
        )
        current_zone = result.stdout.strip()
        active_index = self.zone_info_combobox.get_model().iter_n_children(None)
        for i in range(active_index):
            if self.zone_info_combobox.get_model().get_value(
                self.zone_info_combobox.get_model().get_iter(i), 0
            ) == current_zone:
                self.zone_info_combobox.set_active(i)
                break

    def on_search_activate(self, widget):
        # Normaliza o texto de busca: converte espaços para underscores e transforma para minúsculas
        search_text = self.search_entry.get_text().strip().lower()
        normalized_search = search_text.replace(" ", "_")
        found = False
        for idx, tz in enumerate(self.get_zoneinfo_list()):
            normalized_tz = tz.lower().replace(" ", "_")
            if normalized_search in normalized_tz:
                self.zone_info_combobox.set_active(idx)
                found = True
                break
        if not found:
            print("Nenhum timezone encontrado.")

if __name__ == "__main__":
    win = TimeUpdater()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()
