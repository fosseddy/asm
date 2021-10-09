%define SYS_EXIT 60
%define EXIT_SUCCESS 0

section .data
    dArr dd 13, 100, 25, 11, 6, 33, 9, 5, 1, 0, 0, 222
    dArr_len dd 12
    dSum dd 0

section .text
    global _start

; for (int i = 0; i < ARR_LEN; ++i) sum += arr[i]
_start:
    mov esi, 0
    .arr_loop:
        mov eax, dword [dArr+esi*4]
        add dword [dSum], eax
        inc esi
        cmp dword [dArr_len], esi
        jg .arr_loop

    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall
