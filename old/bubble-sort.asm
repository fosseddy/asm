%define SYS_EXIT 60
%define EXIT_SUCCESS 0

section .data
dArr dd 5, 2, 1, 3, 4
dLen dd 5

section .text
global _start
_start:
    sub dword [dLen], 1
    mov esi, 0 ; i = 0
    .first_loop:
        cmp dword [dLen], esi ; if i == dLen
        je .first_loop_end    ; break loop

        mov edi, 0 ; j = 0
        .second_loop:
            mov eax, dword [dLen]
            sub eax, esi        ; second loop length = dLen - i
            cmp eax, edi        ; if j == dLen - i
            je .second_loop_end ; break second loop

            mov eax, dword [dArr+edi*4]     ; dArr[j]
            mov ebx, dword [dArr+(edi*4)+4] ; dArr[j + 1]

            cmp eax, ebx     ; if dArr[j] <= dArr[j+1]
            jle .do_not_swap ; skip swap

            mov ecx, eax ; tmp = dArr[j]
            mov eax, ebx ; eax = dArr[j+1]
            mov ebx, ecx ; ebx = tmp

            ; swap dArr values
            mov dword [dArr+edi*4], eax
            mov dword [dArr+(edi*4)+4], ebx

            .do_not_swap:

            inc edi ; j++
            jmp .second_loop

        .second_loop_end:
            inc esi ; i++
            jmp .first_loop

    .first_loop_end:

    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall
