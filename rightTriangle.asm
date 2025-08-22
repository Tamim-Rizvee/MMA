.model small
.stack 100h
.data 

    delim   db 0dh,0ah,"$"
    star    db '*'
    inp     db "n= $" 
    n       db ? 
    k       db ?

.code
main proc 
    mov ax , @data
    mov ds , ax
    
    mov ah , 09h
    lea dx , inp
    int 21h
    
    mov ah , 01h
    int 21h 
    sub al , '0'
    mov n  , al
    mov bl , 1 
    mov k  , 1
    
    mov ah , 09h
    lea dx , delim
    int 21h
    
outer: 
    cmp bl , n
    jg  label3
    mov cl , 1
    inner:
        cmp cl , k
        jg  label2
        
        mov ah , 02h
        mov dl , star
        int 21h
        
        inc cl
        jmp inner 
    label2:
        mov ah , 09h
        lea dx , delim
        int 21h
        
        inc bl
        inc k
        jmp outer

    
label3:    
    main endp
end main