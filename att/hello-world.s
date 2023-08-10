.global _start

.data
msg: .ascii "hello, world\n"
.equ MSG_LEN, 13

.text
_start:
    movq $1, %rax
    movq $1, %rdi
    movq $msg, %rsi
    movq $MSG_LEN, %rdx
    syscall

    movq $60, %rax
    movq $0, %rdi
    syscall
