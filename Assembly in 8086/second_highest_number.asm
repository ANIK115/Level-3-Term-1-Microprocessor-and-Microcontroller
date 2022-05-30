.MODEL SMALL
.STACK 100H

.DATA

MSG DB 0DH, 0AH, 'ALL THE NUMBERS ARE EQUAL$'
NEWLINE DB 0DH,0AH,'$'
X DB ?

.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH,1
    INT 21H
    MOV BL,AL
    INT 21H
    MOV CL,AL
    INT 21H
    
    MOV X,AL
    MOV AH,9
    LEA DX,NEWLINE
    INT 21H
    MOV AL,X
    
    CMP AL,BL               ; checking if AL = BL
    JNE BL_GREATER_THAN_CL  ; AL is not equal to BL, so move to next step
    CMP BL,CL               ; this line executes if AL=BL
    JE ALL_EQUAL            ; if BL = CL, then all are equal now
    
BL_GREATER_THAN_CL: ;all numbers are not equal
    CMP BL,CL
    JG IF
    MOV X,BL
    MOV BL,CL
    MOV CL,X        ;comparing BL and CL and storing the higher one to BL and lower one to CL
IF:
    CMP AL,BL
    JL CHECK_AL_CL    ;if AL < BL then AL or CL is the second highest number. go to check_AL_CL
    JE MOV_CL       ;else if AL = BL then CL is the second highest number as previously all numbers are not equal and BL > CL
    MOV AL,BL       ;else BL < AL, so BL is second highest. move it to AL
    JMP SECOND_AL
    
CHECK_AL_CL:
    CMP AL,CL
    JGE SECOND_AL

MOV_CL:
    MOV AL,CL       ;storing the 2nd highest number to AL from CL
    
SECOND_AL:          ; then 2nd highest number is stored in AL
    MOV DL,AL
    MOV AH,2
    INT 21H
    JMP END_MAIN
    

    

ALL_EQUAL:

    MOV AH,9
    LEA DX,MSG
    INT 21H
END_MAIN:
    
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
END MAIN
    
    