.MODEL SMALL
.STACK 100H
.DATA 
    
    P DB "ENTER A NUBER: $" , 0
    VAR DB 0
    
.CODE 
MAIN PROC  
     MOV AX , @DATA   
     MOV DS , AX
     MOV AH , 09
     LEA DX , P
     INT 21H
     
     MOV AH , 01
     INT 21H
     MOV VAR , AL
     SUB VAR , '0'
     MOV AH , 02H 
     MOV BL , 1
     
LE:
     
     MOV CL , BL
     ADD CL , '0' 
     MOV DL , CL
     INT 21H
     INC BL
     CMP BL , VAR
     JLE LE
     JMP LEND
     
    
    
    
LEND:    
 
MAIN ENDP
END MAIN



