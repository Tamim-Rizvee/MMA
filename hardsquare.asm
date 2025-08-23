;hard square 
.model small
.stack 100h
.data

    inp     db "Enter n: $"
    delim   db 0dh,0ah,"$"
    star    db '*'
    space   db ' '
    n       db ?

.code 
main proc 
    mov dx , @data
    mov ds , dx
    
    mov ah , 09h
    lea dx , inp
    int 21h  
    
    mov ah , 01h
    int 21h
    
    sub al , '0'
    mov n  , al 
    
    mov ah , 09h
    lea dx , delim
    int 21h
    
    mov bl , 1
outer:
    cmp bl , n
    jg  endl
    
    mov cl , 1
    inner:
        cmp cl , n
        jg  label2
        cmp bl , 1
        je  l1s
        cmp bl , n
        je  l1s
        jmp l1e
    l1s:
        mov ah , 02h
        mov dl , star
        int 21h
        jmp label1
    l1e:
        cmp cl , 1
        je  l2s
        cmp cl , n
        je  l2s
        jmp l2e
    l2s:
        mov ah , 02h
        mov dl , star
        int 21h
        jmp label1
    l2e:
        mov ah , 02h
        mov dl , space
        int 21h
        
label1:
    inc cl
    jmp inner
    
label2:
    mov ah , 09h
    lea dx , delim
    int 21h
    
    inc bl
    jmp outer    
    
endl:    
    main endp
end main