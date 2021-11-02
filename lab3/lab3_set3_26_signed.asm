;(a*a+b/c-1)/(b+c)+d-x; a-word; b-byte; c-word; d-doubleword; x-qword
bits 32

global start

extern exit

import exit msvcrt.dll

segment data use32 class=data
    a dw -100
    b db 20
    c dw -5
    d dd 50
    x dq 200
    ;(-100 * (-100) + 20 / (-5) - 1) / (20 - 5) + 50 - 200 = 516
segment code use32 class=code
start:    
    mov AX, [a]
    imul word [a] ;DX:AX = a * a
    push DX
    push AX
    pop EAX
    mov EBX, EAX ;EBX = a * a
    
    mov AL, [b]
    cbw
    cwd
    idiv word [c] ;AX = b / c
    cwde ;EAX = b / c
    
    add EBX, EAX ;EBX = a * a + b / c
    sub EBX, 1 ;EBX = a * a + b / c - 1
    
    mov AL, [b]
    cbw ;AX = b
    add AX, [c] ;AX = b + c
    mov CX, AX ;CX = b + c
    
    push EBX
    pop AX
    pop DX
    
    idiv word CX ;AX = (a * a + b / c - 1) / (b + c)
    cwde ;EAX = (a * a + b / c - 1) / (b + c)
    
    add EAX, [d] ;EAX = (a * a + b / c - 1) / (b + c) + d
    cdq ;EDX:EAX = (a * a + b / c - 1) / (b + c) + d
    
    mov EBX, [x]
    mov ECX, [x + 2] ;ECX:EBX = x 
    
    sub EAX, EBX
    sbb ECX, EDX ;EDX:EAX = (a * a + b / c - 1) / (b + c) + d - x

    push dword 0
    call [exit]