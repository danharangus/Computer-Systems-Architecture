;(c-b+a)-(d+a)
;a - byte, b - word, c - double word, d - qword - Unsigned representation
bits 32

global start

extern exit

import exit msvcrt.dll

segment data use32 class=data
    a db 10
    b dw 50
    c dd 600
    d dq 200

segment code use32 class=code
start:
    mov AL, [a]
    cbw
    cwde
    cdq ;EDX:EAX = a
    mov EBX, [d]
    mov ECX, [d + 4] ;ECX:EBX = b
    add EAX, EBX
    adc EDX, ECX ;EAX:EDX = (d + a)
    
    mov EBX, EAX
    mov ECX, EDX ;ECX:EBX = (d + a)
    
    mov EDX, 0
    mov EDX, [c] ;EDX = c
    mov AX, [b]
    cwde ;EAX = b
    sub EDX, EAX ;EDX = c - b
    
    mov AL, [a]
    cbw
    cwde ;EAX = a
    add EDX, EAX ;EDX = c - b + a
    mov EAX, EDX ;EAX = c - b + a
    cdq ;EDX:EAX = c - b +  a
    
    sub EAX, EBX
    sbb EDX, ECX ;EDX:EAX = (c - b + a) - (d + a)
    
    
    
    push dword 0
    call [exit]