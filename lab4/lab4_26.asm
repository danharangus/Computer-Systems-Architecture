;Given 2 dublucuvinte R and T. Compute the doubleword Q as follows:
;the bits 0-6 of Q are the same as the bits 10-16 of T
;the bits 7-24 of Q are the same as the bits 7-24 of (R XOR T).
;the bits 25-31 of Q are the same as the bits 5-11 of R.
bits 32

global start

extern exit

import exit msvcrt.dll

segment data use32 class=data
     r dd 1001_1011_1011_1110_1100_1011_1101_0111b
     t dd 1101_1101_0100_0101_1001_0110_1011_1110b
 ;r xor t 0100_0110_1111_1011_0101_1101_0110_1001b
  ;result 1011_1100_1111_1011_0101_1101_0110_0101b
     
segment code use32 class=code
start:    
    mov EBX, 0 ;result will be computed in EBX
    
    mov EAX, [t]
    and EAX, 0000_0000_0000_0001_1111_1100_0000_0000b ;we isolate bits 10-16 of T
    mov CL, 10
    ror EAX, CL ;we rotate by 10 positions to the right
    or EBX, EAX ;we put the bits in the result
    
    mov EAX, [r]
    xor EAX, [t] ;EAX = R XOR T
    and EAX, 0000_0001_1111_1111_1111_1111_1000_0000b ;we isolate bits 7-24 of (R XOR T)
    or EBX, EAX ;we put the bits in the result
    
    mov EAX, [r]
    and EAX, 0000_0000_0000_0000_0000_1111_1110_0000b ;we isolate bits 5-11 of R
    mov CL, 20
    rol EAX, CL ;we rotate by 20 positions to the left
    or EBX, EAX ;we put the bits in the result
    

    push dword 0
    call [exit]