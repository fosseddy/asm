section .data
  SYS_EXIT equ 60
  EXIT_SUCCESS equ 0

  ARR_DATA_SIZE equ 4
  ARR_LEN equ 5
  arr dd 3, -1, 5, 6, -8

  sum dd 0
  min dd 0
  max dd 0
  middle dd 0
  average dd 0

  neg_sum dd 0
  neg_count dd 0
  neg_average dd 0

  div3_sum dd 0
  div3_count dd 0
  div3_average dd 0

section .text
global _start
_start:
  mov eax, [arr]
  mov [min], eax
  mov [max], eax

  mov rsi, 0
  jmp .loop_test
  .loop_body:
    mov edi, [arr+rsi*ARR_DATA_SIZE]
    cmp [max], edi
    jge .skip_new_max
    mov [max], edi

    .skip_new_max:
    cmp [min], edi
    jle .skip_new_min
    mov [min], edi

    .skip_new_min:
    cmp edi, 0
    jge .skip_non_negative
    add [neg_sum], edi
    inc dword [neg_count]

    .skip_non_negative:
    mov eax, edi
    mov edx, 0
    cdq
    mov ebx, 3
    idiv ebx
    cmp edx, 0
    jne .skip_non_div3
    add [div3_sum], edi
    inc dword [div3_count]

    .skip_non_div3:
    add [sum], edi
    inc rsi
  .loop_test:
    cmp rsi, ARR_LEN
    jl .loop_body

  mov eax, [sum]
  cdq
  mov ebx, ARR_LEN
  idiv ebx
  mov [average], eax

  mov eax, [neg_sum]
  cdq
  idiv dword [neg_count]
  mov [neg_average], eax

  mov eax, [div3_sum]
  cdq
  idiv dword [div3_count]
  mov [div3_average], eax

  mov eax, ARR_LEN
  mov edx, 0
  cdq
  mov ebx, 2
  idiv ebx
  dec eax
  cmp edx, 0
  jne .middle_odd

  mov ebx, [arr+eax*ARR_DATA_SIZE]
  mov ecx, [arr+eax*ARR_DATA_SIZE+ARR_DATA_SIZE]

  mov eax, ebx
  add eax, ecx

  cdq
  mov ebx, 2
  idiv ebx
  mov [middle], eax
  jmp .exit

  .middle_odd:
    mov ebx, [arr+eax*ARR_DATA_SIZE+ARR_DATA_SIZE]
    mov [middle], ebx

  .exit:
    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall
