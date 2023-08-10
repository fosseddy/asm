section .data
    ARR_LEN equ 5
    arr dd 1,2,3,4,5

section .text
global _start
_start:
    mov rcx, ARR_LEN
    mov rdx, 0
.loop_1:
    movsxd rax, [arr+rdx*4]
    push rax
    inc rdx
    loop .loop_1

    mov rcx, ARR_LEN
    mov rdx, 0
.loop_2:
    pop rax
    mov [arr+rdx*4], eax
    inc rdx
    loop .loop_2
.exit:
    mov rax, 60
    mov rdi, 0
    syscall
