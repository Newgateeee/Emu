pila segment stack  ; segmento de pila
    db 32 DUP('stack--')  ; define 32 bytes en la pila con el valor 'stack--'
pila ends

datos segment  ; segmento de datos
    letrero1 db 10,13,': $'  ; mensaje para solicitar un numero
    letrero2 db 10,13,'El resultado es: $'  ; mensaje para mostrar el resultado
    n1 db ?  ; variable para almacenar el primer numero ingresado
    n2 db ?  ; variable para almacenar el segundo numero ingresado
    r db 0  ; variable para almacenar el resultado de la multiplicacion
datos ends

codigo segment 'code'  ; segmento de codigo
main proc FAR
    assume ss:pila, ds:datos, cs:codigo  ; asignar los segmentos

    mov ax,datos  ; cargar la direccion base del segmento de datos en AX
    mov ds,ax  ; mover la direccion base a DS
    
    mov ah,09h  ; funcion  para mostrar una cadena
    lea dx,letrero1  ; cargar la direccion del mensaje en DX
    int 21h  ; llamada a la interrupcion para mostrar el mensaje
    
    mov ah,01h  ; funcion  para leer un caracter del teclado
    int 21h  ; llamada a la interrupcion para leer el caracter
    sub al,30h  ; convertir el caracter ASCII a su valor numerico
    mov n1,al  ; almacenar el valor numerico en n1
    
    mov ah,09h  ; funcion para mostrar una cadena
    lea dx,letrero1  ; cargar la direccion del mensaje en DX
    int 21h  ; llamada a la interrupcion para mostrar el mensaje
    
    mov ah,01h  ; funcion  para leer un caracter del teclado
    int 21h  ; llamada a la interrupcion para leer el caracter
    sub al,30h  ; convertir el caracter ASCII a su valor numerico
    mov n2,al  ; almacenar el valor numerico en n2
    
    ; procedimiento de multiplicacion
    mov al,n1  ; mover el primer numero a AL
    mov bl,n2  ; mover el segundo numero a BL
    mul bl  ; multiplicar AL por BL, resultado en AX
    mov r,al  ; almacenar el resultado en r
    
    mov ah,09h  ; funcion DOS para mostrar una cadena
    lea dx,letrero2  ; cargar la direccion del mensaje en DX
    int 21h  ; llamada a la interrupcion para mostrar el mensaje
    
    mov ah,02h  ; funcion DOS para mostrar un caracter
    mov dl,r  ; cargar el resultado en DL
    add dl,30h  ; convertir el valor numerico a caracter ASCII
    int 21h  ; llamada a la interrupcion para mostrar el caracter
    
    mov ah,4ch  ; funcion que finaliza un programa
    int 21h  ; llamada a la interrupcion para finalizar
    
    ret
main endp
codigo ends
end main
