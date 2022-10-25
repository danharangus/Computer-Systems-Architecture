;A string of doublewords is given. Compute the string formed by the high bytes of the low words from the elements of the doubleword string ;and these bytes should be multiple of 10.

bits 32 
global start
extern exit; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll; exit is a function that ends the calling process. It is defined in msvcrt.dll

segment data use32 class=data
    s dd 12345678h, 1A2B3C4Dh, 4E98DC76h   ;3Ch, DCh
    len equ ($ - s) / 4 ;length of the string
    d times len db 0
    z db 10

; our code starts here
segment code use32 class=code
start:
        mov esi, s ;store the FAR adress of s in esi
        cld ;parse the string from left to right
        mov ecx, len
        mov edx, 0
        repeat:
            lodsw ;in eax we will have the low word of the current doubleword of the string
            
            mov bx, 0
            mov bl, ah ;bx = high byte of the low word 
            mov eax, 0
            mov ax, bx ;ax = high byte of the low word
            div byte [z] ;we check if the high byte is divisible by 10
            
            cmp ah, 0
            jne continue
            mov [d + edx], bl ;if it is divisible by 10 we add it to the result
            
            continue:
            lodsw ;in eax we will have the high word of the current doubleword of the string
            inc edx
           
            
        loop repeat
        
        push dword 0; push the parameter for exit onto the stack
        call [exit]; call exit to terminate the program
        