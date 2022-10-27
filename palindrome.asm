section .data
    TRUE equ 1
    FALSE equ 0
    NULL equ 0

    msg db "a man, a plan, a canal – panama!", NULL
    result dd TRUE

section .text
global _start
_start:
    mov rdx, 0
    jmp .loop_1_test
.loop_1:
    cmp byte [msg+rdx], "a"
    jl .loop_1_continue
    cmp byte [msg+rdx], "z"
    jg .loop_1_continue
    mov rax, 0
    mov al, [msg+rdx]
    push rax
.loop_1_continue:
    inc rdx
.loop_1_test:
    cmp byte [msg+rdx], NULL
    jne .loop_1

    mov rdx, 0
    jmp .loop_2_test
.loop_2:
    cmp byte [msg+rdx], "a"
    jl .loop_2_continue
    cmp byte [msg+rdx], "z"
    jg .loop_2_continue
    pop rax
    cmp al, [msg+rdx]
    jne .not_equals
    jmp .loop_2_continue
.not_equals:
    mov dword [result], FALSE
    jmp .exit
.loop_2_continue:
    inc rdx
.loop_2_test:
    cmp byte [msg+rdx], NULL
    jne .loop_2
.exit:
    mov rax, 60
    mov rdi, 0
    syscall
