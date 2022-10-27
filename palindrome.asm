section .data
    TRUE equ 1
    FALSE equ 0
    NULL equ 0

    msg db "annas", NULL
    result dd TRUE

section .text
global _start
_start:
    mov rdx, 0
    jmp .loop_1_test
.loop_1:
    mov rax, 0
    mov al, [msg+rdx]
    push rax
    inc rdx
.loop_1_test:
    cmp byte [msg+rdx], NULL
    jne .loop_1

    mov rdx, 0
    jmp .loop_2_test
.loop_2:
    pop rax
    cmp al, [msg+rdx]
    jne .not_equals
    jmp .continue
.not_equals:
    mov dword [result], FALSE
    jmp .exit
.continue:
    inc rdx
.loop_2_test:
    cmp byte [msg+rdx], NULL
    jne .loop_2
.exit:
    mov rax, 60
    mov rdi, 0
    syscall
