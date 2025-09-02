.model small
.stack 100h
.data 

    ans     dw 0

.code 
main proc 
input:  
    mov dx , @data
    mov ds , dx
    
    mov ah , 01h 
    int 21h
    cmp al , 0dh
    je ending 
    
    sub al , '0'
    mov ah , 0 
    mov bx , ax
    
    mov ax , ans
    mov cx , 10
    mul cx 
    
    add ax , bx
    mov ans , ax 
    jmp input  
    
    
ending:    
    
    main endp
end main