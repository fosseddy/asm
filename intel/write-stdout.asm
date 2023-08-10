section .data
    SYS_EXIT equ 60
    SYS_WRITE equ 1

    EXIT_SUCCESS equ 0
    STDOUT equ 1
    LF equ 10

    text db "hello, world", LF
    len equ $-text

section .text
global _start
_start:
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, text
    mov edx, len
    syscall
.exit:
    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall
