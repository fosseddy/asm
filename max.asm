%define SYS_EXIT 60
%define EXIT_SUCCESS 0

section .data
    dVar1 dd 6
    dVar2 dd 10
    dMax dd 0

section .text
    global _start

_start:
    mov eax, dword [dVar1]
    mov dword [dMax], eax

    cmp eax, dword [dVar2]
    jge .do_not_change_value

    mov eax, dword [dVar2]
    mov dword [dMax], eax

    .do_not_change_value:

    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall
