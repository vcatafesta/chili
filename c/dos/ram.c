// ram.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
//#include <dos.h>

#define MEM 0x12
#define GET_VIDEO_MODE 0xF
#define SET_VIDEO_MODE 0x0
#define VIDEO_MODE_VGA 0x12

int int86() {
  int inter_no;
  union REGS *input_regs;
  union REGS *output_regs;
}

int main(int argc, char **argv) {
    printf("ram.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n\n");
    struct WORDREGS {
        unsigned int ax;
        unsigned int bx;
        unsigned int cx;
        unsigned int dx;
        unsigned int si;
        unsigned int di;
        unsigned int flags;
    };

    struct BYTEREGS {
        unsigned char al, ah;
        unsigned char bl, bh;
        unsigned char cl, ch;
        unsigned char dl, dh;
    };

    union REGS {
        struct WORDREGS x;
        struct BYTEREGS h;
    };
    union REGS regs;
    unsigned int tam;
    int86(MEM, &regs, &regs);
    tam = regs.x.ax;
    printf("Tamanho da memoria: %d Kb", tam);
    union REGS input_regs, output_regs;
    int prev_mode, prev_txtcol;

    input_regs.h.ah = GET_VIDEO_MODE;
    int86(0x10, &input_regs, &output_regs);
    prev_mode = output_regs.h.al;
    prev_txtcol = output_regs.h.ah;

    input_regs.h.ah = SET_VIDEO_MODE;
    input_regs.h.al = VIDEO_MODE_VGA;
    int86(0x10, &input_regs, &output_regs);
    printf("Current Video mode is 0x12 640x480 16 colors\n");
    printf("Previous Video mode was 0x%X text width %d\n", prev_mode, prev_txtcol);

}

