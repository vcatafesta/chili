// go get github.com/go-gl/glfw/v3.3/glfw
// go get github.com/shirou/gopsutil/host

package main

import (
	"fmt"
	"os/exec"
	"strings"
)

func getDPI() (string, error) {
	cmd := exec.Command("xrdb", "-query")
	output, err := cmd.Output()
	if err != nil {
		return "", err
	}

	lines := strings.Split(string(output), "\n")
	for _, line := range lines {
		if strings.Contains(line, "Xft.dpi") {
			parts := strings.Split(line, ":")
			if len(parts) == 2 {
				dpi := strings.TrimSpace(parts[1])
				return dpi, nil
			}
		}
	}

	return "", fmt.Errorf("DPI não encontrado")
}

func main() {
	dpi, err := getDPI()
	if err != nil {
		fmt.Println("Erro ao obter DPI:", err)
		return
	}

	fmt.Printf("Resolução DPI: %s\n", dpi)
}

