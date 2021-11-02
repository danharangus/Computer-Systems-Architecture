;(a+b)/(2-b*b+b/c)-x; a-doubleword; b,c-byte; x-qword UNSIGNED
bits 32

global start

extern exit

import exit msvcrt.dll

segment data use32 class=data
    a dd 900
    b db -20
    c db 5
    x dq 200
    
segment code use32 class=code
start:    
    mov BX, [a]
    mov CX, [a + 2] ;CX:BX = a
    
    mov AL, [b]
    cbw
    cwd ;DX:AX = b
    add BX, AX
    adc CX, DX ;CX:BX = a + b
    
    mov AL, [b]
    imul byte [b] ;AX = b * b
    mov DX, 2
    sub DX, AX ;DX = 2 - b * b
    
    mov AL, [b]
    cbw
    idiv byte [c] ;AL = b / c
    cbw
    add DX, AX ;DX = 2 - b * b + b / c
    
    mov AX, BX
    mov BX, DX
    mov DX, CX ;DX:AX = (a + b), BX = 2 - b * b + b / c
    idiv word BX ;AX = (a + b) / 2 - b * b + b / c
    cwde
    cdq ;EDX:EAX = (a + b) / 2 - b * b + b / c
    
    mov EBX, [x]
    mov ECX, [x + 4]
    
    sub EAX, EBX
    sbb EDX, ECX ;EDX:EAX = 2 - b * b + b / c - x
    

    push dword 0
    call [exit]