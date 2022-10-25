;Given an array A of doublewords, build two arrays of bytes:  
; - array B1 contains as elements the higher part of the higher words from A
; - array B2 contains as elements the lower part of the lower words from A

bits 32 
global start
extern exit; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll; exit is a function that ends the calling process. It is defined in msvcrt.dll

segment data use32 class=data
    sir dd  10203040h, 50607080h  ;b1: 10 50, b2:40 80
    len equ ($ - sir) / 4 ;length of the string
    b1 times len db 0
    b2 times len db 0
; our code starts here
segment code use32 class=code
start:
        mov esi, sir ;store the FAR adress of sir in esi
        cld ;parse the string from left to right
        mov ecx, len
        mov ebx, 0
        mov edx, 0
        repeat:
            lodsw ;in eax we will have the low word of the current doubleword of the string
            mov [b2 + edx], al
            lodsw ;in eax we will have the high word of the current doubleword of the string
            mov [b1 + ebx], ah
            inc ebx
            inc edx
            
        loop repeat
        
        push dword 0; push the parameter for exit onto the stack
        call [exit]; call exit to terminate the program
        