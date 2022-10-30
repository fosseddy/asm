section .data
    SYS_WRITE equ 1
    SYS_OPEN equ 2
    SYS_CLOSE equ 3

    O_CREAT equ 0x40
    O_WRONLY equ 000001q
    S_IRUSR equ 00400q
    S_IWUSR equ 00200q

    NULL equ 0
    LF equ 10

    filename db "_fcw.txt", NULL
    fd dq -1

    content db "hello, world", LF
    content_len equ $-content

section .text
global _start
_start:
    mov rax, SYS_OPEN
    mov rdi, filename
    mov rsi, O_CREAT|O_WRONLY
    mov rdx, S_IRUSR|S_IWUSR
    syscall
    mov [fd], rax

    mov rax, SYS_WRITE
    mov rdi, [fd]
    mov rsi, content
    mov rdx, content_len
    syscall

    mov rax, SYS_CLOSE
    mov rdi, [fd]
    syscall
.exit:
    mov rax, 60
    mov rdi, 0
    syscall
