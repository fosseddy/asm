global _start
global get_line
extern exit

section .data
    SYS_READ equ 0
    SYS_OPEN equ 2
    SYS_CLOSE equ 3

    O_RDONLY equ 0

    TRUE equ 1
    FALSE equ 0
    NULL equ 0
    LF equ 10

    BUF_SIZE equ 255
    cur_idx dq BUF_SIZE
    buf_max dq BUF_SIZE
    is_eof dq FALSE

    filename db "_iobuf.test", NULL
    fd dq -1

section .bss
    buf resb BUF_SIZE
    line resb 100

section .text
_start:
    mov rax, SYS_OPEN
    mov rdi, filename
    mov rsi, O_RDONLY
    syscall
    mov [fd], rax

    cmp qword [fd], 0
    jl .error

    mov rdi, [fd]
    mov rsi, line
    call get_line

    cmp rax, FALSE
    je .error

    mov rdi, 0
    jmp .exit
.error:
    mov rdi, 1
.exit:
    call exit

; qword get_line(qword fd, byte *line)
get_line:
    push r12
    mov r12, 0
.loop:
    mov r10, [cur_idx]
    cmp r10, [buf_max]
    jl .skip_read

    push rsi
    mov rax, SYS_READ
    mov rsi, buf
    mov rdx, BUF_SIZE
    syscall
    pop rsi

    cmp rax, 0
    jl .read_error
    cmp rax, BUF_SIZE
    jge .skip_set_eof
    mov qword [is_eof], TRUE

.skip_set_eof:
    mov qword [cur_idx], 0
    mov qword [buf_max], rax

.skip_read:
    mov r10, [cur_idx]
    mov r11b, [buf+r10]
    mov [rsi+r12], r11b

    inc r12
    inc qword [cur_idx]

    cmp r11b, LF
    je .line_found
    jmp .loop

.line_found:
    mov rax, TRUE
    mov byte [rsi+r12-1], NULL
    jmp .exit
.read_error:
    mov rax, FALSE
.exit:
    pop r12
    ret
