%define SYS_EXIT 60
%define EXIT_SUCCESS 0

section .data
qArr dq 1, 2, 3, 4, 5
qLen dq 5

section .text
global _start
_start:
    mov rcx, qword [qLen]
    mov r12, 0
    .push_arr_to_stack:
        push qword [qArr+r12*8]
        inc r12
        loop .push_arr_to_stack

    mov rcx, qword [qLen]
    mov r12, 0
    .reverse_arr:
        pop qword [qArr+r12*8]
        inc r12
        loop .reverse_arr

    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall
