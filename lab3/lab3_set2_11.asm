;d-(a+b+c)-(a+a)
;a - byte, b - word, c - double word, d - qword - Signed representation
bits 32

global start

extern exit

import exit msvcrt.dll

segment data use32 class=data
    a db -10
    b dw -150
    c dd 400
    d dq 200

segment code use32 class=code
start:    
    mov AL, [a]
    cbw
    cwde
    mov EDX, EAX ;EDX = a
    mov AX, [b]
    cwde ;EAX = b
    add EDX, EAX ;EDX = a + b
    add EDX, [c] ;EDX = a + b + c
    
    mov EAX, EDX ;EAX = a + b + c
    cdq ;EDX:EAX = (a + b + c)
    
    mov EBX, [d]
    mov ECX, [d + 4] ;ECX:EBX = d
    
    sub EBX, EAX
    sbb ECX, EDX ;ECX:EBX = d - (a + b + c)
    
    mov AL, [a]
    add AL, [a] ;AL = (a + a)
    cbw
    cwde ;EAX = a
    cdq ;EDX:EAX = (a + a)
    
    sub EBX, EAX
    sbb ECX, EDX ;ECX:EBX = d - (a + b + c) - (a + a)
    
    
    push dword 0
    call [exit]