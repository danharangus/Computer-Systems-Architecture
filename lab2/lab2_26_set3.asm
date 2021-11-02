;d+[(a+b)*5-(c+c)*5]
bits 32

global start

extern exit

import exit msvcrt.dll

segment data use32 class=data
    a db 5
    b db 6
    c db 5
    d dw 300
    f db 5

segment code use32 class=code
start:
    mov AL, [a]
    add AL, [b] ;AL = a + b
    mul byte [f] ;AL = (a + b) * 5
    
    mov BL, AL ; BL = (a + b) * 5
    
    mov AL, [c]
    add AL, [c]
    mul byte [f] ;AL = (c + c) * 5
    
    sub BL, AL
    mov AL, BL ;AL = (a + b) * 5 - (c + c) * 5
    
    mov BX, [d] ;BX = d
    add AX, BX ;AX = d + [(a + b) * 5 - (c + c) * 5]
    
    
    push dword 0
    call [exit]