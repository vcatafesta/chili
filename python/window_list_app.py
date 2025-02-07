#!/usr/bin/python3
# -*- coding: utf-8 -*-

import gi
import subprocess
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class WindowListApp(Gtk.Window):
    def __init__(self):
        super().__init__(title="Lista de Janelas Abertas")

        # Definir o tamanho da janela
        self.set_default_size(400, 300)

        # Criar um VBox para adicionar widgets
        self.box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        self.add(self.box)

        # Criar um ListBox para exibir as janelas
        self.window_list = Gtk.ListBox()
        self.box.pack_start(self.window_list, True, True, 0)

        # Botão para atualizar a lista de janelas
        self.refresh_button = Gtk.Button(label="Atualizar Janelas")
        self.refresh_button.connect("clicked", self.refresh_window_list)
        self.box.pack_start(self.refresh_button, False, False, 0)

        # Inicializa a lista de janelas
        self.refresh_window_list(None)

    def refresh_window_list(self, widget):
        # Limpar a lista atual
        self.window_list.foreach(lambda x: self.window_list.remove(x))

        # Usar wmctrl para listar as janelas abertas
        try:
            # Obtém as janelas abertas usando wmctrl
            result = subprocess.check_output(["wmctrl", "-l"], universal_newlines=True)

            # Adiciona cada janela na lista
            for line in result.splitlines():
                window_info = line.split(None, 3)  # Divide a linha para obter o nome da janela
                if len(window_info) >= 4:
                    window_title = window_info[3]
                    row = Gtk.ListBoxRow()
                    label = Gtk.Label(label=window_title)
                    row.add(label)
                    self.window_list.add(row)

            self.window_list.show_all()

        except subprocess.CalledProcessError:
            print("Erro ao listar as janelas com wmctrl.")
            pass

# Criar a janela principal
app = WindowListApp()

# Conectar a função de fechamento da janela
app.connect("destroy", Gtk.main_quit)

# Exibir a janela
app.show_all()

# Iniciar o loop GTK
Gtk.main()
