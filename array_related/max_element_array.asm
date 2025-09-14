.model small
.stack 100h
.data

    total       dw ?
    count       db ?
    size        db 10
    array       dw 10 dup(?)
    max         dw ?
    max_el      db 0dh,0ah,"The maximum element of the array is: $"

.code
main proc
    mov ax , @data
    mov ds , ax
        
;call array input and print the array
    mov bx , offset array
    call array_input
    call newline
    call array_output
;finding the maximum value
    lea dx , max_el
    call print
    
    mov bx , offset array          
    call find_max          
    mov dx , max 
    mov total , dx
    call cout 
    
                
    
    jmp final_destination
    main endp

;finding for maximum element in an array
find_max proc
    push dx
    push cx 
    mov dx , [bx + 0]
    mov max , dx
    mov cl , 1
    mov si , 2
looping:
    cmp cl , size
    jge returning
    
    mov dx , [bx + si]
    cmp dx , max
    jg  change_max
updating:
    inc cl
    add si , 2 
    jmp looping
    
returning:
    pop cx
    pop dx
    ret

change_max:
    mov max , dx
    jmp updating    
    
    find_max endp


;function for array input
array_input proc
    push dx 
    push cx
    mov cl , 1
    mov si , 0
taking: 
    cmp cl , size
    jg  sesh1
    
    call cin
    mov dx , total
    mov [bx + si] , dx 
    
    inc cl
    add si , 2 
    call space
    jmp taking
sesh1:
    pop cx
    pop dx
    ret
    
    array_input endp 

;function for array output
array_output proc
    push dx 
    push cx
    mov si , 0
    mov cl , 1
giving:
    cmp cl , size
    jg  seshe2
    
    mov dx , [bx + si]
    mov total , dx
    call cout
    
    call space 
    call space 
    
    inc cl
    add si, 2
    jmp giving
seshe2:
    pop cx
    pop dx
    ret
    
    array_output endp


;function for single number input
cin proc
    push bx 
    push cx
    push dx
    mov total , 0
input:
    mov ah , 01h
    int 21h
    cmp al , 20h
    je  sesh
    
    sub al , '0'
    mov ah , 0
    mov bx , ax 
    mov ax , 10
    mul total
    add ax , bx
    mov total , ax
    jmp input
sesh:
    pop dx 
    pop cx 
    pop bx
    ret
  
    cin endp

;function for single number output
cout proc
    push bx
    push cx 
    push dx
    mov ax , total
    mov count , 0 
output:
    mov dx , 0
    mov bx , 10
    div bx 
    push dx 
    inc count
    
    cmp ax , 0
    jne output
              
              
    mov cl , 1
printing: 
    cmp cl , count
    jg  sesh2
    
    pop dx 
    add dx , '0' 
    mov ah , 02h
    int 21h 
    inc cl
    jmp printing
    
sesh2:
    pop dx 
    pop cx 
    pop bx
    ret
    
    cout endp

;function for printing newline
newline proc
    mov ah , 02h
    mov dx , 0dh
    int 21h
    
    mov dx , 0ah
    int 21h
    ret
    
    newline endp
;function for printing space
space proc
    push dx 
    mov ah , 02h
    mov dx , 20h
    int 21h
    pop dx
    ret 
    
    space endp 

;function for prompt printng
print proc
    mov ah , 09h
    int 21h
    ret
    
    print endp


final_destination:
end main