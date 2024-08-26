pila segment stack  ; Segmento de pila
    db 32 DUP('stack--')  ; Reserva 32 bytes en el segmento de pila inicializados con 'stack--'
pila ends

datos segment   ; Segmento de datos
    letrero1 db 10,13,'Ingresa un numero de dos digitos: $'  ; Cadena para pedir un numero
    letrero2 db 10,13,' $'  ; Cadena para mostrar el resultado
    letrero3 db 10,13,'Error: $'  ; Cadena para mostrar error de division por cero
    n1 db ?  ; Variable para almacenar el primer numero
    n2 db ?  ; Variable para almacenar el segundo numero
    r db 0  ; Variable para almacenar el resultado
datos ends

codigo segment 'code'   ; Segmento de codigo
main proc FAR
    assume ss:pila, ds:datos, cs:codigo  ; Asume los segmentos de pila, datos y codigo

    mov ax,datos  ; Carga la direccion del segmento de datos en AX
    mov ds,ax  ; Mueve AX al registro de segmento de datos DS
    
    ; Solicitar y capturar el primer numero de dos dígitos
    mov ah,09h  ; Configura la interrupcion 21h para mostrar una cadena
    lea dx,letrero1  ; Carga la direccion de letrero1 en DX
    int 21h  ; Llama a la interrupcion 21h para mostrar la cadena

    mov ah,01h  ; Configura la interrupcion 21h para capturar un carácter
    int 21h  ; Llama a la interrupcion 21h para capturar el primer digito
    sub al,30h  ; Convierte el caracter ASCII a valor numerico
    mov bl,al  ; Guarda el primer digito en BL
    
    mov ah,01h  ; Configura la interrupcion 21h para capturar el segundo digito
    int 21h  ; Llama a la interrupcion 21h para capturar el segundo digito
    sub al,30h  ; Convierte el caracter ASCII a valor numerico
    mov bh,al  ; Guarda el segundo digito en BH
    
    ; Combinar los dos digitos para formar el primer numero
    mov al,bl  ; Mueve el primer digito a AL
    mov ah,0Ah  ; Multiplica por 10 (decimal)
    mul ah  ; Multiplica AL por AH
    add al,bh  ; Suma el segundo digito
    mov n1,al  ; Guarda el resultado en n1
    
    ; Solicitar y capturar el segundo numero de dos digito
    mov ah,09h  ; Configura la interrupcion 21h para mostrar una cadena
    lea dx,letrero1  ; Carga la direccion de letrero1 en DX
    int 21h  ; Llama a la digito 21h para mostrar la cadena

    mov ah,01h  ; Configura la interrupcion 21h para capturar el primer digito
    int 21h  ; Llama a la digito 21h para capturar el primer digito
    sub al,30h  ; Convierte el caracter ASCII a valor numérico
    mov bl,al  ; Guarda el primer digito en BL
    
    mov ah,01h  ; Configura la interrupcion 21h para capturar el segundo digito
    int 21h  ; Llama a la interrupcion 21h para capturar el segundo digito
    sub al,30h  ; Convierte el caracter ASCII a valor numérico
    mov bh,al  ; Guarda el segundo digito en BH
    
    ; Combinar los dos digito para formar el segundo número
    mov al,bl  ; Mueve el primer digito a AL
    mov ah,0Ah  ; Multiplica por 10 (decimal)
    mul ah  ; Multiplica AL por AH
    add al,bh  ; Suma el segundo digito
    mov n2,al  ; Guarda el resultado en n2

    ; Procedimiento de division
    mov al,n2  ; Carga n2 en AL
    cmp al,0  ; Compara n2 con 0
    je division_por_cero  ; Si n2 es 0, salta a la etiqueta de error

    mov al,n1  ; Carga n1 en AL
    xor ah,ah  ; Asegura que AH es 0 antes de la división
    div n2  ; Divide n1 entre n2
    mov r,al  ; Guarda el cociente en r

    ; Mostrar el resultado
    mov ah,09h  ; Configura la interrupcion 21h para mostrar una cadena
    lea dx,letrero2  ; Carga la direccion de letrero2 en DX
    int 21h  ; Llama a la interrupcion 21h para mostrar la cadena

    ; Convertir el resultado a ASCII y mostrarlo
    mov ah,02h  ; Configura la interrupcion 21h para mostrar un carácter
    mov dl,r  ; Carga el resultado en DL
    add dl,30h  ; Convierte el valor numérico a ASCII
    int 21h  ; Llama a la interrupcion 21h para mostrar el carácter

    jmp fin_programa  ; Salta a la etiqueta de finalización del programa

division_por_cero:
    ; Mostrar error de division por cero
    mov ah,09h  ; Configura la interrupcion 21h para mostrar una cadena
    lea dx,letrero3  ; Carga la direccion de letrero3 en DX
    int 21h  ; Llama a la interrupcion 21h para mostrar la cadena

fin_programa:
    mov ah,4ch  ; Termina el programa
    int 21h  ; Llama a la interrupcion 21h para terminar el programa

    ret
main endp
codigo ends
end main
