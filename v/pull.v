import vgui

fn main() {
    // Crie um novo menu
    menu := vgui.menu.new()

    // Adicione algumas opções
    menu.add_option('Opção 1', option_one)
    menu.add_option('Opção 2', option_two)
    menu.add_option('Opção 3', option_three)

    // Adicione um botão para exibir o menu pulldown
    button := vgui.button.new('Abrir menu')
    button.on_click = fn () {
        menu.show(button)
    }

    // Crie uma janela para exibir o botão
    window := vgui.window.new('Menu Pulldown')
    window.add(button)
    window.show()
}

fn option_one() {
    println('Opção 1 selecionada')
}

fn option_two() {
    println('Opção 2 selecionada')
}

fn option_three() {
    println('Opção 3 selecionada')
}
