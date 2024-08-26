pila segment stack      ; segmento de pila
    db 32 DUP('stack--') ; define un bloque de 32 bytes en la pila, cada uno con el valor 'stack--'
pila ends

datos segment
    letrero1 db 10,13,'Ingresa un numero de un digito: $' ; mensaje para ingresar un numero
    letrero2 db 10,13,'El resultado es: $' ; mensaje para mostrar el resultado
    n1 db ? ; variable para almacenar el primer numero 1
    n2 db ? ; variable para almacenar el segundo numero 2
    r db 0 ; variable para almacenar el resultado de la resta
datos ends

codigo segment 'code' ; segmento de codigo
main proc FAR   

    ; Inicializaci�n del segmento de datos
    mov ax,datos ; cargar la direccion base del segmento de datos en AX
    mov ds,ax ; mover la direccion base a DS

    ; Mostrar el mensaje para ingresar el primer n�mero
    mov ah,09h ;funcion para mostrar una cadena
    lea dx,letrero1 ; cargar la direccion del mensaje en DX
    int 21h ; llamada a la interrupcion para mostrar el mensaje

    ; Leer el primer n�mero
    mov ah,01h ; funcion para leer un car�cter del teclado
    int 21h ; llamada a la interrupcion para leer el car�cter
    sub al,30h ; convertir el car�cter ASCII a su valor num�rico
    mov n1,al ; almacenar el valor num�rico en n1

    ; Mostrar el mensaje para ingresar el segundo numero
    mov ah,09h ; funcion para mostrar una cadena
    lea dx,letrero1 ; cargar la direccion del mensaje en DX
    int 21h ; llamada a la interrupcion para mostrar el mensaje

    ; Leer el segundo n�mero
    mov ah,01h ; funcion para leer un car�cter del teclado
    int 21h ; llamada a la interrupcion para leer el car�cter
    sub al,30h ; convertir el car�cter ASCII a su valor num�rico
    mov n2,al ; almacenar el valor num�rico en n2

    ; Proceso de resta
    mov cl,n1 ; mover el primer numero a CL
    mov ch,n2 ; mover el segundo numero a CH
    sub cl,ch ; restar CH de CL
    mov r,cl ; almacenar el resultado en r

    ; Mostrar el resultado
    mov ah,09h ; funcion para mostrar una cadena
    lea dx,letrero2 ; cargar la direccion del mensaje en DX
    int 21h ; llamada a la interrupcion para mostrar el mensaje

    ; Mostrar el resultado en pantalla
    mov ah,02h ; funcion para mostrar un car�cter
    mov dl,r ; cargar el resultado en DL
    add dl,30h ; convertir el valor numerico a car�cter ASCII
    int 21h ; llamada a la interrupcion para mostrar el car�cter

    ; Finalizar el programa
    mov ah,4ch 
    int 21h 
    ret
main endp
codigo ends
end main
