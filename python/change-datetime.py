#!/usr/bin/python3
# -*- coding: utf-8 -*-

import gi
import subprocess
from datetime import datetime

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class TimeUpdater(Gtk.Window):
    def __init__(self):
        super().__init__(title="Atualizar Hora no XFCE")
        self.set_border_width(10)
        self.set_default_size(300, 100)
        
        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=6)
        self.add(vbox)
        
        self.entry = Gtk.Entry()
        self.entry.set_text(datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
        vbox.pack_start(self.entry, True, True, 0)
        
        self.button = Gtk.Button(label="Atualizar Hora")
        self.button.connect("clicked", self.update_time)
        vbox.pack_start(self.button, True, True, 0)
    
    def update_time(self, widget):
        new_time = self.entry.get_text()
        try:
            datetime.strptime(new_time, "%Y-%m-%d %H:%M:%S")  # Verifica formato
            subprocess.run(["pkexec", "date", "--set", new_time], check=True)
            self.show_message("Hora atualizada com sucesso!")
        except ValueError:
            self.show_message("Formato inválido! Use YYYY-MM-DD HH:MM:SS")
        except subprocess.CalledProcessError:
            self.show_message("Erro ao atualizar hora. Permissões necessárias.")
    
    def show_message(self, message):
        dialog = Gtk.MessageDialog(
            transient_for=self, flags=0, message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK, text=message
        )
        dialog.run()
        dialog.destroy()

if __name__ == "__main__":
    win = TimeUpdater()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()
