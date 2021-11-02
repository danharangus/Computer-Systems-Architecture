;(c-d-a)+(b+b)-(c+a)
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
    ;(c-d-a)+(b+b)-(c+a)
segment code use32 class=code
start:    
    mov EAX, [c] ;EAX = c
    cdq ;EDX:EAX = c
    
    mov EBX, [d]
    mov ECX, [d + 4] ;ECX:EBX = d
    
    sub EAX, EBX
    sbb EDX, ECX ;EDX:EAX = c - d
    
    mov EBX, EAX
    mov ECX, EDX ;ECX:EBX = c - d
    
    mov AL, [a]
    cbw
    cwde
    cdq ;EDX:EAX = a
    
    sub EBX, EAX
    sbb ECX, EDX ;ECX:EBX = c - d - a
    
    mov AX, [b]
    add AX, [b] ;AX = b + b
    cwde
    cdq ;EDX:EAX = b + b 

    add EBX, EAX
    adc ECX, EDX ;EBX:ECX = (c - d - a) + (b + b)
    
    mov AL, [a]
    cbw
    cwde ;EAX = a
    add EAX, [c] ;EAX = c + a
    cdq ;EDX:EAX = c + a
    
    sub EBX, EAX
    sbb ECX, EDX ;EBX:ECX = (c - d - a) + (b + b) - (c + a)

    push dword 0
    call [exit]