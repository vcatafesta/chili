{-# LANGUAGE OverloadedStrings #-}

import Graphics.UI.Gtk

-- Função principal
main :: IO ()
main = do
  -- Inicializa a biblioteca GTK
  initGUI

  -- Cria uma janela
  window <- windowNew
  set window [windowTitle := "Programa Haskell com GTK", windowDefaultWidth := 300, windowDefaultHeight := 200]

  -- Cria um botão
  button <- buttonNew
  set button [buttonLabel := "Clique aqui!"]

  -- Define o comportamento do botão (quando clicado)
  _ <- on button buttonActivated $ do
    putStrLn "Botão clicado!"

  -- Adiciona o botão à janela
  containerAdd window button

  -- Define o que acontece quando a janela é fechada
  _ <- on window objectDestroy mainQuit

  -- Exibe a janela
  widgetShowAll window

  -- Inicia o loop principal da interface gráfica
  mainGUI
