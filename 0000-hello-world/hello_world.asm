global _start

;---------- defines ----------
    %define SYS_WRITE   4
    %define STDOUT      1
    %define SYS_EXIT    1
;-----------------------------

section .text
_start:
    mov rax, SYS_WRITE
    mov rbx, STDOUT
    mov rcx, helloworld
    mov rdx, helloworld_len
    int 0x80
_exit:
    mov rax, SYS_EXIT
    xor rbx, rbx
    int 0x80

section .data
    helloworld:         db "Hello, world!", 0xA, 0x0
    helloworld_len:     equ $-helloworld
