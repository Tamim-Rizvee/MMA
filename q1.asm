.MODEL SMALL
.STACK 100H
.DATA 

    INP     DB 0DH,0AH,"Enter the value of  X: $"
    NUMBER  DB 0DH,0AH,"Given input is a number.$"   
    VOWEL   DB 0DH,0AH,"Given input is a vowel>$"
    CONST   DB 0DH,0AH,"Given input is a consonant.$"
    INVAL   DB 0DH,0AH,"Invalid input.$"
    CONT    DB 0DH,0AH,"Do you want to continue(Y/N)?$"
    DELIM   DB 0DH,0AH 
    CHAR    DB ?
    CCHAR   DB ?

.CODE

MAIN PROC
    MOV AX , @DATA
    MOV DS , AX
   
START:
    MOV AH , 09H
    LEA DX , INP
    INT 21H
    
    MOV AH , 01H
    INT 21H   
    MOV CHAR , AL
    
    CMP CHAR , '0'
    JL  CHAR_CMP
    CMP CHAR , '9'
    JG  CHAR_CMP 
    JMP PRINT_NUM  
    
    
CHAR_CMP:
    CMP CHAR , 'A'
    JL  PRINT_INVALID
    CMP CHAR , 'Z'
    JG  PRINT_INVALID
    
    CMP CHAR , 'A' 
    JE  PRINT_VOWEL
    CMP CHAR , 'E' 
    JE  PRINT_VOWEL
    CMP CHAR , 'I'
    JE  PRINT_VOWEL
    CMP CHAR , 'O' 
    JE  PRINT_VOWEL
    CMP CHAR , 'U' 
    JE  PRINT_VOWEL    
    
    JMP PRINT_CONSONANT
    
    
    
    
PRINT_VOWEL:
    MOV AH , 09H
    LEA DX , VOWEL
    INT 21H
    JMP ASK_AGAIN
    
PRINT_CONSONANT:
    MOV AH , 09H
    LEA DX , CONST
    INT 21H
    JMP ASK_AGAIN
    



PRINT_INVALID: 
    MOV AH , 09H
    LEA DX , INVAL
    INT 21H
    JMP ASK_AGAIN    


PRINT_NUM:
    MOV AH , 09H
    LEA DX , NUMBER
    INT 21H
    JMP ASK_AGAIN
    
ASK_AGAIN: 
    MOV AH , 09H
    LEA DX , CONT
    INT 21H
    
    MOV AH , 01H
    INT 21H
    MOV CCHAR , AL
    CMP CCHAR , 'Y'
    JE  START
    CMP CCHAR , 'N'
    JE  ENDING
    JMP ASK_AGAIN
    
    
    
    
    
    
    

ENDING:
    
    MAIN ENDP
END MAIN