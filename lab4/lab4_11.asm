;Given the byte A and the word B, compute the byte C as follows:
;the bits 0-3 are the same as the bits 2-5 of A
;the bits 4-7 are the same as the bits 6-9 of B.
bits 32

global start

extern exit

import exit msvcrt.dll

segment data use32 class=data
     a db 1101_0111b
     b dw 1001_1011_1011_1110b
     c dw 0
    
segment code use32 class=code
start:    
    mov BX, 0 ;result will be in BX
    
    mov AL, [a]
    cbw
    and AX, 0000_0000_0011_1100b ;we isolate bits 2-5 of A
    mov CL, 2
    ror AX, CL ;we rotate right by 2 positions
    or BX, AX ;we put the bits into the result
    
    mov AX, [b]
    and AX, 0000_0011_1100_0000b ;we isolate bits 6-9 of B
    ror AX, CL ;we rotate right by 2 positions
    or BX, AX ;we put the bits into the result
    
    

    push dword 0
    call [exit]