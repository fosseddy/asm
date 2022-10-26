section .data
  SYS_EXIT equ 60
  EXIT_SUCCESS equ 0

  N equ 10

  sum dq 0

section .text
global _start
_start:
  mov rcx, 1

calc_sum:
  cmp rcx, N
  jg end_calc_sum

  mov rax, rcx
  imul rax, rcx
  add [sum], rax

  inc rcx
  jmp calc_sum
end_calc_sum:

  mov rax, SYS_EXIT
  mov rdi, EXIT_SUCCESS
  syscall
