;a - byte, b - word, c - double word, d - qword - Unsigned representation
;(d-c)+(b-a)-(b+b+b)
bits 32

global start

extern exit

import exit msvcrt.dll

segment data use32 class=data
    a db 10
    b dw 50
    c dd 400
    d dq 600

segment code use32 class=code
start:
    mov EAX, 0
    mov EDX, 0
    mov EAX, [d]
    mov EDX, [d + 4] ;EDX:EAX = d
    mov EBX, [c]
    mov ECX, 0 ;ECX:EBX = c
    sub EAX, EBX
    sbb EDX, ECX ;EDX:EAX = d - c
    mov ECX, EDX
    mov EBX, EAX ;ECX:EBX = d - c
    

    mov DX, [b]
    mov AH, 0
    mov AX, [a]
    cbw
    sub DX, AX ;DX = b - a
   
    
    mov EAX, 0
    mov AX, DX
    mov EDX, 0
    cwde
    cdq ;EDX:EAX = b - a
    
    
    add EAX, EBX
    adc EDX, ECX ;EDX:EAX = (d - c) + (b - a)    
    
    
    mov ECX, EDX
    mov EBX, EAX ;ECX:EBX = (d - c) + (b - a)
    
    
    mov EAX, 0
    mov EDX, 0
    mov AX, [b]
    add AX, [b]
    add AX, [b]
    cwde
    cdq ; EDX:EAX = b + b + b
    
    
    sub EBX, EAX
    sbb ECX, EDX ;ECX:EDX = (d - c) + (b - a) - (b + b + b)
    
    
    push dword 0
    call [exit]