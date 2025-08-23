.model small
.stack 100h
.data 

    crg     db 0dh 
    delim   db 0dh,0ah,"$" 

.code 
main proc 
    mov dx , @data
    mov ds , dx 
    
    mov ah , 01h
    mov bl , 0
input:
    int 21h
    cmp al , crg
    je  endl
    
    sub al , '0'
    shl bl , 1
    or  bl , al
    jmp input
endl:
    mov ah , 09h
    lea dx , delim
    int 21h
    
    mov cl , 1
begin:
     cmp cl , 8
     jg  sesh
     
     rol bl , 1
     jc  print_one
     jnc print_zero 
     
jmp_here:     
     inc cl
     jmp begin 
     
print_one:
     mov ah , 02h
     mov dl , '1'
     int 21h
     jmp jmp_here
     
print_zero:
     mov ah , 02h
     mov dl , '0'
     int 21h 
     jmp jmp_here   

sesh:  
    main endp
end main