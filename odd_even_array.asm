;linear search



.model small
.stack 100h
.data 
     
    ;arr     db 0 ,1 , 2 , 3 , 4 , 5, 6 , 7, 8 , 9 
    arr     db 10 dup(?)
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
    
    ;enter array elements  
    ;call dec_inp
;    call new_line
;    call dec_out
    
   
    
;printing a single elememnt 
    ;mov cl , arr[5]
;    mov total , cl
;    call dec_out
   
    
    
    
;printing array elements
    mov bx , offset arr ;base address stored in the bx
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
    mov bx , offset arr
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
    
     call odd_even

    
    
    jmp fin_exit
    
main endp

;function for searching
search proc 
    push bx
    push cx
    mov bx , offset arr
    mov si , 0
    mov cl , 1 
    
searching: 
    cmp cl , 10
    jg  n_fun
               
    mov dx , 0
    mov dx , [bx + si]
               
    cmp key , dl
    je fun
    
    inc si
    inc cl
    jmp searching
n_fun: 
    call new_line
    mov ah , 09h
    lea dx , n_found
    int 21h 
    jmp here
fun:
    call new_line
    mov ah , 09h
    lea dx , found
    int 21h
        
here:        
    pop cx 
    pop bx
    ret
    
    search endp

;fucntion for odd_even check

odd_even proc 
    push bx
    push cx
    push dx
    
    mov bx , offset arr
    mov cl , 1
    mov si , 0
find:
    cmp cl , 10
    jg  label2
    
    mov dx , [bx + si]
    and dx , 1
    cmp dx , 0
    je  even_count_increase
    jmp odd_count_increase
    
   ekhane:
   
      inc cl
      inc si
      jmp find
      
      
even_count_increase:
    inc even_n
    jmp ekhane
    
odd_count_increase:
    inc odd_n
    jmp ekhane
    
label2: 
    mov ch , odd_n
    cmp ch , even_n
    jg evnnn
    jl evn
    jmp hhh
    
evnnn:
    call odd_print 
    jmp endi
evn:
    call even_print
    jmp endi
    
hhh:
    call same_print
endi:
    
    pop dx
    pop cx
    pop bx
    ret
    
    
    odd_even endp  


odd_print proc 
    push dx
    mov ah , 09h
    lea dx , odd
    int 21h
    pop dx
    ret
    odd_print endp 

even_print proc
    push dx 
    mov ah , 09h
    lea dx , even
    int 21h
    pop dx
    ret
    even_print endp 

same_print proc 
    push dx 
    mov ah , 09h
    lea dx , sameen
    int 21h
    pop dx
    ret
    
    same_print endp


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
    
