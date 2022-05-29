.MODEL SMALL
.STACK 100H

.DATA
MSG1 DB 0DH, 0AH, 'SCALENE TRIANGLE $'
MSG2 DB 0DH, 0AH, 'EQUILATERAL TRIANGLE $'
MSG3 DB 0DH, 0AH, 'ISOSCELES TRIANGLE $'

.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
              
    MOV AH,1
    INT 21H
    
    MOV CL,AL
    INT 21H
    MOV BL,AL
    INT 21H
    
IF_1:
    CMP AL,BL
    JNE ELSE_1
    IF_2:
        CMP BL,CL
        JNE ELSE_2
        JMP EQUILATERAL
    ELSE_2:
        JMP ISOSCELES  
   
ELSE_1:
    IF_3:
        CMP BL,CL
        JNE ELSE_3
        JMP ISOSCELES
    ELSE_3:
        IF_4:
            CMP AL,CL
            JNE ELSE_4
            JMP ISOSCELES
        ELSE_4:
            JMP SCALENE

    
    
EQUILATERAL:
    MOV AH,9
    LEA DX,MSG2 
    INT 21H
    JMP END_

ISOSCELES:
    LEA DX,MSG3
    MOV AH,9
    INT 21H
    JMP END_

SCALENE:
    LEA DX,MSG1
    MOV AH,9
    INT 21H
           
END_:
    
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
END MAIN
    
    