#!/usr/bin/python3
# -*- coding: utf-8 -*-

import gi

gi.require_version("Gtk", "3.0")  # Definir a versão do GTK
from gi.repository import Gtk


class SimpleApp(Gtk.Window):
    def __init__(self):
        super().__init__(title="Chili - APP Simples para Cinnamon")

        # Definir o tamanho da janela
        self.set_default_size(300, 200)

        # Criar um botão
        self.button = Gtk.Button(label="Clique aqui!")
        self.button.connect("clicked", self.on_button_clicked)

        # Adicionar o botão à janela
        self.add(self.button)

    def on_button_clicked(self, widget):
        print("Você clicou no botão!")


# Criar a janela
app = SimpleApp()

# Conectar a função de fechamento da janela
app.connect("destroy", Gtk.main_quit)

# Exibir a janela
app.show_all()

# Iniciar o loop GTK
Gtk.main()
