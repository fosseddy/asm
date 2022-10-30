section .text
    global strlen
; qword strlen(byte *s)
strlen:
    mov rax, 0
.loop:
    inc rax
    cmp byte [rdi+rax], 0
    jne .loop

    ret
