%define SYS_WRITE 1
%define SYS_EXIT 60
%define STDOUT 1
%define SUCCESS 0

section .data
    msg db "Hello, World!", 10
    MSG_LEN equ $-msg

section .text
    global _start

_start:
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, msg
    mov rdx, MSG_LEN
    syscall

    mov rax, SYS_EXIT
    mov rdi, SUCCESS
    syscall
