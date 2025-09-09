;linear search



.model small
.stack 100h
.data 
     
    ;arr     db 0 ,1 , 2 , 3 , 4 , 5, 6 , 7, 8 , 9 
    arr1    db 10 dup(?)  
    arr2    db 10 dup(?)
    result  db 11 dup(?)
    total   db 0   ;input stored here 
    count   db 0 
    found   db 0dh,0ah,"Found $"
    n_found db 0dh,0ah,"Not Found $" 
    key     db ? 
    odd     db 0dh,0ah,"Odd array$"
    even    db 0dh,0ah,"Even array$" 
    sameen  db 0dh,0ah,"Sameen bhalo chele$" 
    odd_n   db 0
    even_n  db 0
    

.code

main proc

    mov ax,@data
    mov ds,ax 
    
    mov bx , offset arr1 ;base address stored in the bx
    mov si , 0 
    mov cl , 1  
    
in_put:
    cmp cl , 10
    jg label1
    
    call dec_inp 
    call new_line  
    mov dh , 0
    mov dl , total 
    mov [bx + si] , dx
    
    inc cl
    inc si
    jmp in_put
label1: 
    call new_line
    mov bx , offset arr1
    mov si , 0
   mov cl , 1
  
out_put:
    cmp cl , 10
    jg jj
      
    mov dx , [bx + si]
    mov total , dl
    call dec_out 
    call new_line
    
    inc cl 
    inc si
    jmp out_put 
jj:
    
    call new_line     
    mov bx , offset arr2 ;base address stored in the bx
    mov si , 0 
    mov cl , 1  
    
in_put2:  
    mov bx , offset arr2
    cmp cl , 10
    jg label12
    
    call dec_inp 
    call new_line  
    mov dh , 0
    mov dl , total 
    mov [bx + si] , dx 
    
    mov bx , offset arr1 
    add dx , [bx + si]
    mov bx , offset result
    mov [bx + si + 1] , dx
    
    inc cl
    inc si
    jmp in_put2
label12: 
    call new_line
    mov bx , offset arr2
    mov si , 0
    mov cl , 1
  
out_put2:
    cmp cl , 10
    jg jjj
      
    mov dx , [bx + si]
    mov total , dl
    call dec_out 
    call new_line
    
    inc cl 
    inc si
    jmp out_put2 
     

jjj:
    call new_line  
    mov bx , offset result
    mov si , 0
    mov cl , 1
  
out_put23:
    cmp cl , 10
    jg heere
      
    mov dx , [bx + si + 1]
    mov total , dl
    call dec_out 
    call new_line
    
    inc cl 
    inc si
    jmp out_put23  
heere:
    
    jmp fin_exit
    
main endp



  


;function to print newline

new_line proc 
    push dx
    mov dx,0ah
    mov ah,02h
    int 21h
    mov dx,0dh
    int 21h
    pop dx
    ret
    
    new_line endp


;function for decimal output
dec_out proc
    push bx 
    push cx
    push dx
    mov count,0
    mov dx,0
    mov ax,0
    mov al,total
    
    lab2:
        mov bl,10
        mov ah,0
        div bl
        
        mov dl,ah
        push dx
        inc count
        
        cmp al,0
        jne lab2
        
        
        mov cx,0
        mov dx,0
        mov cl,count
        
        l:
            pop dx
            add dl,'0'
            mov ah,02h
            int 21h
            loop l
            
        
        pop dx
        pop cx
        pop bx
        ret
    
    dec_out endp


;function for decimal input

dec_inp proc 
       push bx
       mov bx,0
       mov total,0
       mov ah,01
       int 21h
       
       lab:
            cmp al,0dh
            je exit
            sub al,'0'
            mov bl,al
            mov al,10
            mul total
            add al,bl
            mov total,al
            
            
            mov ah,01h
            int 21h
            jmp lab
            
       exit: 
       
       pop bx
       ret
    
    dec_inp endp 


fin_exit:

end main
    
