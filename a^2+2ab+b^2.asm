.model small
.stack 100h
.data 

    inp1    db "Enter a: $"
    inp2    db "Enter b: $"
    a       db ?
    b       db ?
    delim   db 0dh,0ah,"$"
    ans     db 0
    

.code
main proc  
    mov dx , @data
    mov ds , dx
    
    mov ah , 09h
    lea dx , inp1
    int 21h 
    
    mov ah , 01h
    int 21h
    sub al , '0'
    mov a , al  
    
    mov ah , 09h
    lea dx , delim
    int 21h
    
    mov ah , 09h
    lea dx , inp2
    int 21h
    
    mov ah , 01h
    int 21h
    sub al , '0'
    mov b , al
              
              
    mov al , a
    mul a
    add ans , al
    
    mov al , b
    mul b
    add ans , al
    
    mov al , 2
    mul b
    mul a
    add ans , al    
       
    main endp
end main