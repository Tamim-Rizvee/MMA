;Take a single character as input and find whether it is an uppercase 
;alphabet, or lowercase alphabet, or number, or any other special character. 



.model small
.stack 100h
.data  

    inp          db "Enter a character: $" 
    upper_case   db 0dh,0ah,"The character is upper_case. $"
    lower_case   db 0DH,0AH,"The character is lower_case. $"  
    special      db 0DH,0AH,"The character is special.$"
    

.code

main proc 
    mov ax , @data
    mov ds , ax
     
    mov ah , 09h
    lea dx , inp
    int 21h
    
    mov ah , 01h
    int 21h
    mov bl , al
    
    cmp al , 'A'
    jl  label1
    cmp al , 'Z'
    jg  label1 
    
    mov ah , 09h
    lea dx , upper_case
    int 21h 
    jmp label3
    
label1:
    cmp al , 'a'
    jl  label2
    cmp al , 'z'
    jg  label2  
    
    mov ah , 09h
    lea dx , lower_case
    int 21h
    jmp label3

label2:
    mov ah , 09h
    lea dx , special
    int 21h
    
label3:   
    main endp
end main
