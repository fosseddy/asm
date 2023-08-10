global _start

section .bss
    arr resq 1

section .data
    SYS_EXIT equ 60
    SYS_BRK equ 12

    EXIT_SUCCESS equ 0

section .text
_start:
    mov rax, SYS_BRK
    mov rdi, 0
    syscall

    mov [arr], rax

    lea rdi, [rax+5*4]
    mov rax, SYS_BRK
    syscall

    mov rcx, 5
    mov rbx, 0
    mov rax, [arr]
.set_values:
    mov [rax+rbx*4], rcx
    inc rbx
    loop .set_values

.exit:
    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall
