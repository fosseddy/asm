section .data
  SYS_EXIT equ 60
  EXIT_SUCCESS equ 0
  LEN equ 5

  arr dd 3, 2, 5, 4, 1
  sum dd 0
  max dd 0
  min dd 0
  average dd 0

section .text
global _start
_start:
  mov eax, [arr]
  mov [max], eax
  mov [min], eax

  mov rbx, 0
  jmp loop_test
loop:
  mov eax, [arr+rbx*4]
  cmp [max], eax
  jge skip_new_max
  mov [max], eax
skip_new_max:
  cmp [min], eax
  jle skip_new_min
  mov [min], eax
skip_new_min:
  add [sum], eax
  inc rbx
loop_test:
  cmp rbx, LEN
  jl loop

  mov eax, [sum]
  mov ebx, LEN
  idiv ebx
  mov [average], eax
exit:
  mov rax, SYS_EXIT
  mov rdi, EXIT_SUCCESS
  syscall
