package main

import (
    "fmt"
    "unicode/utf8"
)

func zeroval(ival int) {
    ival = 0
}

func zeroptr(iptr *int) {
    *iptr = 0
}

func main() {
    i := 1
    const s = "สวัสดี"
    fmt.Println("Len:", len(s))
    fmt.Println("Rune count:", utf8.RuneCountInString(s))

	for i := 0; i < len(s); i++ {
        fmt.Printf("%x ", s[i])
    }
    fmt.Println()

    fmt.Println("initial:", i)
    zeroval(i)
    fmt.Println("zeroval:", i)
    zeroptr(&i)
    fmt.Println("zeroptr:", i)
    fmt.Println("pointer:", &i)
}
