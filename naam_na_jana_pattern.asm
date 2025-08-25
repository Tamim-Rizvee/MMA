.model small
.stack 100h
.data

    inp     db "Enter n= $"
    delim   db 0dh,0ah,"$"
    space   db ?
    n       db ?
    stn     db ?

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
    mov space , al
    dec space 
    
    mov ah , 09h
    lea dx , delim
    int 21h
    
    mov bl , 1
outer:  
    cmp bl , n
    jg  ending
    
    mov cl , 1
    loop_space:
        cmp cl , space
        jg  label2
        
        mov ah , 02h
        mov dl , ' '
        int 21h
        
        inc cl
        jmp loop_space
    label2:
        mov cl , 1
        mov ch, n
        sub ch , space
        mov stn , ch
        mov ch , 'A'
        
    loop_print: 
        cmp cl , stn
        jg  label3
        
        mov ah , 02h
        mov dl , ch
        int 21h
        
        inc ch
        inc cl
        jmp loop_print
    label3:
        mov ch , 'A'
        add ch , bl
        sub ch , 2
        
        mov cl , 1
    another_print:
        cmp cl , bl
        jge label4
        
        mov ah , 02h
        mov dl , ch
        int 21h
        
        dec ch 
        inc cl
        jmp another_print
          
   label4:
        
        mov ah , 09h
        lea dx , delim
        int 21h
        
        inc bl  
        dec space
        jmp outer
ending:     
                      
    main endp
end main