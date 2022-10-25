; Multiple numbers in base 2 are read from the keyboard. Display these numbers in the base 16.

bits 32 

global start

import exit msvcrt.dll  
import printf msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll


extern exit, printf, fopen, fprintf, fclose
extern read_string, compute_number

segment data use32 class=data
    ; file_name           db      "output.txt", 0
    ; access_mode         db      "a", 0
    ; file_descriptior    dd      -1 
    
    b16_format          db      "%x", 10, 0  ; 10 is new line ('\n')
    end_text            db      "The program has stopped! (Last number was 0)", 0
    error_message       db      "Invalid binary number!", 10, 0
    number_s            resd    1  ; the maximum number of bits is 32
    number              dd      0
    
    
segment code use32 class=code
    start:
       
        r_number:
            
            mov dword [number_s], 0  ; clear the string representing the number
            
            push dword number_s
            call read_string
            
            push dword number_s
            call compute_number
            
            cmp ebx, -1 ; if ebx returns -1 there was an error (invalid number)
            je error_
            
            cmp ebx, 0  ; if ebx is 0 we are not going to print it
            je next_number
            
            push ebx
            push dword b16_format
            call [printf]    
            add esp, 4 * 2
            
            ; open the file
            ; push dword access_mode
            ; push dword file_name
            ; call [fopen]    
            ; add esp, 4 * 2
            
            ; mov [file_descriptior], eax 
            
            ; append the number
            ; push ebx
            ; push dword b16_format
            ; push dword [file_descriptior]
            ; call [fprintf]
            ; add esp, 4 * 2
            
            ; close the file
            ; push dword [file_descriptior]
            ; call [fclose]
            ; add esp, 4 * 1
        
            
            jmp next_number  ; jump over the error instructions
            error_:
            
            push dword error_message
            call [printf]
            
            next_number:
            
        cmp ebx, 0  ; if ebx is not 0, read another number
        jne r_number
        

        push dword end_text
        call [printf]    
        add esp, 4 * 2
        
        push    dword 0      
        call    [exit]
