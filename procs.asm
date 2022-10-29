section .data
    arr dd 3,2,5,4,1
    len dd 5
    arr1 dd 1,2,3,4,5
    len1 dd 5
    sum1 dd 0
    ave1 dd 0

    arr2 dd 1,2,3,4
    len2 dd 4
    min2 dd 0
    max2 dd 0
    med2_1 dd 0
    med2_2 dd 0
    sum2 dd 0
    ave2 dd 0

    sum3 dd 0

section .text
global _start
_start:
    mov rdi, arr
    mov esi, [len]
    call sort_asc

    call test_locals
    mov [sum3], eax

    mov rdi, arr1
    mov esi, [len1]
    mov rdx, sum1
    mov rcx, ave1
    call stats1

    mov rdi, arr2
    mov esi, [len2]
    mov rdx, min2,
    mov rcx, med2_1
    mov r8, med2_2
    mov r9, max2
    push ave2
    push sum2
    call stats2
    add rbp, 2*8

.exit:
    mov rax, 60
    mov rdi, 0
    syscall

; stats1(arr, len, sum, ave)
global stats1
stats1:
    push r12

    mov r12, 0
    mov rax, 0
.loop:
    add eax, [rdi+r12*4]
    inc r12
    cmp r12, rsi
    jl .loop

    mov [rdx], eax

    cdq
    idiv esi
    mov [rcx], eax

    pop r12
    ret

; stats2(arr, len, min, med1, med2, max, sum, ave);
global stats2
stats2:
    push rbp
    mov rbp, rsp

    ; min
    mov eax, [rdi]
    mov [rdx], eax

    ;max
    mov eax, [rdi+rsi*4-4]
    mov [r9], eax

    ;medians
    mov rax, rsi
    mov rdx, 0
    mov r10, 2
    div r10

    ;med2
    mov r10d, [rdi+rax*4]
    mov [r8], r10d

    cmp rdx, 0
    jne .odd_len

    ;med1
    mov r10d, [rdi+rax*4-4]
    mov [rcx], r10d

.odd_len:
    ;med1
    mov [rcx], r10d
    jmp .medians_done

.medians_done:
    mov r10, 0
    mov rax, 0
.loop:
    add eax, [rdi+r10*4]
    inc r10
    cmp r10, rsi
    jl .loop

    ;sum
    mov r10, [rbp+2*8]
    mov [r10], eax

    cdq
    idiv esi

    ;ave
    mov r10, [rbp+3*8]
    mov [r10], eax

    pop rbp
    ret

global test_locals
test_locals:
    push rbp
    mov rbp, rsp
    ; dword     sum
    ; dword[10] arr
    sub rsp, 44

    ; init arr
    mov rcx, 0
.loop_1:
    mov [rbp-40+rcx*4], ecx
    inc rcx
    cmp rcx, 10
    jl .loop_1

    ; init sum
    mov dword [rbp-44], 0

    ; find sum
    mov rcx, 0
.loop_2:
    mov eax, [rbp-40+rcx*4]
    add [rbp-44], eax
    inc rcx
    cmp rcx, 10
    jl .loop_2

    mov eax, [rbp-44]

    mov rsp, rbp
    pop rbp
    ret

; sort_asc(dword *arr, dword len)
global sort_asc
sort_asc:
    mov rcx, 0
.loop_1:
    mov r8d, [rdi+rcx*4]
    mov r9, rcx

    mov rdx, rcx
.loop_2:
    cmp [rdi+rdx*4], r8d
    jge .skip_change
    mov r8d, [rdi+rdx*4]
    mov r9, rdx
.skip_change:
    inc rdx
    cmp rdx, rsi
    jl .loop_2

    lea rax, [rdi+r9*4]
    mov r10d, [rdi+rcx*4]
    mov [rax], r10d
    lea rax, [rdi+rcx*4]
    mov [rax], r8d

    inc rcx
    cmp rcx, rsi
    jl .loop_1

    ret
