;Two natural numbers a and b (a: dword, b: dword, defined in the data segment) are given. Calculate a/b and display the quotient in the following format: "<a>/<b> = ;<quotient>". Example: for a = 200, b = 5 it will display: "200/5 = 40".
;The values will be displayed in decimal format (base 10) with sign.
bits 32
global start        

; declaring extern functions used in the program
extern exit, printf, scanf            
import exit msvcrt.dll     
import printf msvcrt.dll     ; indicating to the assembler that the printf fct can be found in the msvcrt.dll library
import scanf msvcrt.dll      ; similar for scanf
                          
segment  data use32 class=data
    a dd 0       ; this is the variable where we store the first number read from keyboard
    b dd 0       ; this is the variable where we store the second number read from keyboard
    q dd 0
    message  dd "%d / %d = %d", 0  
    format  db "%d", 0  ; %d <=> a hex number
    
segment  code use32 class=code
    start:
        ; calling scanf(format, n) => we read the number and store it in the variable n
        ; push parameters on the stack from right to left
        push  dword a       ; ! address of a, not the value
        push  dword format
        call  [scanf]       ; call scanf for reading
        add  esp, 4 * 2     ; taking parameters out of the stack; 4 = dimension of a dword; 2 = nr of parameters
        
        push  dword b      ; ! address of b, not the value
        push  dword format
        call  [scanf]       ; call scanf for reading
        add  esp, 4 * 2     ; taking parameters out of the stack; 4 = dimension of a dword; 2 = nr of parameters
        
        mov eax, [a]
        mov edx, 0 ;EDX:EAX = a
        
        mov ebx, [b]
        
        div dword ebx ;EAX = a/b
        
        mov [q], eax
        
        ;print the message and the result of the division
        push dword [q]
        push dword [b]
        push dword [a]
        push  dword message 
        call  [printf]
        add  esp, 4*4
        
        ; exit(0)
        push  dword 0     ; push the parameter for exit on the stack
        call  [exit]       ; call exit