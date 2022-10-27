section .data
    TRUE equ 1
    FALSE equ 0

    SYS_EXIT equ 60
    EXIT_SUCCESS equ 0

    ARR_LEN equ 10
    arr dd 5, 3, 7, 1, 8, 0, 13, 3, 8, 2
    swapped dd FALSE

section .text
global _start
_start:
    mov rsi, ARR_LEN
    dec rsi
    jmp .loop_1_test
.loop_1:
    mov dword [swapped], FALSE
    mov rdi, 0
    jmp .loop_2_test
.loop_2:
    mov eax, [arr+rdi*4]
    mov ebx, [arr+rdi*4+4]
    cmp eax, ebx
    jle .skip_swap
    mov [arr+rdi*4], ebx
    mov [arr+rdi*4+4], eax
    mov dword [swapped], TRUE
.skip_swap:
    inc rdi
.loop_2_test:
    cmp rdi, rsi
    jl .loop_2
    cmp dword [swapped], FALSE
    je .exit
    dec rsi
.loop_1_test:
    cmp rsi, 0
    jge .loop_1
.exit:
    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall
