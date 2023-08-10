section .data
    TRUE equ 1
    FALSE equ 0
    NULL equ 0

    s db "-123", NULL
    pow dd 0

    has_sign dd FALSE
    is_neg dd FALSE

section .bss
    num resd 1

section .text
global _start
_start:
    mov ecx, 0
    cmp byte [s+ecx], "+"
    jne .skip_plus
    mov dword [has_sign], TRUE
    inc ecx
    jmp .strlen_test
.skip_plus:
    cmp byte [s+ecx], "-"
    jne .strlen_test
    mov dword [has_sign], TRUE
    mov dword [is_neg], TRUE
    inc ecx
    jmp .strlen_test
.strlen:
    inc ecx
    inc dword [pow]
.strlen_test:
    cmp byte [s+ecx], NULL
    jne .strlen

    dec dword [pow]

    mov ecx, [has_sign]
    mov edx, 0
    jmp .atoi_test
.atoi:
    mov eax, 0
    mov al, [s+ecx]
    sub al, "0"

    mov ebx, [pow]
    sub ebx, ecx
    add ebx, [has_sign]
    jmp .pow_test
.pow:
    imul eax, eax, 10
    dec ebx
.pow_test:
    cmp ebx, 0
    jg .pow

    add edx, eax
    inc ecx
.atoi_test:
    cmp byte [s+ecx], NULL
    jne .atoi

    cmp dword [is_neg], TRUE
    jne .not_negative

    neg edx
.not_negative:
    mov [num], edx
.exit:
    mov rax, 60
    mov rdi, 0
    syscall
