%define EXIT 60
%define EXIT_SUCCESS 0

%define NULL 0
%define BUFF_LEN 12

%define DIGIT_ZERO_CHAR 0x30
%define MINUS_CHAR 0x2d

section .data
    dNum dd 430012301

section .bss
    bBuff resb BUFF_LEN

section .text
global _start
_start:
    mov eax, dword [dNum]
    cdq
    mov ebx, 10
    mov rcx, 0

    cmp eax, 0
    jg .split_num
    neg eax

    .split_num:
        mov edx, 0
        idiv ebx

        push rdx
        inc rcx

        cmp eax, 0
        jne .split_num

    mov rbx, 0
    mov eax, dword [dNum]

    cmp eax, 0
    jg .fill_buff
    mov byte [bBuff+rbx], MINUS_CHAR
    inc rbx

    .fill_buff:
        pop rax
        add al, DIGIT_ZERO_CHAR
        mov byte [bBuff+rbx], al

        inc rbx
        loop .fill_buff

    mov byte [bBuff+rbx], NULL

    mov rax, 1
    mov rdi, 1
    mov rsi, bBuff
    mov rdx, BUFF_LEN
    syscall

    mov rax, EXIT
    mov rdi, EXIT_SUCCESS
    syscall
