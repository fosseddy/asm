section .data
    SYS_EXIT equ 60
    SYS_READ equ 0
    SYS_WRITE equ 1

    STDIN equ 0
    STDOUT equ 1

    NULL equ 0
    LF equ 10
    EXIT_SUCCESS equ 0

    BUF_SIZE equ 10

section .bss
    c resb 1
    buf resb BUF_SIZE

section .text
global _start
_start:
    mov r12, 0
.loop:
    mov rax, SYS_READ
    mov rdi, STDIN
    mov rsi, c
    mov rdx, 1
    syscall

    cmp byte [c], LF
    je .loop_done

    cmp r12, BUF_SIZE-1
    jge .loop

    mov r10b, [c]
    mov [buf+r12], r10b
    inc r12
    jmp .loop
.loop_done:
    mov byte [buf+r12], LF

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, buf
    mov rdx, BUF_SIZE
    syscall
.exit:
    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall
