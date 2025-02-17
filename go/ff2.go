package main

import (
  "fmt"
  "os"
  "path/filepath"
)

func main() {
  root := "/"
  target := "pacman.conf"

  filepath.Walk(root, func(path string, info os.FileInfo, err error) error {
    if err == nil && info.Name() == target {
      fmt.Println(path)
    }
    return nil
  })
}
