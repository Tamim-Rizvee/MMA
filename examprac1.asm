.model small
.stack 100h
.data 

    total   db 0
    count   db 0

.code
main proc
    mov ax , @data
    mov ds , ax
    
    call cin 
    call newline
    call cout
    
    
    jmp final_destination 
    main endp

cin proc
    push bx 
    mov total , 0
shuru1: 
    mov ah , 01
    int 21h
    cmp al , 0dh
    je  sesh1
    
    sub al , '0'
    mov bl , al
    mov al , 10
    mul total
    add al , bl
    mov total , al
    jmp shuru1
sesh1:
    pop bx
    ret
        
    cin endp   


newline proc
    mov ah , 02h
    mov dx , 0dh
    int 21h
    
    mov dx , 0ah
    int 21h 
    ret

    newline endp  


cout proc 
    push bx
    push cx
    push dx 
    mov  al , total
    mov dx , 0
shuru2:
    mov bl , 10
    mov ah , 0
    div bl
    mov dl , ah
    push dx
    inc count
    cmp al , 0
    jne shuru2  
    
    mov cl , 1
    mov dx , 0
print:  
    cmp cl , count
    jg sesh2
    pop dx
    add dl , '0'
    mov ah , 02h 
    int 21h  
    
    inc cl
    jmp print
    
sesh2:
    pop dx 
    pop cx 
    pop bx
    ret
    
    cout endp  

final_destination:
end main