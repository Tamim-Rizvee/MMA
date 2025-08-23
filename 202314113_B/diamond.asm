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
               
    mov ah , 09h
    lea dx , delim
    int 21h
               
    mov cl , n
    sub cl , 1
    mov k  , cl
    mov bl , 1
outer:
    cmp bl , n
    jg label4 
    mov bh , 1
    loop_space:
        cmp bh , k
        jg label1
        
        mov ah , 02h
        mov dl , space
        int 21h
        
        inc bh
        jmp loop_space
        
    label1:
        mov bh , 1
        mov ch , n
        sub ch , k
        mov j  , ch
        loop_star:
            cmp bh , j
            jg  label2
            
            mov ah , 02h
            mov dl , star
            int 21h
            
            inc bh
            jmp loop_star
            
    label2:
        mov cl , 1
        another_star:
            cmp cl , bl
            jge label3
            
            mov ah , 02h
            mov dl , star
            int 21h
            
            inc cl
            jmp another_star           
    
    label3:
        dec k  
        inc bl
        
        mov ah , 09h
        lea dx , delim
        int 21h
        jmp outer
label4: 
    mov bl , n
    mov k , 1
    outer2: 
        cmp bl , 0
        jle label8
        mov cl , 1
        loop_space2:
            cmp cl , k
            jg label5
            
            mov ah , 02h
            mov dl , space
            int 21h
            
            inc cl
            jmp loop_space2
       label5:
             mov cl , 1
             mov bh , n
             sub bh , k
             mov j  , bh
             loop_star2:
                cmp cl , j
                jg label6
                
                mov ah , 02h
                mov dl , star
                int 21h
                
                inc cl 
                jmp loop_star2
      label6:
        mov cl , 1 
        mov dl , bl
        sub dl , 1
        mov j  , dl
        another_star2:
            cmp cl , j
            jge label7
            
            mov ah , 02h
            mov dl , star
            int 21h
            
            inc cl 
            jmp another_star2
      label7:
        dec bl
        inc k
        
        mov ah , 09h
        lea dx , delim
        int 21h
        
        jmp outer2
        
label8:           
      
    main endp
end main