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
    d dq 500

segment code use32 class=code
start:
    mov EAX, 0
    mov EDX, 0
    mov EAX, [d]
    mov EDX, [d + 4] ;EDX:EAX = d
    mov EBX, [c]
    mov ECX, 0 ;ECX:EBX = c
    sub EAX, EBX
    sbb EDX, ECX ;EDX:EAX = d - b
    

    ;mov BX, [b]
    ;mov AH, 0
    ;mov AX, [a]
    ;cbw
    ;sub BX, AX ;BX = b - a
    
    ;mov AX, [b]
    ;add AX, [b]
    ;add AX, [b] ;AX = b + b + b

    
    
    
    push dword 0
    call [exit]