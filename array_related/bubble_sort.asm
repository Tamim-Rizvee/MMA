.model small
.stack 100h
.data

    total       db ?
    count       db ?
    size        db 10
    array       db 10 dup(?)
    max         db ?
    max_el      db 0dh,0ah,"The maximum element of the array is: $"

.code
main proc
    mov ax , @data
    mov ds , ax
        
;call array input and print the array
    mov bx , offset array
    call array_input
    call newline
;call bubble sort and output the sorted array
    mov bx , offset array
    call bubble_sort
    
    call newline
    call array_output

        
    jmp final_destination
    main endp

;function for bubble sort
bubble_sort proc
    push cx
    push dx
    mov si , 0
    mov cl , 0
outer_loop:
    cmp cl , size
    je  baire 

    mov ch , 0 
inner_loop: 
    mov dl , size
    sub dl , cl
    dec dl 
    cmp ch , dl
    je  iloop_out 
    
    mov dx , 0
    mov dl , ch
    mov si , dx
    mov dl , [bx + si]
    cmp dl , [bx + si + 1]
    jg  swap 
than:
    inc ch
    jmp inner_loop
    
iloop_out:
    inc cl 
    jmp outer_loop
    
swap:
    mov dl , [bx + si]
    mov dh , [bx + si + 1]
    mov [bx + si] , dh
    mov [bx + si + 1] , dl 
    jmp than
    
baire:
    pop dx
    pop cx
    ret
    
    bubble_sort endp


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
    mov dl , total
    mov [bx + si] , dl 
    
    inc cl
    add si , 1 
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
    
    mov dl , [bx + si]
    mov total , dl
    call cout
    
    call space 
    call space 
    
    inc cl
    add si, 1
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
    mov bl , al
    mov al , 10
    mul total
    add al , bl
    mov total , al
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
    mov al , total
    mov count , 0 
    mov dx , 0
output:
    mov ah , 0
    mov bl , 10
    div bl 
    mov dl , ah
    push dx 
    inc count
    
    cmp al , 0
    jne output
              
              
    mov cl , 1
printing: 
    cmp cl , count
    jg  sesh2
    
    pop dx 
    add dl , '0' 
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