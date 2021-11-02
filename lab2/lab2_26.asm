;(a+a)-(b+b)-c

bits 32

global start

extern exit

import exit msvcrt.dll

segment data use32 class=data
    a db 10
    b db 4
    c db 5
    
    
segment code use32 class=code
start:
    mov al, [a]
    add al, [a]
    
    mov ah, [b]
    add ah, [b]
    
    sub al, ah
    
    sub al, [c]
    
    push dword 0
    call [exit]