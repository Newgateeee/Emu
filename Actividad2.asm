CUADRO MACRO XI,YI,XF,YF,COLOR 
MOV AX, 0600H ;
MOV BH, COLOR ; COLOR DE FONDO Y LETRA

MOV CH, YI ; Y INICIAL
MOV CL, XI ; X INICIAL
MOV DH, YF ; Y FINAL
MOV DL, XF ; X FINAL
INT 10H
ENDM 

INT 10h

cuadro 0,0,113,41,00010001B ; Fondo de color azul.


; Dibujo de contornos y ojo
cuadro 7,1,9,1,00000000B 
cuadro 5,2,6,2,00000000B
cuadro 10,2,11,2,00000000B
cuadro 4,3,4,3,00000000B
cuadro 12,3,12,3,00000000B
cuadro 3,4,3,4,00000000B  
cuadro 13,4,13,4,00000000B 
cuadro 2,5,2,6,00000000B
cuadro 1,7,1,9,00000000B 
cuadro 2,10,2,11,00000000B  
cuadro 3,12,3,12,00000000B 
cuadro 4,13,4,13,00000000B 
cuadro 5,14,6,14,00000000B  
cuadro 5,2,6,2,00000000B
cuadro 7,15,9,15,00000000B  
cuadro 10,14,11,14,00000000B  
cuadro 12,13,12,13,00000000B 
cuadro 13,12,13,12,00000000B  
cuadro 14,11,14,11,00000000B
cuadro 12,10,13,10,00000000B 
cuadro 9,9,11,9,00000000B  
cuadro 7,8,8,8,00000000B 
cuadro 8,5,8,5,00000000B
cuadro 9,7,11,7,00000000B
cuadro 12,6,13,6,00000000B 
cuadro 14,5,14,5,00000000B 


;Relleno Amarillo
cuadro 7,2,9,2,11101111B 
cuadro 5,3,11,3,11101111B
cuadro 4,4,12,4,11101111B
cuadro 3,5,7,5,11101111B    
cuadro 9,5,13,5,11101111B  
cuadro 3,6,11,6,11101111B   
cuadro 2,7,8,7,11101111B   
cuadro 2,8,6,8,11101111B
cuadro 2,9,8,9,11101111B 
cuadro 3,10,11,10,11101111B  
cuadro 3,11,13,11,11101111B  
cuadro 4,12,12,12,11101111B 
cuadro 5,13,11,13,11101111B 
cuadro 7,14,9,14,11101111B
    
;Pelotita tiene dimensiones y = 8 a 9  aparece en x = 30 y  avanza  <- a la izquierda   
  

Macro movimiento

cuadro 30,8,31,9,11111111B ;Aparece pelotita 

;Movimiento pelotita 
cuadro 29,8,30,9,11111111B ;Mov
cuadro 31,8,31,9,00010001B ;limp
cuadro 28,8,29,9,11111111B ;Mov 
cuadro 30,8,30,9,00010001B ;limp
cuadro 27,8,28,9,11111111B ;Mov 
cuadro 29,8,29,9,00010001B ;limp   
cuadro 26,8,27,9,11111111B ;Mov 
cuadro 28,8,28,9,00010001B ;limp
cuadro 25,8,26,9,11111111B ;Mov 
cuadro 27,8,27,9,00010001B ;limp
cuadro 24,8,25,9,11111111B ;Mov 
cuadro 26,8,26,9,00010001B ;limp 
cuadro 23,8,24,9,11111111B ;Mov 
cuadro 25,8,25,9,00010001B ;limp 
cuadro 22,8,23,9,11111111B ;Mov 
cuadro 24,8,24,9,00010001B ;limp    
cuadro 21,8,22,9,11111111B ;Mov 
cuadro 23,8,23,9,00010001B ;limp        
cuadro 20,8,21,9,11111111B ;Mov 
cuadro 22,8,22,9,00010001B ;limp
cuadro 19,8,20,9,11111111B ;Mov 
cuadro 21,8,21,9,00010001B ;limp   
cuadro 18,8,19,9,11111111B ;Mov 
cuadro 20,8,20,9,00010001B ;limp 
cuadro 17,8,18,9,11111111B ;Mov
cuadro 19,8,19,9,00010001B ;limp
cuadro 16,8,17,9,11111111B ;Mov
cuadro 18,8,18,9,00010001B ;limp 
cuadro 15,8,16,9,11111111B ;Mov
cuadro 17,8,17,9,00010001B ;limp 
cuadro 14,8,15,9,11111111B ;Mov
cuadro 16,8,16,9,00010001B ;limp 
cuadro 13,8,14,9,11111111B ;Mov
cuadro 15,8,15,9,00010001B ;limp 

;Movimiento cerrar

cuadro 9,6,14,10,11101111B ; Amarillo  
cuadro 7,8,14,8,00000000B   ;Linea boca
cuadro 14,6,14,6,00000000B  ; Contornos
cuadro 14,10,14,10,00000000B
cuadro 15,7,15,9,00000000B

;Movimiento abrir

cuadro 9,8,15,8,00010001B ;limp
cuadro 12,7,14,9,00010001B ;limp
cuadro 14,6,15,10,00010001B ;limp 

cuadro 9,7,11,7,00000000B  ; Contornos
cuadro 9,9,11,9,00000000B  ; Contornos 
cuadro 12,6,13,6,00000000B  ; Contornos    
cuadro 12,10,13,10,00000000B  ; Contornos
                                 
endm
                               
movimiento
movimiento
movimiento
movimiento

