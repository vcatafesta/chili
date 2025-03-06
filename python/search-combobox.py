#!/usr/bin/env python3
import gi
import subprocess
import pytz

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class TimeUpdater(Gtk.Window):
    def __init__(self):
        super().__init__(title="Exemplo de Timezone")
        self.set_border_width(10)
        self.set_default_size(400, 200)

        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=6)
        self.add(vbox)

        # Caixa horizontal para agrupar campo de busca, botão e combobox
        hbox_search = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=6)

        # Campo de busca
        self.search_entry = Gtk.Entry()
        self.search_entry.set_placeholder_text("Buscar cidade/timezone")
        # Aciona a busca ao pressionar Enter
        self.search_entry.connect("activate", self.on_search_activate)
        hbox_search.pack_start(self.search_entry, True, True, 0)

        # Botão de busca
        self.search_button = Gtk.Button(label="Buscar")
        self.search_button.connect("clicked", self.on_search_activate)
        hbox_search.pack_start(self.search_button, False, False, 0)

        # Combobox para exibir as timezones disponíveis
        self.timezone_combobox = Gtk.ComboBoxText()
        self.populate_timezones()           # Popula o combobox com todas as timezones
        self.set_current_zoneinfo()         # Seleciona a timezone atual do sistema
        hbox_search.pack_start(self.timezone_combobox, False, False, 0)

        # Adiciona a caixa de busca ao container principal
        vbox.pack_start(hbox_search, False, False, 10)

    def populate_timezones(self):
        """Popula o ComboBox com a lista de timezones disponíveis."""
        self.timezone_list = list(pytz.all_timezones)
        for tz in self.timezone_list:
            self.timezone_combobox.append_text(tz)

    def set_current_zoneinfo(self):
        """Obtém a timezone atual do sistema e a define como selecionada no ComboBox."""
        result = subprocess.run(
            ["timedatectl", "show", "--property=Timezone", "--value"],
            capture_output=True,
            text=True
        )
        current_zone = result.stdout.strip()
        for idx, tz in enumerate(self.timezone_list):
            if tz == current_zone:
                self.timezone_combobox.set_active(idx)
                break

    def on_search_activate(self, widget):
        """
        Callback para a busca.
        Normaliza o texto de busca (converte espaços em underscores) e seleciona no combobox
        a timezone que contenha o texto buscado. Exemplos:
          "porto velho", "Porto_Velho", "porto_velho" resultarão em "Porto_Velho".
        """
        search_text = self.search_entry.get_text().strip().lower()
        normalized_search = search_text.replace(" ", "_")
        found = False
        for idx, tz in enumerate(self.timezone_list):
            normalized_tz = tz.lower().replace(" ", "_")
            if normalized_search in normalized_tz:
                self.timezone_combobox.set_active(idx)
                found = True
                break
        if not found:
            print("Nenhum timezone encontrado.")

if __name__ == "__main__":
    win = TimeUpdater()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()
