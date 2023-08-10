section .data
    SYS_READ equ 0
    SYS_WRITE equ 1
    SYS_OPEN equ 2
    SYS_CLOSE equ 3

    O_RDONLY equ 000000q
    STDOUT equ 1
    NULL equ 0

    BUF_LEN equ 255

    filename db "_fcw.txt", NULL
    fd dq -1

section .bss
    buf resb BUF_LEN

section .text
global _start
_start:
    mov rax, SYS_OPEN
    mov rdi, filename
    mov rsi, O_RDONLY
    syscall
    mov [fd], rax

    mov rax, SYS_READ
    mov rdi, [fd]
    mov rsi, buf
    mov rdx, BUF_LEN
    syscall
    mov r12, rax

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, buf
    mov rdx, r12
    syscall

    mov rax, SYS_CLOSE
    mov rdi, [fd]
    syscall
.exit:
    mov rax, 60
    mov rdi, 0
    syscall
