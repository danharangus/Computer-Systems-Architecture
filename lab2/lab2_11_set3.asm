;[(d/2)*(c+b)-a*a]/b
bits 32

global start

extern exit

import exit msvcrt.dll

segment data use32 class=data
    a db 5
    b db 4
    c db 5
    d dw 100
    f db 2
    
    
segment code use32 class=code
start:
    mov AX, [d]
    div byte [f]   ; AL = d/2
    
    mov AH, [c]
    add AH, [b]  ; AH = c + b
    
    mul AH  ; AX = (d/2) * (c+b)
    
    mov BX, AX ; BX = (d/2) * (c+b)
    mov AL, [a]
    mul byte [a] ; AX = a * a
    
    sub BX, AX  ;BX = (d/2) * (c+b) - a * a
     
    mov AX, BX
    div byte [b]
    

    
    push dword 0
    call [exit]