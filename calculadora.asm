limpant     MACRO                       
            mov AH, 0Fh                 ;Funcion 0F(Modo de video).
            int 10h                     ;De la interrupcion 10h.
            mov AH, 0                   ;Funcion 0 (cambia el modo de video).
            int 10h                     ;De la interrupcion 10h.
endm                                    ;Fin de macro

imprime     MACRO cadena                
	    lea DX, cadena              ;Asigna cadena a DX
	    mov AH, 09                  ;Funcion 09 de la int 21 para... 
	    int 21h                     ;...imprimir una cadena de caracteres
endm                                    ;Fin de macro

scand       MACRO                       
            mov AH, 01                  ;y lo guarda en AL
            int 21h                     ;
endm                                    ;Fin de macro

restR       MACRO                       ;Macro que restituye AX, BX, CX y DX
	    sub AX, AX                  ;Restituye AX
	    sub BX, BX                  ;Restituye BX
            sub CX, CX                  ;Restituye CX
            sub DX, DX                  ;Restituye DX
endm                                    ;Fin de macro

restV       MACRO                       
                                        
                                        ;Variables de A
            mov alto1A, 0               ;Restituye alto1A
            mov alto2A, 0               ;Restituye alto2A
            mov bajo1A, 0               ;Restituye bajo1A
            mov bajo2A, 0               ;Restituye bajo2A
            mov signoA, 0               ;restituye signoA 
            
                                        ;Variables de B
            mov alto1B, 0               ;Restituye alto1B
            mov alto2B, 0               ;Restituye alto2B
            mov bajo1B, 0               ;Restituye bajo1B
            mov bajo2B, 0               ;Restituye bajo2B
            mov signoB, 0               ;Restituye signoB
            
            mov carry, 0                ;Restituye carry 
            
            mov dive1, 0                ;Restituye Decena auxiliar --
            mov dive2, 0                ;Restituye Unidad auxiliar   |   
            mov divd1, 0                ;Restituye Decima auxiliar   |   
            mov divd2, 0                ;Restituye Unidad auxiliar    > para division  
                                        ;                            |
            mov residuo, 0              ;Restituye residuo           |  
            mov divisor, 0              ;Restituye divisor         --
            
            mov a,0                    
            mov b,0                    
            mov c,0                     
            mov d,0                    
            mov e,0                   
            mov f,0                    
            mov g,0                     
            mov h,0                     
            mov i,0                     
            mov j,0                     
            mov k,0                     
            mov l,0                     
            mov m,0                 
            mov n,0                     
            mov o,0                     
            mov p,0                   
            mov q,0                    
            mov r,0                    
            mov s,0                     
            mov t,0                   
            mov aux,0                   
            
            
            
endm                                    
piddatoA    MACRO                       
            restR                       ;Restituye registros
            
enteroA:                                ;Inicia enteroA
            scand                       ;Macro scand
            cmp AL, 2Eh                 ;Compara con punto decimal (.)            
            je  decimal1A               ;Si hay punto, salta a decimal1A 
            
            cmp AL, 2Dh                 ;Compara con signo negativo (-)
            je  sigA                    ;Si hay signo, salta a sigA
            cmp AL, 0Dh                 ;Compara si hay Enter
            je  unidA                   ;Si hay Enter, salta a unidA
            
            push AX                     ;Mete el valor a la pila
            
            inc CX                      ;Incrementa (CX+1)
            
            jmp enteroA                 ;Salta a enteroA
            
decimal1A:                              ;Inicia decimal1A
            scand                       ;Macro scand
            
            cmp AL, 0Dh                 ;Compara si hay Enter
            je  unidA                   ;Si hay Enter, salta a unidA
            
            cmp DL, 01                  ;Verifica contador
            je  decimal2A               ;Si DL = 01, salta a decimal2A
            
            mov bajo1A, AL              ;AL --> bajo1A
            inc DL                      ;Incrementa contador DL            
            jmp decimal1A               ;Salta a decimal1A

decimal2A:                              ;Inicia decimal12A
            mov bajo2A, AL              ;AL --> bajo2A
            jmp unidA                   ;Salta a unidA

sigA:                                   ;Inicia sigA
            inc signoA                  ;signoA a 1 para determinar el valor como negativo
            jmp enteroA                 ;Salta a enteroA
            
unidA:                                  ;Inicia unidA
            cmp CX, 0                   ;Verifica CX
            je  pfinA                   ;Si CX = 0, salta a pfinA
            
            pop DX                      ;Valor en pila a DX
            mov alto2A, DL              ;DL --> alto2A
            
            dec CX                      ;decrementa (CX-1)
            
            cmp CX, 0                   ;Verifica CX
            je  pfinA                   ;Si CX = 0, salta a pfin
            
            pop DX                      ;Valor en pila a DX
            mov alto1A, DL              ;DL --> alto1A
            
pfinA:                                  ;Inicia pfinA
            restR                       ;Restituye registros
endm                                    ;Fin macro

piddatoB    MACRO                       ;Macro para dato B 
            restR                       ;Restituye registros
            
enteroB:                                ;Inicia enteroB
            scand                       ;Macro scand
            cmp AL, 2Eh                 ;Compara con punto decimal (.)            
            je  decimal1B               ;Si hay punto, salta a decimal1B 
            
            cmp AL, 2Dh                 ;Compara con signo negativo (-)
            je  sigB                    ;Si hay signo, salta a sigB
            cmp AL, 0Dh                 ;Compara si hay Enter
            je  unidB                   ;Si hay Enter, salta a unidB
            
            push AX                     ;Mete el valor a la pila
            
            inc CX                      ;Incrementa contador CX
            
            jmp enteroB                 ;Salta a enteroB
            
decimal1B:                              ;Inicia decimal1B
            scand                       ;Macro scand
            
            cmp AL, 0Dh                 ;Compara si hay Enter
            je  unidB                   ;Si hay Enter, salta a unidB
            
            cmp DL, 01                  ;Verifica contador
            je  decimal2B               ;Si DL = 01, salta a decimal2B
            
            mov bajo1B, AL              ;AL --> bajo1B
            inc DL                      ;Incrementa contador DL            
            jmp decimal1B               ;Salta a decimal1B

decimal2B:
            mov bajo2B, AL              ;AL --> bajo2B
            jmp unidB                   ;Salta a unid

sigB:                                   ;Inicia sigB
            inc signoB                  ;SignoB a 1 para determinar el valor como negativo
            jmp enteroB                 ;Salta a enteroB
            
unidB:                                  ;Inicia unidB
            cmp CX, 0                   ;Verifica CX
            je  pfinB                   ;Si CX = 0, salta a pfinB
            
            pop DX                      ;Valor en pila a DX
            mov alto2B, DL              ;DL --> alto2B
            
            dec CX                      ;decrementa contador CX
            
            cmp CX, 0                   ;Verifica CX
            je  pfinB                   ;Si CX = 0, salta a pfinB
            
            pop DX                      ;Valor en pila a DX
            mov alto1B, DL              ;DL --> alto1B
            
pfinB:                                  ;Inicia pfinB
            restR                       ;Restituye registros
endm                                    ;Fin de macro


SUMAR       MACRO SNA,SNB               
            sub SNA, 30h		;Ajuste decimal
	    sub SNB, 30h		;Ajuste decimal
            MOV AL,SNA                  ;SNA -> AL
            MOV AH,00                   ;restituye ah
            ADD AL,SNB                  ;suma SNB con AL
	    ADD AL, carry               ;suma acarreo a AL
            AAM                         ;Ajusta resultado 
            MOV carry, AH               ;Guarda acarreo
            mov AH, 00                  ;restituye AH
ENDM                                    ;Fin de macro

RESTAR      MACRO RNA,RNB               
            
            MOV AL, RNA                 ;RNA -> AL
            MOV AH, 00                  ;Restituye AH
            ADD AL, carry               ;Suma acarreo a AL
            SUB AL, RNB                 ;Resta AL de RNB
            AAS                         ;Ajuste 
            MOV carry, AH               ;Guarda acarreo
            mov AH, 00                  ;Restituye AH
                        
ENDM                                    ;Fin de macro

multiplicar MACRO MNA,MNB               
                                        
            mov ah,00                   ;Restituye AH
            mov Al, MNA                 ;Asigna MNA a AL
            sub AL, 30h                 ;Suma 30h en AL 
            mov CH, MNB                 ;Asigna MNB en CH
            sub CH, 30h                 ;Suma 30h en CH
            mul CH                      ;Multiplica (CH x AL)
            aam                         ;Desempaca/Ajusta
            mov carry,ah                ;Guarda acarreo                                        
ENDM                                    ;Fin macro

ajustemul   MACRO  V1, V2                
            
            add al, V1                  ;V1 + AL (v1 = resultado mul)
            add V2,ah                   ;V2 + AH (v2 = resultado sigmul)
            mov ah, 00                  ;Restituye AH
            aam                         ;Desempaca/Ajusta
            mov V1, al                  ;Al --> V1
            add V2, ah                  ;AH --> V2
ENDM                                    ;Fin de macro

sumamulc    MACRO SMCA,SMCB             
    
            mov ah,0                    ;Restituye AH
            mov al,SMCA                 ;Asigna SMCA a AL
            add al,SMCB                 ;SMCB + SMCA
            aam                         ;Desempaca/Ajusta, resultado
            mov dl,ah                   ;Asigna AH en DL
            mov ah, 00                  ;Restituye AH            
ENDM                                    ;Fin macro
                                        
enmascm     MACRO                       
                                      
            
            or alto1A, 30h              ;Alto1A a ascii
            or alto2A, 30h              ;Alto2A a ascii
            or bajo1A, 30h              ;Bajo1A a ascii
            or bajo2A, 30h              ;Bajo2A a ascii
            
            or alto1B, 30h              ;Alto1B a ascii
            or alto2B, 30h              ;Alto2B a ascii
            or bajo1B, 30h              ;Bajo1B a ascii
            or bajo2B, 30h              ;Bajo2B a ascii
ENDM                                    ;Fin macro 

anddivi     MACRO                       
    
                                       
                                        
            and dive1, 0Fh              ;Ajusta dive1 a Decimal
            and dive2, 0Fh              ;Ajusta dive2 a Decimal
            and divd1, 0Fh              ;Ajusta divd1 a Decimal
            and divd2, 0Fh              ;Ajusta divd2 a Decimal

ENDM     

moverV      MACRO valor                 
    
            sub AH, AH                  ;Restituye AH
            mov AL, dive1               ;dive1 -> AL
            mul mil                     ;Convierte a millar
            mov valor, AX               ;AX -> valor
            
            sub AH, AH                  ;Restituye AH
            mov AL, dive2               ;dive2 -> AL
            mul cien                    ;Convierte a centena
            add valor, AX               ;valor + AX
            
            sub AH, AH                  ;Restituye AH
            mov AL, divd1               ;divd1 -> AL
            mul diez                    ;Convierte a decena
            add valor, AX               ;valor + AX
            
            sub AH, AH                  ;Restituye AH
            mov AL, divd2               ;divd2 -> AL
            add valor, AX               ;valor + AX
            
ENDM  

enmascd     MACRO                       
    
                                        
            
            or dive1, 30h               ;Ajusta dive1 a ASCII
            or dive2, 30h               ;Ajusta dive2 a ASCII
            or divd1, 30h               ;Ajusta divd1 a ASCII
            or divd2, 30h               ;Ajusta divd2 a ASCII
            
            or alto1B, 30h              ;Ajusta a ASCII
            or alto2B, 30h              ;Ajusta a ASCII
            or bajo1B, 30h              ;Ajusta a ASCII
            or bajo2B, 30h              ;Ajusta a ASCII
  
ENDM

            .model small                
            .stack 128                  
            
            
            .data
            
            ;Definicion de cadenas de caracteres
            ;-----------------------------------
menumsj     db 13, 10, 09, 09, 'CALCULADORA U3', 13, 10
            db 13, 10, 09, 09, ' 1.- Suma'
            db 13, 10, 09, 09, ' 2.- Resta'
            db 13, 10, 09, 09, ' 3.- Division'
            db 13, 10, 09, 09, ' 4.- Multiplicacion'
            db 13, 10, 09, 09, ' 5.- Salir', 13, 10, '$'
pdatoA      db 13, 10, 'Introduzca su primero valor: $'
pdatoB      db 13, 10, 'Introduzca su segundo valor: $'
opmenu      db 13, 10, 10, 09, 09, 'Seleccione una operacion: $' 
retmenu     db 13, 10,10, ' Deseas continuar?'
            db 13, 10, ' 1.- Si'
            db 13, 10, ' 2.- No'
            db 13, 10, 09, 'Seleccione una Operacion: $'
erro        db 13, 10, 10, 10, 09, 09, 'OPCION INCORRECTA, INTENTELO DE NUEVO$',13, 10
smsj        db 13, 10, 09, 09, 09, 09, 'SUMA$'
rmsj        db 13, 10, 09, 09, 09, 09, 'RESTA$'
dmsj        db 13, 10, 09, 09, 09, 09, 'DIVISION$'
mmsj        db 13, 10, 09, 09, 09, 09, 'MULTIPLICACION$'
resul       db 13, 10, 10, 09, 09, 'El resultado es:    $'
despe       db 13, 10, 09, ' Fin del programa. Adios.$' 
indeter     db 'ERROR. DIVISION NO VALIDA$'
negativo    db '-$'
punto       db '.$'

            ;Definicion de variables 
            ;-----------------------
                                        ;Variables para numero A
                                                                
alto1A      db 00                       ;Decenas de A
alto2A      db 00                       ;Unidades de A
bajo1A      db 00                       ;Decimas de A
bajo2A      db 00                       ;Centesimas de A
signoA      db 00                       ;Signo para A
              
                                        ;Variables para numero B
                                        
alto1B      db 00                       ;Decenas de B
alto2B      db 00                       ;Unidades de B
bajo1B      db 00                       ;Decimas de B 
bajo2B      db 00                       ;Centesimas de B
signoB      db 00                       ;Signo para B 

dive1       db 00                       ;Decena auxiliar --
dive2       db 00                       ;Unidad auxiliar   \ Para
divd1       db 00                       ;Decima auxiliar   / division
divd2       db 00                       ;Unidad auxiliar --  

residuo     dw 0000                     ;Residuo para decimales
divisor     dw 0000                     ;Residuo decimales
diezw       dw 0010                     ;x residuo para decimal
mil         dw 1000                     ;x decena residuo = quita '.'
cien        db 100                      ;x unidad residuo = quita '.' 
diez        db 10                       ;x decima residuo = quita '.' 

carry       db 00                       ;Variable para acarreo

a           db 00                       
b           db 00                       
c           db 00                       
d           db 00                       
e           db 00                       
f           db 00                      
g           db 00                     
h           db 00                      
i           db 00                      
j           db 00                      
k           db 00                       
l           db 00                       
m           db 00                       
n           db 00                      
o           db 00                       
p           db 00                       
q           db 00                      
r           db 00                     
s           db 00                       
t           db 00                      
aux         db 00                      

            .code
inicia:                                 ;Inicia programa
            mov AX, @data               ;datos --> AX
            mov DS, AX                  ;AX --> DS
             
            call MENU                   ;Llama a la rutina MENU
fin:                                    ;Inicia fin
            mov AX, 4Ch                 ;Regresa control al DOS
            int 21h                     ;interrupcion de DOS.
                          
MENU        proc                        ;incia procedimiento menu
            
            limpant                     ;Limpia pantalla
            
            imprime menumsj             ;Despliega el menu
            
            imprime pdatoA              ;Pide primer numero 
            piddatoA                    ;Macro guarda valores 
                        
            imprime pdatoB              ;Pide segundo numero 
            piddatoB                    ;Macro guarda valores 
            
 	    enmascm			;Enmascara A y B

            imprime opmenu              ;Pide la operacion a realizar
            scand                       ;inicia macro scand
                        
            cmp AL, '1'                 ;Compara AL con '1'
            je  SUMA                    ;Salta a SUMA
            cmp AL, '2'                 ;Compara AL con '2'
            je  RESTAe                   ;Salta a RESTA
            cmp AL, '3'                 ;Compara AL con '3'
            je  DIVIe                    ;Salta a DIVI
            cmp AL, '4'                 ;Compara AL con '4'
            je  MULTIe                   ;Salta a MULTI
            cmp AL, '5'                 ;Compara AL con '5'
            je  SALIRe                   ;Salta a SALIR
            
            cmp AL, 00                  ;Compara AL con 0
            jne ERRORe                   ;Salta a error 
                                   
restae:
	    jmp RESTA
divie:
            jmp DIVI
multie:
	    jmp MULTI
salire:
            jmp SALIR
errore:
	    jmp ERROR

            RET                         ;Regresa a call MENU
MENU        endp                        ;Fin de procedimiento
                       
                             
                             
            
SUMA        proc                         
    
            limpant                     ;Limpia pantalla
            imprime smsj                ;Imprime "SUMA"
            
            imprime resul               ;imprime resultado
            
            cmp signoA, 01              ;Analiza si numA es negativo
            je  SAneg                   ;Si lo es, salta a SAneg 
            
            cmp signoB, 01              ;Analiza si numB es negativo
            je  SBneg                   ;Si lo es, salta a SBneg 
            
            jmp su                      ;Salta a su
                       
            
SAneg:                                  ;Inicia SAneg
            cmp signoB, 01              ;Analiza si numB es negativo 
            je  SABneg                  ;Si lo es, salta a SABneg 
            
            jmp RABneg                  ;Salta a -xx.xx + xx.xx
            
SABneg:                                 ;Inicia SABneg
            imprime negativo            ;Imprime "-"
            jmp su                      ;Salta a su

SBneg:                                  ;Inicia SBneg

            jmp re                      ;Salta a re
            
su:                                     ;Inicia su
            
            sumar bajo2A, bajo2B        ;Suma (bajo2A + bajo2B)
            push AX                     ;Resultado a pila
            sumar bajo1A, bajo1B        ;Suma (bajo1A + bajo1B)
            push AX                     ;Resultado a pila
            sumar alto2A, alto2B        ;Suma (alto2A + alto2B)
            push AX                     ;Resultado a pila
            sumar alto1A, alto1B        ;Suma (alto1A + alto1B)
            push AX                     ;Resultado a pila
            
            mov  CX, 02                 ;Contador antes del punto
            
           
sufinp:                                 ;Inicia sufinp
            pop DX                      ;Extrae valor de pila 
            add DL, 30h                 ;Ajusta DL
            mov AH, 02                  ;Funcion 02...
            int 21h                     ;Imprime valor
            loop sufinp                 ;Retorna a sufinp
      
            imprime punto               ;Imprime punto  XX.
            
            mov CX, 02                  ;Contador para decimales 
              
sufip:                                  ;Inicia sufip
            pop DX                      ;Imprime decimales .XX
            add DL, 30h                 ;Ajusta DL
            mov AH, 02                  ;Funcion 02
            int 21h                     ;Imprime valor
            loop sufip                  ;Retorna a sufip
           
            restV                       ;Restituye variables
            restR                       ;Restituye registros
                                    
            imprime retmenu             ;Imprime retmenu
            scand                       ;Pide dato de opcion
            cmp AL, '1'                 ;Compara AL con '1'
            je  MENUe                    ;Salta a MENU
            cmp AL, '2'                 ;Compara AL con '2'
            je  SALIRe2                   ;Salta a SALIR

menue:
		jmp MENU
salire2: 
		jmp SALIR            
SUMA        endp                        
                      
                             
            
RESTA       proc near                      
    
            limpant                     ;Limpia pantalla.
            imprime rmsj                ;Imprime mensaje 'RESTA'.
            
            imprime resul               ;imprime resul.  
            
            cmp signoA, 01              ;Analiza si numA es negativo.
            je  RAneg                   ;Si lo es, salta a RAneg.
            cmp signoB, 01              ;Analiza si numB es negativo.
            je  ree                     ;Si lo es, salta a RBneg.
            
            jmp RBneg                   ;salta a resta xx.xx - xx.xx.
ree:
	    jmp re
            
RAneg:                                  ;Inicia RAneg
            cmp signoB, 01              ;Analiza si numB es negativo.
            je  SABnege                 ;Si lo es, salta a - xx.xx - (- xx.xx). 
            
            jmp RABneg                  ;Salta - xx.xx - xx.xx.
SABnege:
	    jmp SABneg
            
RBneg:                                  ;Inicia RBneg
            jmp su                      ;Salta xx.xx - (- xx.xx). 

RABneg:                                 ;Comienza operacion - xx.xx - (- xx.xx).
            mov DL, alto1B              ;Asigna alto1b a DL.
            cmp alto1A, DL              ;Compara alto1A con alto1B.
            ja  mayorA                  ;Salta a resta mayorA.
            jb  mayorBe                 ;Salta a resta mayorB.
            
            mov Dl, alto2B              ;Asigna alto2B a DL.
            cmp alto2A, DL              ;Compara alto1A con alto1B.
            ja  mayorA                  ;Salta a resta mayorA.
            jb  mayorB                  ;Salta a resta mayorB.
            
            mov DL, bajo1B              ;Asigna bajo1B a DL.
            cmp bajo1A, DL              ;Compara bajo1A con bajo1B.
            ja  mayorA                  ;Salta a resta mayorA.
            jb  mayorB                  ;Salta a resta mayorB.
	    
	    mov DL, bajo2B
	    cmp bajo2A, DL
            ja  mayorA                  ;Salta a resta mayorA.
            jb  mayorB                  ;Salta a resta mayorB.
            
            jmp mayorB                  ;Salta a procedimeinto mayorB.
mayorBe:
	    jmp mayorB
            
mayorA:                                 ;Inicia operacion A-B. 

            imprime negativo            ;imprime signo "-".
            
            restar bajo2A, bajo2B       ;inicia la macro restar.
            push AX                     ;Resultado a pila.
            restar bajo1A, bajo1B       ;inicia la macro restar.
            push AX                     ;Resultado a pila.
            restar alto2A, alto2B       ;inicia la macro restar.
            push AX                     ;Resultado a pila.
            restar alto1A, alto1B       ;inicia la macro restar.
            push AX
            
            jmp resf                    ;Salta a resf.
            
mayorB:                                 ;inicia resta B-A.
            
            restar bajo2B, bajo2A       ;inicia macro restar.
            push AX                     ;Resultado a pila.
            restar bajo1B, bajo1A       ;inicia macro restar.
            push AX                     ;Resultado a pila.
            restar alto2B, alto2A       ;inicia macro restar.
            push AX                     ;Resultado a pila.
            restar alto1B, alto1A       ;inicia macro restar.
            push AX                     ;Resultado a pila.
            
            jmp resf                    ;salta a resf.
       
       
re:                                     ;inicia A>B o B>A.
	        mov DL, alto1B              ;Asigna alto1B a DL.   
            cmp alto1A, DL              ;compara Alto1A con Alto1B.
            ja  mayorAA                 ;Salta a resta mayorAA. 
            jb  mayorBB                 ;Salta a resta mayorBB.
            
            mov Dl, alto2B              ;Asigna alto2B a DL.
            cmp alto2A, DL              ;Compara alto2B con alto2A.
            ja  mayorAA                 ;salta a resta mayorAA.
            jb  mayorBB                 ;salta a resta mayorBB.
            
            mov DL, bajo1B              ;Asigna bajo1B a DL.
            cmp bajo1A, DL              ;Compara bajo1A con bajo1B.
            ja  mayorAA                 ;Salta a resta mayor AA.
            jb  mayorBB                 ;Salta a resta mayor BB.
            
	        JMP MAYORAA                 ;Salta a resta mayorAA.   

mayorAA:                                ;Inicia resta mayorAA.

            
            restar bajo2A, bajo2B       ;Inicia macro restar.
            push AX                     ;Resultado a pila.
            restar bajo1A, bajo1B       ;Inicia macro restar.
            push AX                     ;Resultado a pila.
            restar alto2A, alto2B       ;Inicia macro restar.
            push AX                     ;Resultado a pila.
            restar alto1A, alto1B       ;Inicia macro restar.
            push AX                     ;Resultado a pila.
            
            jmp resf                    ;Salta a resf. 
            
mayorBB:                                ;Inicia mayorBB.
	    imprime negativo                ;Imprime "-".
            
            restar bajo2B, bajo2A       ;Inicia macro restar.
            push AX                     ;Resultado a pila.
            restar bajo1B, bajo1A       ;Inicia macro restar.
            push AX                     ;Resultado a pila.
            restar alto2B, alto2A       ;Inicia macro restar.
            push AX                     ;Resultado a pila.
            restar alto1B, alto1A       ;Inicia macro restar.
            push AX                     ;Resultado a pila.
            
            jmp resf                    ;Salta a resf


resf:                                   ;incia resf

            mov  CX, 02                 ;Contador de variables.
            
           
refinp:                                 ;Inicia refinp
            pop DX                      ;Extrae valor a DX 
            add DL, 30h                 ;Restituye DL
            mov AH, 02                  ;Funcion 02
            int 21h                     ;Imprime valor
            loop refinp                 ;Regresa a refinp
      
            imprime punto               ;Imprime punto  XX.
            
            mov CX, 02                  ;Contador para variables
              
refip:                                  ;Inicia refip
            pop DX                      ;Imprime decimales .XX
            add DL, 30h                 ;Restituye DL
            mov AH, 02                  ;Funcion 02
            int 21h                     ;Imprime valor
            loop refip                  ;Regresa a refip
           
            restV                       ;Restituye variables
            restR                       ;Restituye registros            
                        
            
            
            imprime retmenu             ;Imprime retmenu
            scand                       ;Pide dato de opcion
            cmp AL, '1'                 ;Compara AL con '1'
            je  MENUe2                    ;Salta a MENU
            cmp AL, '2'                 ;Compara AL con '2'
            je  SALIRe3                   ;Salta a SALIR
menue2:
		jmp MENU
salire3:
		jmp SALIR
            
RESTA       endp                        
            
                                
                                        
           
            

DIVI        proc near                   ;Inicia procedimiento DIVI
            
            limpant                     ;Limpia pantalla   
            imprime dmsj                ;Imprime mensaje 'DIVISION'
            
            imprime resul               ;imprime resul
            

            
            mov AL, alto1B             
            mov dive1, AL                  
                                        
            mov AL, alto2B              
            mov dive2, AL              
                                        ;<  Divisor -> Variables auxs...
            mov AL, bajo1B              ; |   ...Para quitar '.'
            mov divd1, AL                            
                                        
            mov AL, bajo2B              
            mov divd2, AL              
            
            anddivi                     ;Convierte a decimal
            
            moverV divisor              
            
            cmp divisor, 0              ;Si divisor = 0,...
            je diviindet                ;... salta a diviindet
            jmp diviinic                ;Salta inicio de la division
            
diviindet:
            imprime indeter             ;Imprime mensaje de error
            jmp divifin                 ;Salta fin de la division

diviinic:                               ;Inicia division 

            cmp signoA, 01              ;Verifica si numA es negativo
            je  DAneg                   ;Si lo es, salta a DAneg 
            cmp signoB, 01              ;Verifica si numB es negativo
            je  Dresulneg               ;Si lo es, salta a Dresulneg
            
            jmp indiv                   ;Salta a division
            
DAneg:
            
            cmp signoB, 01              ;Verifica si numB es negativo
            je  indiv                    ;Si lo es, salta a division
            
            jmp Dresulneg
            
Dresulneg:

            imprime negativo
            jmp indiv


indiv:
            sub CX, CX                  ;Restituye CX
            
            mov AL, alto1A              
            mov dive1, AL                 
                                        
            mov AL, alto2A            
            mov dive2, AL               ; |
                                        ;<  Dividendo -> Variables auxs...
            mov AL, bajo1A              ; |   ... para quitar '.'
            mov divd1, AL               
                                        
            mov AL, bajo2A              
            mov divd2, AL               
            

restadiv:
            enmascd                     ;Variables aux a ASCII 
            
            mov BL, alto1B              
            cmp dive1, BL              
            ja  restad                  
            jb  menore                  
            mov BL, alto2B              
            cmp dive2, BL               
            ja  restad                  ; | Cmp Dividendo<Divisor
            jb  menor                   ;<  Si = salta a menor
            mov BL, bajo1B              ; | No = salta a restad
            cmp divd1, BL              
            ja  restad                  
            jb  menor                   
            mov BL, bajo2B              
            cmp divd2, BL               
            ja  restad                  
            jb  menor
            jmp restad
menore:
jmp menor
restad:                                 ;Division por restas

            restar divd2, bajo2B        
            mov divd2, AL               
            restar divd1, bajo1B        
            mov divd1, AL               ;<  Dividendo - Divisor
            restar dive2, alto2B        
            mov dive2, AL               
            restar dive1, alto1B        
            mov dive1, AL               
            
            inc CX                      ;Incrementa cociente
            
            jmp restadiv                ;Salta a restadiv
            
menor:                                  
            
            mov AX, CX                  ;Cociente -> AX
            AAM                         ;Desempaca Cociente (0X | 0X)
            add AX, 3030h               ;Convierte a ASCII
            mov DH, 0                   ;Restituye DH
            mov DL, AH                  ;Decena -> DL
            push DX                     ;Decena a pila
            mov DL, AL                  ;Unidad -> DL
            push DX                     ;Unidad a pila
            
            anddivi                     ;Convierte a decimal
            
            moverV residuo              
                                                               

                                        ;>> Division para primer decimal
            
            mov AX, residuo             ;residuo -> AX
            mul diezw                   ;residuo x 10
            
            sub DX, DX                  ;sub DX, DX
            div divisor                 ;residuo / divisor
            
            add AL, 30h                 ;primer decimal --> ASCII
            push AX                     ;primer decimal a pila
            
                                        ;>> Division para segundo decimal
            
            mov AX, DX                  ;residuo -> AX
            sub DX, DX                  ;restituye DX
            mul diezw                   ;residuo x 10
            
            sub DX, DX                  ;restituye DX
            div divisor                 ;residuo / divisor
            
            add AL, 30h                 ;segundo decimal --> ASCII
            push AX                     ;segundo decimaal a pila   
            
            pop AX                      ;Extrae de la pila
            mov divd2, AL               ;Segundo decimal -> aux
            pop AX                      ;Extrae de la pila
            mov divd1, AL               ;Primer decimal -> aux
            pop AX                      ;Extrae de la pila
            mov dive2, AL               ;Unidad -> aux
            pop AX                      ;Extrae de la pila
            mov dive1, AL               ;Decena -> aux
            
            mov AH, 02                  ;Funcion 02 -> AH
            
            mov DL, dive1               ;dive1 -> DL
            int 21h                     ;Imprime DL
            mov DL, dive2               ;dive2 -> DL
            int 21h                     ;Imprime DL
            
            imprime punto               ;Imprime '.'
            
            mov AH, 02                  ;Funcion 02 -> AH
            
            mov DL, divd1               ;divd1 -> DL
            int 21h                     ;Imprime DL
            mov DL, divd2               ;divd2 -> DL
            int 21h                     ;Imprime DL
         
divifin:                                
            restR                       ;Restituye registros
            restV                       ;Restituye variables
            
            imprime retmenu             ;Imprime retmenu
            scand                       ;Pide dato de opcion
            cmp AL, '1'                 ;Compara AL con '1'
            je  MENUe4                    ;Salta a MENU
            cmp AL, '2'                 ;Compara AL con '2'
            je  SALIRe4                   ;Salta a SALIR 
menue4:
		jmp MENU
salire4:
		jmp SALIR            
            
DIVI        endp                        
           
                             
                             
            

MULTI       proc near                      
    
            limpant                     ;Limpia pantalla    
            imprime mmsj                ;Imprime mensaje 'MULTIPLICACION'
            
            imprime resul               ;imprime resul
            
            restR 
            enmascm
            
            cmp signoA, 01              ;Verifica si numA es negativo
            je  MAneg                   ;Si lo es, salta a MAneg 
            cmp signoB, 01              ;Verifica si numB es negativo
            je  Mresulneg               ;Si lo es, salta a Mresulneg
            
            jmp mu                      ;Salta a multiplicacion
            
MAneg:
            
            cmp signoB, 01              ;Verifica si numB es negativo
            je  mu                      ;Si lo es, salta a multiplicacion
            
            jmp Mresulneg		        ;Salta a imprimir signo '-'
            
Mresulneg:

            imprime negativo	       	;imprime '-'
            jmp mu			; salta a mu (etiqueta multiplicacion)

mu:					 

            multiplicar bajo2a,bajo2b	
            mov e, al		      
            add d,ah		        
            				
	    multiplicar bajo1a,bajo2b	
            ajustemul d, c		
						    
            multiplicar alto2a,bajo2b  
            ajustemul c, b			    
 					
            multiplicar alto1a,bajo2b  	; 	multiplica unidad b por unidad 1
            ajustemul b, a		;    unidad b por decena 1
					;segundalinea|		   unidad b por centena 1
            multiplicar bajo2a,bajo1b	;   unidad b por millar 1
            mov j, al	           	;	suma acarreos 
            add i,ah		       
            multiplicar bajo1a,bajo1b	
            ajustemul i, h	        ;	multiplica decena b por unidad 1
					
            multiplicar alto2a,bajo1b   ;  decena b por centena 1
            ajustemul h, g      	;  decena b por millar 1
						
            multiplicar alto1a,bajo1b 	
            ajustemul g, f      
					;tercerlinea |
            multiplicar bajo2a,alto2b 	;multiplica centena b por unidad 1
            mov o, al			;centena b por decena 1
            add n,ah			; centena b por centena 1
            multiplicar bajo1a,alto2b	; centena b por millar 1
            ajustemul n, m       
					
            multiplicar alto2a,alto2b 	
            ajustemul m, l         
					;	   
            multiplicar alto1a,alto2b 	
            ajustemul l, k	
					
            multiplicar bajo2a,alto1b	;millar b por decena 1
            mov t, al			; millar b por centena 1
            add s,ah			;millar b por millar 1
            multiplicar bajo1a,alto1b
            ajustemul s, r
					
            multiplicar alto2a,alto1b 	
            ajustemul r, q	        
						     
            multiplicar alto1a,alto1b	
            ajustemul q, p		
            				
            mov ah, 00			
            mov  Al, E			
            push AX			
            				
            sumamulc D, J			
            push AX 			
            add c,dl			
            mov cl, c			;se suman las lineas y el resultado 
            add i,cl			;se mete en la pila
            sumamulc i,o		
            push ax			
            add b,dl				
            mov cl, b			
            add h,cl			
            mov cl, h			
            add n,cl			
            sumamulc n,t		 
            push ax			 	
            add a,dl			
            mov cl, a			
            add g,cl				
            mov cl, g			  
            add m,cl			 			
            sumamulc m,s		               
            push ax			
            add f,dl			
            mov cl, f			
            add l,cl			
            sumamulc l,r		
            push ax			
            add k,dl			
            sumamulc k,q		
            push ax			
            add p,dl			
            mov ah, 00			
            mov al,p			
            push ax     		
            
            pop dx			
            pop dx			
            pop dx			
            add dl, 30h			
            mov ah, 02			
            int 21h			
            pop dx 			     
            add dl, 30h			     
            mov ah, 02			;	    /      Extrae de la pila	
            int 21h  			;	    \      convierte a decimal
            mov dl,2Eh			;	     |     e imprime 
            mov ah, 02			
            int 21h			
            pop dx 			
            add dl, 30h			
            mov ah, 02			
            int 21h 			
            pop dx			
            add dl, 30h		
            mov ah, 02			
            int 21h 		
            
            pop dx 
            pop dx
            restV
            restR   
            
            imprime retmenu             ;Imprime retmenu
            scand                       ;Pide dato de opcion
            cmp AL, '1'                 ;Compara AL con '1'
            je  MENUe5                    ;Salta a MENU
            cmp AL, '2'                 ;Compara AL con '2'
            je  SALIRe5                   ;Salta a SALIR
menue5:
		jmp MENU
salire5:
		jmp SALIR            
MULTI       endp                        

                                  
                                  
            ; procedimiento SALIR
            
SALIR       proc near
    
            limpant                     ;Limpia pantalla
            
            imprime despe               ;Imprime despedida
            scand                       ;Hace una pausa

            jmp fin                     ;Salta a fin
            
SALIR       endp
            
                                    
                                    
            ; procedimiento ERROR
            
ERROR       proc near
    
            limpant                     ;Limpia pantalla
            
            imprime erro                ;Avisa de un error
            scand                       ;Hace una pausa
            restV                       ;Restituye todas las variables
            jmp MENU                    ;Salta a MENU
            
ERROR       endp
            
            end inicia 