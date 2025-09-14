;seperates the odd and even element from an array 
;and stores them in two seperate arrays


.model small
.stack 100h
.data

    total       dw ?
    count       db ?
    size        db 10
    array       dw 10 dup(?)
    e_array     dw 10 dup(0)
    o_array     dw 10 dup(0)
    e_index     dw 0
    o_index     dw 0
    odd_i       db 0dh,0ah,"Odd sub_array: $"
    even_i      db 0dh,0ah,"Even sub_Array: $"
    o_size      db ?
    e_size      db ?

.code
main proc
    mov ax , @data
    mov ds , ax
        
;call array input and print the array
    mov bx , offset array
    call array_input
    call newline
    call array_output
    
;calling the seperator function and printing the odd even array
    mov bx , offset array
    call trim_odd_even
     
    mov dx , 0
    mov dl , size ;to keep the original array  same
    push dx
    
                       
    lea dx , even_i
    call print
    mov dl , e_size
    mov size , dl
    mov bx , offset e_array ;printing the even array
    call array_output 
    call newline
    
    lea dx , odd_i
    call print
    mov dl , o_size
    mov size , dl
    mov bx , offset o_array ;printing the odd array
    call array_output
    mov dx , 0 
    pop dx
    mov size , dl
    
    
    jmp final_destination
    main endp
;seperating odd even elements into different array
trim_odd_even proc    
    push dx
    push cx
    push bx
    mov cl ,1
    mov e_index , 0
    mov o_index , 0 
    mov si , 0 
    mov e_size , 0
    mov o_size , 0
looping:
    cmp cl , size
    jg  returning
    
    pop bx  
    mov dx , [bx + si] 
    test dx , 1
    jz  in_even_array
    jmp in_odd_array
update:
    inc cl 
    add si , 2
    jmp looping
                
returning:
    pop bx
    pop cx
    pop dx
    ret

in_even_array:
    mov dx , [bx + si]
    push bx
    push si
 
    mov bx , offset e_array
    mov si , e_index
    mov [bx + si], dx
    
    add e_index , 2 
    pop si  
    inc e_size
    jmp update 
    
in_odd_array:
    mov dx , [bx + si]
    push bx
    push si
    
    mov bx , offset o_array
    mov si , o_index
    mov [bx + si] , dx
    
    add o_index , 2
    pop si  
    inc o_size
    jmp update
    
    trim_odd_even endp


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