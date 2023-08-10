.global _start

.data
avrg: .long 0
sum: .long 0
max: .long 0
min: .long 0
arr: .long 25, 69, 41, -1, 420, 8, 69
len: .long 7

.text
_start:
    movl arr, %r8d
    movl arr, %r9d

    movq $0, %rsi
    movl len, %ecx
.sum_loop:
    movl arr(, %rsi, 4), %eax

    addl %eax, sum

    cmpl %eax, %r8d
    cmovl %eax, %r8d

    cmpl %eax, %r9d
    cmovg %eax, %r9d

    incq %rsi
    loop .sum_loop

    movl %r8d, max
    movl %r9d, min

    movl sum, %eax
    cltd
    idivl len
    movl %eax, avrg

    movq $60, %rax
    movq $0, %rdi
    syscall
