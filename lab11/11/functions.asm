bits 32

import scanf msvcrt.dll
extern scanf

global read_string, compute_number


segment code use32 public code


character       db  0
read_format     db  "%c", 0
ten             dw  10



read_string:
    ; Reads text from the console untill the Enter button is pressed

    mov edi, [esp + 4]
    
    read_character:
       
        ; scanf(read_format, &character)
        push dword character
        push dword read_format
        call [scanf]
        add esp, 4 * 2  ; clear the stack
        
        cmp byte [character], 10  ; compare character with '\n'
        je read_end  ; we are done reading (the last character was '\n')
        
        cmp byte [character], 20  ; compare character with ' '
        je read_end  ; we are done reading (the last character was ' ')
        
        ; [edi] = [character]
        mov al, [character]
        mov [edi], al
        inc edi
        
    jmp read_character ; read another character
    
    read_end:
    ret 1 * 4
    

    
compute_number:
    ; Creates a number in base 10 and stores it in EBX
    
    mov esi, [esp + 4]
    mov eax, 0
    mov ebx, 0  ; result
    mov ecx, edi  ; the length of the number
    sub ecx, esi  ; the length of the number
    dec ecx        
    
    cmp ecx, 0  ; check if the number has only 1 digit
    jne start_loop
    cmp byte [esi], 30h  ; we check if the digit is 0
    je end_
    
    start_loop:
        
        lodsb  ; al = [esi], esi++
        cmp al, 20  ; if (al == ' ')
        je end_
        
        cmp al, 30h  ; if (al == '0')
        je store_number
        
        cmp al, 31h  ; if (al == '1')
        je store_number
        
        jmp error_  ; if (al != '0' && al != '1')
        store_number:
        
        sub al, 30h  ; al = 1/0
        shl eax, cl ; (1 << pos) or (0 << pos)
        dec ecx  ; ecx--
        or ebx, eax
          
        cmp ecx, -1
        je end_
        
    jmp start_loop ; read another character
    
    jmp end_
    
    error_:
    mov ebx, -1
    
    end_:
    
    ret 1 * 4
    
    
    
    