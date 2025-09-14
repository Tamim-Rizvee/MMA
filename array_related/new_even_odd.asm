.model small
.stack 100h
.data 

    total   db 0
    count   db 0 
    array   db 10 dup(?) 
    size    db 10 
    odd     db ?
    even    db ?
    odd_i   db 0dh,0ah,"The array is odd array $"
    even_i  db 0dh,0ah,"The array is even array $"
    same    db 0dh,0ah,"The array has equal odd and even elements$"

.code
main proc
    mov ax , @data
    mov ds , ax
               
    mov bx , offset array
    call array_input
    call newline  
    mov bx , offset array
    call array_output 
    call odd_even_same
    
    
    jmp final_destination 
    main endp 

odd_even_same proc 
    push dx 
    push cx 
    mov si , 0
    mov cl , 1   
    mov odd , 0
    mov even , 0
traverse:
    cmp cl , size
    jg  result
    
    mov dl , [bx + si]
    test dl , 1
    jz  even_count_increase
    jmp odd_count_increase
update:
     inc cl
     inc si
     jmp traverse
     
result: 
    mov dl , odd
    cmp dl , even
    jg  print_odd
    je  print_same
    jmp print_even
    
even_count_increase:
     inc even
     jmp update
odd_count_increase:
     inc odd
     jmp update
     
print_odd:
     mov ah , 09h
     lea dx , odd_i
     int 21h
     jmp return 
     
print_same:
     mov ah , 09h
     lea dx , same
     int 21h
     jmp return
     
print_even:
    mov ah , 09h
    lea dx , even_i
    int 21h
    jmp return
    
return:
    pop cx
    pop dx
    ret
   
    odd_even_same endp


array_input proc
    push cx 
    push dx
    mov si , 0 
    mov cl , 1
nite_thakbo:
    cmp cl , size
    jg  eikhane
    
    call cin 
    mov dl , total
    mov [bx+ si] , dl
    
    inc cl
    inc si 
    call space
    jmp nite_thakbo
    
eikhane:
    
    pop dx 
    pop cx 
    ret
    
    array_input endp
    
array_output proc
    push cx
    push dx
    mov si , 0
    mov cl , 1
dite_thakbo:
    cmp cl , size
    jg  eikhane2 
    
    mov dl , [bx + si]
    mov total , dl
    call cout 
    call space
    
    inc cl
    inc si
    jmp dite_thakbo 
eikhane2:
    pop dx 
    pop cx 
    ret 
    
    array_output endp    


cin proc
    push bx 
    mov total , 0
shuru1: 
    mov ah , 01
    int 21h
    cmp al , 20h
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

space proc   
    mov ah , 02h
    mov dx , 20h
    int 21h
    
    ret
    
    space endp


cout proc 
    push bx
    push cx
    push dx 
    mov  al , total
    mov dx , 0
    mov count , 0
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