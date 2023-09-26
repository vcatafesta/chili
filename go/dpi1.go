// go get github.com/BurntSushi/xgb
// go get github.com/BurntSushi/xgb/xproto


package main

import (
	"fmt"
	"os"

	"github.com/BurntSushi/xgb"
	"github.com/BurntSushi/xgb/xproto"
)

func main() {
	X, err := xgb.NewConn()
	if err != nil {
		fmt.Println("Erro ao conectar ao servidor X:", err)
		os.Exit(1)
	}
	defer X.Close()

	screen := xproto.Setup(X).DefaultScreen(X)
	dpiWidth := screen.WidthInPixels / (screen.WidthInMillimeters / 25.4)
	dpiHeight := screen.HeightInPixels / (screen.HeightInMillimeters / 25.4)

	fmt.Printf("Resolução DPI (Largura): %d\n", dpiWidth)
	fmt.Printf("Resolução DPI (Altura): %d\n", dpiHeight)
}
