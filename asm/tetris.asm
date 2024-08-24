section .data
    hello db 'Hello, World!', 0x0A  ; Mensagem a ser exibida, terminada com nova linha (0x0A)

section .bss

section .text
    global _start  ; Ponto de entrada para o linker

_start:
    ; Escrever a mensagem para a saída padrão
    mov rax, 1        ; Código da chamada de sistema para sys_write (1)
    mov rdi, 1        ; Descritor de arquivo 1 é a saída padrão (stdout)
    mov rsi, hello    ; Ponteiro para a mensagem
    mov rdx, 14       ; Tamanho da mensagem (13 caracteres + 1 para nova linha)
    syscall           ; Chama o kernel

    ; Terminar o programa
    mov rax, 60       ; Código da chamada de sistema para sys_exit (60)
    xor rdi, rdi      ; Código de saída 0
    syscall           ; Chama o kernel

