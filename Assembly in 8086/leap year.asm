.MODEL SMALL
.STACK 100H

.DATA
LEAP DB 0DH, 0AH, 'LEAP YEAR $'
NOT_LEAP DB 0DH, 0AH, 'NOT A LEAP YEAR $'
X DB ?
MSG DB 0DH, 0AH, 'THIS LINE DID NOT EXECUTE$'
N DW ?
CR EQU 0DH
LF EQU 0AH


.CODE

MAIN PROC
MOV AX, @DATA
    MOV DS, AX
    
    ; fast BX = 0
    XOR BX, BX
    
    INPUT_LOOP:
    ; char input 
    MOV AH, 1
    INT 21H
    
    ; if \n\r, stop taking input
    CMP AL, CR    
    JE END_INPUT_LOOP
    CMP AL, LF
    JE END_INPUT_LOOP
    
    ; fast char to digit
    ; also clears AH
    AND AX, 000FH
    
    ; save AX 
    MOV CX, AX
    
    ; BX = BX * 10 + AX
    MOV AX, 10
    MUL BX
    ADD AX, CX
    MOV BX, AX
    JMP INPUT_LOOP
    
    END_INPUT_LOOP:
    MOV N, BX
    
    ; printing CR and LF
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV DL, LF
    INT 21H
    
    
    ;------------------------------------
    ; start from here
    ; input is in N
    
    
    MOV DX,0
    MOV BX, 400
    MOV AX,N
    
    DIV BX
IF:    
    CMP DX,0
    JE LEAP_YEAR
    
ELSE_IF:
    MOV AH,0
    MOV DX,0
    MOV BX,100
    MOV AX,N
    
    DIV BX
    CMP DX,0
    JE NOT_LEAP_YEAR
    MOV AH,0
    MOV DX,0
    MOV AX,N
    MOV BX,4
    
    DIV BX
    CMP DX,0
    JNE NOT_LEAP_YEAR
    
LEAP_YEAR:
    MOV AH,9
    LEA DX, LEAP
    INT 21H
    JMP END_MAIN

NOT_LEAP_YEAR:
    MOV AH,9
    LEA DX, NOT_LEAP
    INT 21H
    
END_MAIN:  

    MOV AH, 4CH
    INT 21H

    MAIN ENDP
END MAIN