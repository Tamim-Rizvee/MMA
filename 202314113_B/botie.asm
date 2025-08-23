.model small
.stack 100h
.data

    inp     db "n= $"
    delim   db 0dh,0ah,"$"
    star    db '#'
    n       db ?
    space   db ' ' 
    k       db ?
    j       db ?  
    space_n db ?
    star_n  db ?
    

.code
main proc 
    mov ax , @data
    mov ds , ax
    
    mov ah , 09h
    lea dx , inp
    int 21h
    
    mov ah , 01h
    int 21h 
    sub al , '0'
    mov n  , al
               
    dec al
    add al , n 
    mov k , al
    mov space_n , al 
    sub space_n , 2
    mov star_n , 1
    
    mov ah , 09h
    lea dx , delim
    int 21h 
    mov bl , 1
outer: 
    cmp bl , n
    jge label4
    
    mov cl , 1
    left_star: 
        cmp cl , star_n
        jg  label1
        
        mov ah , 02h
        mov dl , star
        int 21h
        
        inc cl
        jmp left_star
label1:  
    mov cl , 1
    space_loop: 
        cmp cl , space_n
        jg  label2
        
        mov ah , 02h
        mov dl , space
        int 21h
        
        inc cl
        jmp space_loop
label2:
    mov cl , 1 
    right_star:
        cmp cl , star_n
        jg  label3
        
        mov ah , 02h
        mov dl , star
        int 21h
        
        inc cl
        jmp right_star
label3:
    mov ah , 09h
    lea dx , delim
    int 21h
    
    sub space_n , 2
    inc star_n
    
    inc bl
    jmp outer
label4:
    mov bl , 1
    emne:
        cmp bl , k
        jg  label5
        
        mov ah , 02h
        mov dl , star
        int 21h
        
        inc bl
        jmp emne:
label5: 
   mov ah , 09h
   lea dx , delim
   int 21h
   mov bl , n
   dec bl
   mov star_n , bl
   mov space_n , 1
   
   mov bl , 1 
outer2: 
    cmp bl , n
    jge label9
    
    mov cl , 1
    left_star2: 
        cmp cl , star_n
        jg  label6
        
        mov ah , 02h
        mov dl , star
        int 21h
        
        inc cl
        jmp left_star2
label6:  
    mov cl , 1
    space_loop2: 
        cmp cl , space_n
        jg  label7
        
        mov ah , 02h
        mov dl , space
        int 21h
        
        inc cl
        jmp space_loop2
label7:
    mov cl , 1 
    right_star2:
        cmp cl , star_n
        jg  label8
        
        mov ah , 02h
        mov dl , star
        int 21h
        
        inc cl
        jmp right_star2
label8:
    mov ah , 09h
    lea dx , delim
    int 21h
    
    add space_n , 2
    dec star_n
    
    inc bl
    jmp outer2
label9:
     
      
    main endp
end main