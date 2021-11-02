;(e+g-2*b)/c
bits 32

global start

extern exit

import exit msvcrt.dll

segment data use32 class=data
    a db 5
    b db 6
    c db 2
    d db 3
    e dw 300
    f dw 500
    g dw 150
    h dw 400
    i db 2

segment code use32 class=code
start:
    mov AL, [b]
    mul byte [i] ;AX = 2 * b
    
    mov BX, [e]
    add BX, [g]
    sub BX, AX  ;BX = (e + g - 2 * b)
    
    mov AX, BX ;AX = (e + g - 2 * b)
    div byte [c]
    mov AH, 0
    
    
    push dword 0
    call [exit]