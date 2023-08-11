.global _start
.extern println, STDOUT
.extern itoa

.data
num: .long 48
buf: .skip 22 # should be enough for "sign, 64bit, NULL"

.text
_start:
    movslq num, %rdi
    movq $buf, %rsi
    call itoa

    movq $STDOUT, %rdi
    call println

exit:
    movq $60, %rax
    movq $0, %rdi
    syscall
