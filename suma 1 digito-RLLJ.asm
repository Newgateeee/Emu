 ;Suma en ensamblador
 
   .MODEL TINY 
   .STACK
   .DATA  
   
   M2 DB '+$'
   M3 DB '=$'
   
   .CODE
   MOV CX,2
   MOV SI,0
   
   DATA:
   MOV AH,9H
   CMP SI,1H
   JB SIG
   
   LEA DX, M2
   INT 21H
   
   SIG:
   INC SI
   MOV AH, 1H 
   int 21h
   PUSH AX
   LOOP DATA
   
   SUMA:
   MOV AH,9H
   LEA DX,M3
   INT 21H
   POP AX
   POP BX
   SUB AL,30H
   SUB BL,30H
   ADD AL,BL
   AAM
   XOR DX,DX
   MOV DL,AH
   MOV BL,AL
   ADD AL,BL
   MOV AH,02H
   INT 21H
   MOV DL,BL
   ADD DL,30H
   MOV AH,06H
   INT 21H
   RET
   END 