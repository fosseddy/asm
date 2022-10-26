section .data
  arr dd 50, 10, 15, 43, 11, 4, 7, 25, 114, 8
  len dd 10
  sum dd 0

section .text
global _start
_start:
  mov rbx, 0
  mov ecx, [len]
calc_sum:
  mov eax, [arr+rbx*4]
  add [sum], eax
  inc rbx
  loop calc_sum
exit:
  mov rax, 60
  mov rdi, 0
  syscall
