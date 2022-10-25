bits 32

import scanf msvcrt.dll
extern scanf

global is_even_number, compute_number


segment code use32 public code


character       db  0
read_format     db  "%c", 0
two             dw  2
ten             dw  10


is_even_number:
    ; Checks if a number is even or not. 
    ; The result will be stored in EAX
    ; If the number is even => EAX = 1, otherwise EAX = 0
    
    push eax  ; push the parameter on the stack (eax)
    pop ax  ; pop the low part of parameter (eax)
    pop dx  ; pop the high part of parameter (eax)
    
    div word [two]  ; AX = DX:AX / 2 ; DX = DX:AX % 2
    
    cmp dx, 1  ; If DX is 1 the number is odd
    je mark_as_odd
    
    mark_as_even:
    mov ebx, 1
    jmp _end  ; do not modify the value stored in EAX
    
    mark_as_odd:
    mov ebx, 0
    
    _end:
    ret 1 * 4
    
    
compute_number:
    ; Returns the next number from the memory adress
    ; The return result is stored in EAX
    ; ECX will be -1 if we found 0 (end of input)
    
    mov esi, [esp + 4]
    mov eax, 0 
    mov ecx, 0

    
    
    lodsb  ; al = [esi]
    xchg cl, al  ; cl = [esi]
    
    cmp cl, 20h  ; check if the first character is space
    je get_next_number_end
    
    cmp cl, 0  ; check if the first character is 0
    je end_of_input
    
    
    _loop:
        
        mul word [ten] ; DX:AX = DX:AX * 10
        
        push dx  ; move DX:AX to EAX
        push ax  ; move DX:AX to EAX
        pop eax  ; move DX:AX to EAX
        
        sub cl, 30h  ; get the actual value of the digits (not the one in ascii code)
        add eax, ecx  ; add the digit to the result
        
        xchg ecx, eax  ; change them so we do not break EAX
        lodsb  ; al = [esi] ; esi++
        xchg ecx, eax  ; cl <-> al
        
        cmp cl, 0  ;  check if last first character is 0
        je end_of_input
        
    cmp cl, 20h  ; check if the character is space
    jne _loop ; if the last character was not space, read another character
    
    jmp get_next_number_end  ; we only want to store -1 in ecx if we found 0
    
    end_of_input:
    mov ecx, -1  ; ecx will be one if there are no more characters after the last checked one
    
    get_next_number_end:
    ret 1 * 4