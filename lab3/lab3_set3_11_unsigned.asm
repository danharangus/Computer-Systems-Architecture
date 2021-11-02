;(a+b)/(2-b*b+b/c)-x; a-doubleword; b,c-byte; x-qword UNSIGNED
bits 32

global start

extern exit

import exit msvcrt.dll

segment data use32 class=data
    a dd 400
    b db 0
    c db 5
    x dq 150
    ;(400 + 0) / (2 - 0*0 + 0/5) - 150 = 50 
segment code use32 class=code
start:    
    mov BX, [a]
    mov CX, [a + 2] ;CX:BX = a
    
    mov AL, [b]
    mov AH, 0
    mov DX, 0 ;DX:AX = b
    add BX, AX
    adc CX, DX ;CX:BX = a + b
    
    mov AL, [b]
    mul byte [b] ;AX = b * b
    mov DX, 2
    sub DX, AX ;DX = 2 - b * b
    
    mov AL, [b]
    mov AH, 0
    div byte [c] ;AL = b / c
    mov AH, 0
    add DX, AX ;DX = 2 - b * b + b / c
    
    mov AX, BX
    mov BX, DX
    mov DX, CX ;DX:AX = (a + b), BX = 2 - b * b + b / c
    div word BX ;AX = (a + b) / 2 - b * b + b / c
    mov DX, 0
    push DX
    push AX
    pop EAX ;EAX = (a + b) / 2 - b * b + b / c
    mov EDX, 0 ;EDX:EAX = (a + b) / 2 - b * b + b / c
    
    mov EBX, [x]
    mov ECX, [x + 4]
    
    sub EAX, EBX
    sbb EDX, ECX ;EDX:EAX = 2 - b * b + b / c - x
    

    push dword 0
    call [exit]