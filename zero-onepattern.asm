.model small
.stack 100h
.data

    inp     db "Enter n = $"
    delim   db 0dh,0ah,"$"
    n       db ?
    space   db ? 
    stn     db ?
    

.code
main proc 
    
    mov dx , @data
    mov ds , dx 
    
    mov ah , 09h
    lea dx , inp
    int 21h
    
    mov ah , 01h
    int 21h
    
    sub al , '0'
    mov n , al
    mov space , al
    dec space 
    
    mov ah , 09h
    lea dx , delim
    int 21h
    
    mov bl , 1
    mov ch , 1
outer:
    cmp bl , n
    jg label4
    
    mov cl , 1
    space_loop:
        cmp cl , space
        jg  label2
        
        mov ah , 02h
        mov dl , ' '
        int 21h
        
        inc cl
        jmp space_loop 
        
   label2: 
        mov cl , 1  
        mov ah , n
        sub ah , space
        mov stn , ah
        print: 
            cmp cl , stn
            jg  label3
            
            
            mov dl , ch
            add dl , '0'
            mov ah , 02h
            int 21h
            
            
            inc cl 
            xor ch , 1
            jmp print
   label3:
        inc bl
        dec space 
        
        mov ah , 09h
        lea dx , delim
        int 21h
        
        jmp outer         
         
label4:
    dec n
    mov space , 1
    mov bl , n
    
outer2:
     cmp bl , 1
     jl  label5
     
     mov cl , 1
     space_loop2:
        cmp cl , space
        jg  label6
        
        mov ah , 02h
        mov dl , ' '
        int 21h
        
        inc cl 
        jmp space_loop2
        
     label6:
        mov cl , 1
        print2:
            cmp cl , bl 
            jg  label7
            
            mov dl , ch
            add dl , '0'
            mov ah , 02h
            int 21h
            
            
            inc cl
            xor ch , 1 
            jmp print2
            
     label7:
        mov ah ,09h
        lea dx ,delim
        int 21h
        
        dec bl
        inc space
        jmp outer2 

label5:         
    main endp
end main