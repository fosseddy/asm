section .data
    TRUE equ 1
    FALSE equ 0
    NULL equ 0

    num dd 461
    len dd 0
    is_neg dd FALSE

section .bss
    buf resb 12

section .text
global _start
_start:
    cmp dword [num], 0
    jge .split_num

    mov dword [is_neg], TRUE
    mov byte [buf], "-"
    inc dword [len]
    neg dword [num]
.split_num:
    mov eax, [num]
    cdq

    mov ebx, 10
    idiv ebx

    push rdx
    inc dword [len]
    mov [num], eax

    cmp eax, 0
    jne .split_num

    mov ecx, [is_neg]
    jmp .fill_buf_test
.fill_buf:
    pop rax
    add al, "0"
    mov [buf+ecx], al
    inc ecx
.fill_buf_test:
    cmp ecx, [len]
    jl .fill_buf

    mov byte [buf+ecx], NULL
.exit:
    mov rax, 60
    mov rdi, 0
    syscall
