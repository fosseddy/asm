%define SYS_EXIT 60
%define SUCCESS 0

section .data
    dRange dd 51
    dSum dd 0

section .text
    global _start

_start:
    mov ecx, dword [dRange]

    .range_sum:
        add dword [dSum], ecx
        loop .range_sum

    mov rax, SYS_EXIT
    mov rdi, SUCCESS
    syscall
