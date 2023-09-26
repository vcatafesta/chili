package main

import (
    "github.com/gotk3/gotk3/gtk"
)

func main() {
    // Inicializa o ambiente GTK
    gtk.Init(nil)

    // Cria uma nova janela
    win, err := gtk.WindowNew(gtk.WINDOW_TOPLEVEL)
    if err != nil {
        panic(err)
    }

    // Define o título da janela
    win.SetTitle("Exemplo GTK em Go")

    // Configura a função de fechamento da janela
    win.Connect("destroy", func() {
        gtk.MainQuit()
    })

    // Cria um rótulo com algum texto
    label, _ := gtk.LabelNew("Olá, GTK em Go!")

    // Adiciona o rótulo à janela
    win.Add(label)

    // Define o tamanho da janela
    win.SetDefaultSize(400, 200)

    // Exibe todos os elementos da janela
    win.ShowAll()

    // Inicia o loop principal do GTK
    gtk.Main()
}
