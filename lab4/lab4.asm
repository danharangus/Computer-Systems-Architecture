bits 32 ;asamblare si compilare pentru arhitectura de 32 biti
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului ca exit exista, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o functie care incheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll contine exit, printf si toate celelalte functii C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele 
     a dw 0111011101010111b
     b dw 1001101110111110b
     c dw 0
     
segment  code use32 class=code ; segmentul de cod
start: 

    ;Given the words A and B, compute the doubleword C as follows:
    ;the bits 0-4 of C are the same as the bits 11-15 of A
    ;the bits 5-11 of C have the value 1
    ;the bits 12-15 of C are the same as the bits 8-11 of B
    ;the bits 16-31 of C are the same as the bits of A
    stc ; CF = 1 (set carry)

    mov  bx, 0 ; we compute the result in bx

    mov  ax, [a] ;
    and  ax, 1111100000000000b
    mov  cl, 5
    rol  ax, cl ; we rotate 5 positions to the right
    or   bx, ax ; we put the bits into the result
    
    
    or   bx, 0000111111100000b ; we force the value of bits 5-11 of the result to the value 1
    
    
    mov dx, [b]
    and dx, 000011110000000b
    mov cl, 4
    rol dx, cl
    or bx, dx
    
    
    mov eax, [a]
    and eax, 1111111111111111000000000000000
    mov dx, bx
    mov ebx, 0
    mov bx, dx
    or ebx, eax
    
   
     push dword 0 ;se pune pe stiva codul de retur al functiei exit
     call [exit] ;apelul functiei sistem exit pentru terminarea executiei programului	
