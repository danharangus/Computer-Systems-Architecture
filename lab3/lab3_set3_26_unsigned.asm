;(a*a+b/c-1)/(b+c)+d-x; a-word; b-byte; c-word; d-doubleword; x-qword
bits 32

global start

extern exit

import exit msvcrt.dll

segment data use32 class=data
    a dw 100
    b db 20
    c dw 5
    d dd 50
    x dq 200
    
segment code use32 class=code
start:    
    mov AX, [a]
    mul word [a] ;DX:AX = a * a
    push DX
    push AX
    pop EAX
    mov EBX, EAX ;EBX = a * a
    
    mov AL, [b]
    mov AH, 0
    mov DX, 0
    div word [c] ;AX = b / c
    mov DX, 0
    push DX
    push AX
    pop EAX ;EAX = b / c
    
    add EBX, EAX ;EBX = a * a + b / c
    sub EBX, 1 ;EBX = a * a + b / c - 1
    
    mov AL, [b]
    mov AH, 0 ;AX = b
    add AX, [c] ;AX = b + c
    mov CX, AX ;CX = b + c
    
    push EBX
    pop AX
    pop DX
    
    div word CX ;AX = (a * a + b / c - 1) / (b + c)
    mov DX, 0
    push DX
    push AX
    pop EAX ;EAX = (a * a + b / c - 1) / (b + c)
    
    add EAX, [d] ;EAX = (a * a + b / c - 1) / (b + c) + d
    mov EDX, 0 ;EDX:EAX = (a * a + b / c - 1) / (b + c) + d
    
    mov EBX, [x]
    mov ECX, [x + 2] ;ECX:EBX = x 
    
    sub EAX, EBX
    sbb ECX, EDX ;EDX:EAX = (a * a + b / c - 1) / (b + c) + d - x

    push dword 0
    call [exit]