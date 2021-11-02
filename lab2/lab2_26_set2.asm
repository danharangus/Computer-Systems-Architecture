;(a+c)-(b+b+d)
bits 32

global start

extern exit

import exit msvcrt.dll

segment data use32 class=data
    a dw 20
    b dw 4
    c dw 10
    d dw 5
    
segment code use32 class=code
start:
    mov ax, [a]
    add ax, [c]
    
    mov bx, [b]
    add bx, [b]
    add bx, [d]
    
    sub ax, bx

    
    push dword 0
    call [exit]