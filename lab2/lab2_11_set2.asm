;(b-c)+(d-a)
bits 32

global start

extern exit

import exit msvcrt.dll

segment data use32 class=data
    a dw 10
    b dw 4
    c dw 5
    d dw 20
    
    
segment code use32 class=code
start:
    mov ax, [b]
    sub ax, [c]
    
    mov bx, [d]
    sub bx, [a]
    
    add ax, bx
    
    push dword 0
    call [exit]