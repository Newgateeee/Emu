.model small   
.stack
.data      
   m2 db '+$'    ; Cadena para pedir un numero al usuario
   m3 db '= $' ; Cadena para mostrar el resultado, incluyendo el signo '='
   n1 db ?               ; Variable para el primer numero
   n2 db ?               ; Variable para el segundo numero
.code
     main proc far
        mov ax,@data      ; Mueve la direccion de inicio del segmento de datos al registro AX
        mov ds,ax  
               ; Establece el segmento de datos usando AX
        
        suma:             ; Etiqueta para el comienzo del procedimiento de suma
            mov ah,09h    ; Funcion DOS para mostrar una cadena
            lea dx, m2; Carga la direccion de la cadena 'input' en DX
            int 21h       ; Interrumpe para mostrar la cadena
            
            mov ah,01h    ; Funcion DOS para leer un caracter del teclado
            int 21h       ; Interrumpe para leer el caracter
            sub al,30h    ; Convierte el caracter ASCII a su valor numerico (0-9)
            
            mov bl,al     ; Guarda el primer digito del primer numero en BL
            
            mov ah,01h    ; Funcion DOS para leer un carácter del teclado
            int 21h       ; Interrumpe para leer el caracter
            sub al,30h    ; Convierte el caracter ASCII a su valor numerico (0-9)
            mov cl,al     ; Guarda el segundo digito del primer numero en CL
            
            mov ah,09h    ; Funcion DOS para mostrar una cadena
            lea dx, m2 ; Carga la direccion de la cadena 'input' en DX
            int 21h       ; Interrumpe para mostrar la cadena
            
            mov ah,01h    ; Funcion DOS para leer un caracter del teclado
            int 21h       ; Interrumpe para leer el caracter
            sub al,30h    ; Convierte el caracter ASCII a su valor numerico (0-9)
            add bl,al     ; Suma el primer digito del segundo numero al valor en BL
            
            mov ah,01h    ; Funcion DOS para leer un caracter del teclado
            int 21h       ; Interrumpe para leer el caracter
            sub al,30h    ; Convierte el caracter ASCII a su valor numerico (0-9)
            add cl,al     ; Suma el segundo digito del segundo numero al valor en CL
            
            mov ah,09h    ; Funcion DOS para mostrar una cadena
            lea dx, m3; Carga la direccion de la cadena 'result' en DX
            int 21h       ; Interrumpe para mostrar la cadena
            
            mov ax,cx     ; Mueve el contenido de CX (suma de los segundos dígitos) a AX
            aam           ; Ajusta el contenido de AX en dos valores ASCII
            mov cx,ax     ; Mueve el contenido ajustado de AX a CX
            
            add bl,ch     ; Suma la parte alta de AX al valor en BL
            mov ax,bx     ; Mueve el contenido de BX (suma de los primeros digitos) a AX
            aam           ; Ajusta el contenido de AX en dos valores ASCII
            mov bx,ax     ; Mueve el contenido ajustado de AX a BX
            
            mov ah,02h    ; Funcion DOS para mostrar un carácter
            mov dl,bh     ; Mueve la parte alta de BX (primer digito ajustado) a DL
            add dl,30h    ; Convierte el valor numerico a su caracter ASCII
            int 21h       ; Interrumpe para mostrar el caracter
            
            mov ah,02h    ; Funcion DOS para mostrar un caracter
            mov dl,bl     ; Mueve la parte baja de BX (segundo digito ajustado) a DL
            add dl,30h    ; Convierte el valor numerico a su caracter ASCII
            int 21h       ; Interrumpe para mostrar el caracter
            
            mov ah,02h    ; Funcion DOS para mostrar un caracter
            mov dl,cl     ; Mueve el contenido de CL (segundo digito ajustado) a DL
            add dl,30h    ; Convierte el valor numerico a su caracter ASCII
            int 21h       ; Interrumpe para mostrar el caracter
            
            mov ah,01h    ; Funcion DOS para leer un caracter del teclado
            int 21h       ; Interrumpe para leer el caracter
            
        ret               ; Retorna al sistema operativo
end main                  ; Fin del procedimiento principal
