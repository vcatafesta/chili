#!/usr/bin/python3
# -*- coding: utf-8 -*-


import gi
gi.require_version('Gtk', '4.0')
from gi.repository import Gtk, Gdk

class JanelaPrincipal(Gtk.ApplicationWindow):
    def __init__(self, app):
        super().__init__(application=app, title="Janela com Botões Coloridos")

        # Definir o tamanho da janela
        self.set_default_size(300, 200)

        # Criar um box vertical para organizar os botões
        box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        self.set_child(box)

        # Criar o primeiro botão
        botao1 = Gtk.Button(label="Botão 1")
        # Adicionar a classe CSS ao botão
        botao1.get_style_context().add_class("color1")
        box.append(botao1)

        # Criar o segundo botão
        botao2 = Gtk.Button(label="Botão 2")
        # Adicionar a classe CSS ao botão
        botao2.get_style_context().add_class("color2")
        box.append(botao2)

class MinhaAplicacao(Gtk.Application):
    def __init__(self):
        super().__init__(application_id="com.example.GtkApplication")

    def do_activate(self):
        janela = JanelaPrincipal(self)
        janela.show()

# Função principal
def main():
    app = MinhaAplicacao()

    # Criar um arquivo CSS para os estilos
    css_provider = Gtk.CssProvider()
    css = """
    button.color1 {
        background-color: #32CD32; /* Verde */
        color: blue;
        border-radius: 5px;
        padding: 10px;
    }

    button.color2 {
        background-color: #ADD8E6; /* Azul Claro */
        color: green;
        border-radius: 5px;
        padding: 10px;
    }
    """
    css_provider.load_from_data(css.encode())

    # Corrigido: Usar o método correto 'add_provider_for_display'
    Gtk.StyleContext.add_provider_for_display(
        Gdk.Display.get_default(), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
    )

    app.run()

if __name__ == "__main__":
    main()

