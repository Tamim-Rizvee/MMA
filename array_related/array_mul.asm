;enter array element space seperated and after last elemnt
;press space to proceed(to need of enter)

.model small
.stack 100h
.data 

    total   dw 0
    count   db 0 
    array1  dw 10 dup(?) 
    array2  dw 10 dup(?)
    array3  dw 10 dup(?)
    size    db 10 
    odd     db ?
    even    db ?
    fir_i   db 0dh,0ah,"Enter the first array:$"
    sec_i   db 0dh,0ah,"Enter the second array:$"
    result  db 0dh,0ah,"Result Array:$"

.code
main proc
    mov ax , @data
    mov ds , ax               
    
;taking the first array as input and printing
    lea dx , fir_i
    call print_prompt
                 
    mov bx , offset array1
    call array_input
    call newline  
    call array_output 
;taking second array as input and printing 
    lea dx , sec_i
    call print_prompt
    
    mov bx , offset array2
    call array_input
    call newline
    call array_output 
    
;calculating sum and printing the resultant array
    call array_sum
    lea  dx , result
    call print_prompt
    
    mov bx , offset array3
    call array_output
       
    
    
    jmp final_destination 
    main endp 

;function for calculating sum into a third array
array_sum proc
    push bx
    push dx 
    push cx 
    mov si , 0
    mov cl , 1
calculating:
    mov ax , 0
    cmp cl , size
    jg  finish 
    
    mov bx , offset array1
    mov dx , [bx + si]
    
    mov bx , offset array2
    mov ax , [bx + si ]
    mul dx
    
    
    mov bx , offset array3
    mov [bx + si] , ax
    
    add si , 2 
    inc cl
    jmp calculating 
    
finish:
    pop cx
    pop dx 
    pop bx
    ret
    array_sum endp



;function for array input
array_input proc
    push cx 
    push dx
    mov si , 0 
    mov cl , 1
nite_thakbo:
    cmp cl , size
    jg  eikhane
    
    call cin 
    mov dx , total
    mov [bx+ si] , dx
    
    inc cl
    add si , 2 
    call space
    jmp nite_thakbo
    
eikhane:
    
    pop dx 
    pop cx 
    ret
    
    array_input endp


;function for array output    
array_output proc
    push cx
    push dx
    mov si , 0
    mov cl , 1
dite_thakbo:
    cmp cl , size
    jg  eikhane2 
    
    mov dx , [bx + si]
    mov total , dx
    call cout 
    call space
    call space
    
    inc cl
    add si , 2
    jmp dite_thakbo 
eikhane2:
    pop dx 
    pop cx 
    ret 
    
    array_output endp    


;function for single digit input
cin proc
    push bx 
    mov total , 0
shuru1: 
    mov ah , 01
    int 21h
    cmp al , 20h
    je  sesh1
    
    mov ah , 0
    sub ax , '0'
    mov bx , ax
    mov ax , 10
    mul total
    add ax , bx
    mov total , ax
    jmp shuru1
sesh1:
    pop bx
    ret
        
    cin endp   


;function for printing newline
newline proc
    mov ah , 02h
    mov dx , 0dh
    int 21h
    
    mov dx , 0ah
    int 21h 
    ret

    newline endp 

;for printng space
space proc   
    mov ah , 02h
    mov dx , 20h
    int 21h
    
    ret
    
    space endp


;function for single digit output
cout proc 
    push bx
    push cx
    push dx 
    mov  ax , total
    mov  dx , 0
    mov  count , 0
shuru2:
    mov bx , 10
    mov dx , 0
    div bx
    push dx
    inc count
    cmp ax , 0
    jne shuru2  
    
    mov cl , 1
    mov dx , 0
print:  
    cmp cl , count
    jg sesh2
    pop dx
    add dx , '0'
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


;function for printing prompt
print_prompt proc
    mov ah , 09h
    int 21h
    call newline
    ret
    print_prompt endp

final_destination:
end main