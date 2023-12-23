/*
    triangulo - imprime um triangulo no terminal
    Chili GNU/Linux - https://github.com/vcatafesta/chili/go
    Chili GNU/Linux - https://chililinux.com
    Chili GNU/Linux - https://chilios.com.br

    Created: 2023/12/23
    Altered: 2023/12/23

    Copyright (c) 2023-2023, Vilmar Catafesta <vcatafesta@gmail.com>
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions
    are met:
    1. Redistributions of source code must retain the above copyright
        notice, this list of conditions and the following disclaimer.
    2. Redistributions in binary form must reproduce the above copyright
        notice, this list of conditions and the following disclaimer in the
        documentation and/or other materials provided with the distribution.

    THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
    IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
    OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
    IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
    INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
    NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
    DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
    THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

package main
import "fmt"

func main() {
    altura := 20
    for i := 1; i <= altura; i++ {
        for j := 1; j <= altura-i; j++ {
            fmt.Print(" ")
        }
        for k := 1; k <= 2*i-1; k++ {
            fmt.Print("#")
        }
        fmt.Println()
    }
}
