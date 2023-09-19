global _start

;---------- defines ----------
    %define SYS_READ    3
    %define SYS_WRITE   4
    %define STDIN       0
    %define STDOUT      1
    %define SYS_EXIT    1
    %define BUFFER_MAX  128
;-----------------------------

section .bss
    fname: resb BUFFER_MAX
    lname: resb BUFFER_MAX

section .text
print_space:
    mov rcx, space
    mov rdx, 1
    jmp print_text.perform_print
print_newline:
    mov rcx, newline
    mov rdx, 1
    jmp print_text.perform_print
print_text:
    mov rsi, rcx
    mov rdx, 0x0
    .count:
        lodsb
        cmp al, 0xA
        je .perform_print
        cmp al, 0x0
        jz .perform_print
        inc rdx
        jmp .count
    .perform_print:
        mov rax, SYS_WRITE
        mov rbx, STDOUT
        int 0x80
        ret

read_text:
    mov rax, SYS_READ
    mov rbx, STDIN
    mov rdx, BUFFER_MAX
    int 0x80
    ret

print_greetings:
    mov rcx, greeting_line
    call print_text
    mov rcx, fname
    call print_text
    call print_space
    mov rcx, lname
    call print_text
    call print_newline
    ret

_start:
    mov rcx, fname_prompt
    call print_text
    mov rcx, fname
    call read_text
    mov rcx, lname_prompt
    call print_text
    mov rcx, lname
    call read_text
    call print_greetings
_exit:
    mov rax, SYS_EXIT
    xor rbx, rbx
    int 0x80

section .data
    fname_prompt:   db "First name: ", 0
    lname_prompt:   db "Last name: ", 0
    greeting_line:  db "Hello, ", 0
    space:          db " ", 0
    newline:        db 0xA, 0
