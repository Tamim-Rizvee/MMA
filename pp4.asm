;Exam day in MIST is during Monday or 
;Thursday. Fun day is the day that comes right after the exam day. 
;Meanwhile other days are termed as Tiring day. Take a single digit
; numeric input for your day (from 1 to 7), and print which day it is.

.model small
.stack 100h
.data  

    inp     db "Enter a day: $"  
    exam    db 0dh,0ah,"Exam day.$"
    fun     db 0dh,0ah,"Fun day.$"
    tiring  db 0dh,0ah,"Tiring day.$"

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
    mov cl , al
    
    cmp cl , 2
    je  l1s
    cmp cl , 5
    je  l1s
    jmp l1e
    
l1s:
    mov ah , 09h
    lea dx , exam
    int 21h
    jmp l3

l1e:
    cmp cl , 3
    je  l2s
    cmp cl , 6
    je  l2s
    jmp l2e
l2s:
    mov ah , 09h
    lea dx , fun
    int 21h
    jmp l3
l2e:
    mov ah , 09h
    lea dx , tiring
    int 21h
l3:
    
    main endp
end main