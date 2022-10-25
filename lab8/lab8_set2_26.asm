;26. A file name (defined in data segment) is given. Create a file with the given name, then read words from the keyboard until character '$' is read. Write only the words that contain at least one uppercase letter to file.
bits 32

global start

; declare external functions needed by our program
extern exit, scanf, fopen, fprintf, fclose
import exit msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "file.txt", 0   ; filename to be created
    access_mode db "w", 0       ; file access mode:
                                ; w - creates an empty file for writing
    file_descriptor dd -1       ; variable to hold the file descriptor
    c db "$", 0
    text times 100 db 0
    format db "%s"
    has_uppercase db 0
    zero db 0
    one db 1
    

; our code starts here
segment code use32 class=code
    start:
        ; call fopen() to create the file
        ; fopen() will return a file descriptor in the EAX or 0 in case of error
        ; eax = fopen(file_name, access_mode)
        push dword access_mode     
        push dword file_name
        call [fopen]
        add esp, 4*2                ; clean-up the stack

        mov [file_descriptor], eax  ; store the file descriptor returned by fopen
        
        ; check if fopen() has successfully created the file (EAX != 0)
        cmp eax, 0
        je final

        repeat:
            push dword text
            push dword format
            call [scanf]
            add esp, 4 * 2
            
            mov ebx, [text]
            cmp bl, [c]
            je endrepeat
            mov esi, text
            mov bl, [zero]
            mov [has_uppercase], bl
            
            iterate:  ;we iterate the word
                lodsb
                cmp al, 0   ;if we reach the end of the word we stop iterating
                je endword
                
                cmp al, 65 
                jb not_uppercase
                cmp al, 90
                jg not_uppercase   
                
                mov bl, [one]
                mov [has_uppercase], bl ;if the current character is uppercase, we set has_uppercase to 1
                
                ; write the text to file using fprintf()
                ; fprintf(file_descriptor, text)
                not_uppercase:
            jmp iterate
            endword:
            
            mov bl, [has_uppercase]
            cmp bl, [zero] ;we write the word if it has an uppercase letter
            je no_uppercase
            push dword text
            push dword [file_descriptor]
            call [fprintf]
            add esp, 4*2
            
            no_uppercase:
        
        jmp repeat
    
        endrepeat:
        ; call fclose() to close the file
        ; fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4

        final:
        ; exit(0)
        push dword 0      
        call [exit]