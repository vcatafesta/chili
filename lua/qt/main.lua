local qt = require "qt"
local app = qt.QApplication(arg)

-- Crie uma janela principal
local window = qt.QWidget {
    windowTitle = "Minha Janela Lua/Qt",
    layout = qt.QVBoxLayout()
}

-- Adicione um rótulo à janela
local label = qt.QLabel {
    text = "Olá, Mundo!",
    alignment = qt.Qt.AlignCenter
}

-- Adicione o rótulo à janela
window.layout:addWidget(label)

-- Defina o tamanho da janela
window.size = qt.QSize(400, 200)

-- Mostre a janela
window:show()

-- Execute o loop de eventos
app.exec()
