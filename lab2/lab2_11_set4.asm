;(e+f)*(2*a+3*b)
bits 32

global start

extern exit

import exit msvcrt.dll

segment data use32 class=data
    a db 5
    b db 6
    c db 5
    d db 3
    e dw 300
    f dw 500
    g dw 10
    h dw 400
    i db 2
    j db 3
    
segment code use32 class=code
start:
    mov BX, [e]
    add BX, [f] ;BX = e + f
    
    mov AL, [a]
    mul byte [i]; AX = a * 2
    mov CX, AX ; CX = a * 2
    mov AL, [b]
    mul byte [j] ;AX = 3 * b
    add AX, CX ;AX = 2 * a + 3 * b
    
    mul word BX
    
    push DX
    push AX
    pop EAX
    
    
    push dword 0
    call [exit]