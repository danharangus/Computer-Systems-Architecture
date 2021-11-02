;11. (a + c - d) + d - (b + b - c)

bits 32

global start

extern exit

import exit msvcrt.dll

segment data use32 class=data
    a db 10
    b db 4
    c db 5
    d db 20
    
    
segment code use32 class=code
start:
    mov al, [a]
    add al, [c]
    sub al, [d]
    add al, [d]
    
    mov ah, [b]
    add ah, [b]
    sub ah, [c]
    
    sub al, ah
    
    
    push dword 0
    call [exit]