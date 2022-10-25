;Read from file numbers.txt a string of numbers (odd and even). Build two strings using readen numbers:
;P – only with even numbers
;N – only with odd numbers
;Display the strings on the screen.
bits 32 

global start        

extern exit, fread, fopen, fclose, printf
extern compute_number, is_even_number


import exit msvcrt.dll  
import fread msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    file_name           db      "data.txt", 0
    access_mode         db      "r", 0
    
    file_descriptor     dd      -1
    
    open_error_text     db      "There was an error while trying to open the file...", 0
    
    max_len             equ     100     ; maximum number of characters to read
    numbers             resb    max_len   ; the string will have maximum 100 characters
    
    even_numbers        resb    max_len
    odd_numbers         resb    max_len
    
    even_len            dd      0
    odd_len             dd      0
    
    even_print          db      "Even numbers: ", 0
    odd_print           db      "Odd numbers: ", 0
    no_format           db      "%d ", 0
    new_line            db      10, 0
    
    
    temp                dd      0
    last_no_len         dd      0
    
    
segment code use32 class=code
    start:
        
        ; open the file
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4 * 2
        
        mov [file_descriptor], eax
        
        ; check if fopen() successfully opened the file
        cmp dword [file_descriptor], 0
        je open_error
        
        ; read the numbers
        ; int fread(void * str, int size, int count, FILE * stream)
        push dword [file_descriptor]
        push dword max_len
        push dword 1
        push dword numbers
        call [fread]
        add esp, 4 * 4  ; clear the stack
        
        
        ; clsoe the file
        push dword [file_descriptor]
        call [fclose]
        add esp, 4 * 1
        
        
        mov esi, numbers  ; [esi] = the start adress of numbers

        
        solve:
            
            push dword esi
            call compute_number  ; the result is stored in ecx
            
            mov [temp], eax
     
            
            
            ; the paramater is EAX
            call is_even_number  ; EBX = 1 if EAX is even, 0 otherwise
            
            mov eax, [temp]
    
            
            
            cmp ebx, 1
            je is_even
            
            mov edi, [odd_len]
            mov [odd_numbers + edi], eax
            add dword [odd_len], 4
            
        
            jmp skip  ; skip over is_even because the number is odd
            is_even:
            
            mov edi, [even_len]
            mov [even_numbers + edi], eax
            add dword [even_len], 4
            
            skip:
            
            cmp ecx, -1  ; we found the end of input (this was the last number)
            je end_of_input
            
        cmp ecx, -1  ; if ecx == -1 we computed the last number
        jne solve
        
        end_of_input:
        
        push dword even_numbers ; print on the screen "Even numbers: "
        push dword even_print
        call [printf]
        add esp, 4 * 2
        
        ; print each even number on the screen       
        mov ecx, 0
        print_even_nr:
            
            pushad  ; push all registers on the stack so we can recover ECX later
            push dword [even_numbers + ecx]
            push dword no_format  ; push the number on the stack
            call [printf]  ; push the print format
            add esp, 4 * 2  ; clear the stack
            popad  ; recover all the registers
            
        add ecx, 4  ; each number is 4 bytes therefore we need to increase the index with 4 
        cmp ecx, [even_len]  ; we loop untill ecx == [even_len]  (from 0 to [even_len] - 1)
        jl print_even_nr
 
        push dword new_line  ; print on the screen "\n"
        call [printf]
        add esp, 4 * 1
        
        
        push dword odd_numbers  ; print on the screen "Odd numbers: "
        push dword odd_print
        call [printf]
        add esp, 4 * 2
        
        ; print each even number on the screen
        mov ecx, 0
        print_odd_nr:
            
            pushad  ; push all registers on the stack so we can recover ECX later
            push dword [odd_numbers + ecx]  ; push the number on the stack
            push dword no_format  ; push the print format
            call [printf]
            add esp, 4 * 2  ; clear the stack
            popad  ; recover all the registers
            
        add ecx, 4  ; each number is 4 bytes therefore we need to increade the index with 4
        cmp ecx, [odd_len] ; we loop untill ecx == [odd_len]  (from 0 to [odd_len] - 1)
        jl print_odd_nr
        
        
        jmp _end  ; if the program didnt jump over this line there were no erros
        
        open_error:
        
        push dword open_error_text
        call [printf]    
        add esp, 4 * 1
        
        _end:
        push    dword 0      
        call    [exit]