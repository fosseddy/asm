%define SYS_WRITE 1
%define STDOUT 1
%define SYS_EXIT 60
%define EXIT_SUCCESS 0

section .data
    NEW_LINE db 10, 0

section .text
global strlen
strlen:
    mov rax, 0
    .loop:
        cmp byte [rdi+rax], 0
        je .loop_end
        inc rax
        jmp .loop
    .loop_end:
    ret

global print
print:
    push rdi
    push rdx
    push r8
    push rcx

    call strlen

    mov r8, rdi
    mov rdx, rax

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, r8
    syscall

    pop rcx
    pop r8
    pop rdx
    pop rdi
    ret

global println
println:
    push rdi

    call print
    mov rdi, NEW_LINE
    call print

    pop rdi
    ret

global _start
_start:
    pop rcx
    .loop:
        pop rdi
        call println
        loop .loop

    mov rax, SYS_EXIT
    mov rdi, 0
    syscall
