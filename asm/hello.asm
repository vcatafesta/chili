; nasm -f elf hello.asm
; ld -m elf_i386 -s -o hello hello.o

SECTION .data
mensagem  db  'Olá, Mundo!', 0xa, 0x0d

SECTION .text

global _start:
_start:
   mov edx, 13         ; Tamanho da mensagem
   mov ecx, mensagem   ; Mensagem a apresentar
   mov ebx, 1          ; File descriptor (STDOUT)
   mov eax, 4          ; syscall 4 (sys_write)
   int 0x80            ; Chama o kernel

   mov eax, 1          ; Syscall 1 (sys_exit)
   int 0x80            ; Chama o kernel
