global print
extern strlen

section .text
; void print(byte *s)
print:
    call strlen
    mov r10, rax
    mov r11, rdi

    mov rax, 1
    mov rdi, 1
    mov rsi, r11
    mov rdx, r10
    syscall
    ret
