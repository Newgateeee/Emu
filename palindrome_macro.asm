name "palindromo"
include 'emu8086.inc'
org 100h

jmp inicio

palabra db 50h dup(?)
aux1 db 0
aux2 dw 0

msj1: db 'Ingrese la palabra:$ '
exitomsj db 'La palabra ingresada es palindrome.$'
fallomsj db 'La palabra ingresada no es palindrome.$'

macro imprimir_mensaje mensaje
    mov dx, offset mensaje
    mov ah, 9
    int 21h
endm

inicio:
    imprimir_mensaje msj1

    mov bl, 0Dh ; esperamos la tecla enter
    mov si, 00d ; inicio del contador del string
    mov ah, 1

lectura:
    int 21h ; lectura del caracter
    mov palabra[si], al ; almacenamos en el vector string
    inc si ; incremento variable SI
    cmp al, bl ; comparamos el caracter ingresado con el ENTER
    jne lectura

    mov di, si
    dec di ; la variable si se pasa en dos posiciones, ya que almacena
    dec di ; el enter y el retorno de la palabra, por eso se decrementa dos veces

    mov si, 00d
    mov aux2, di ; almacenamos el largo en una variable

comparar:
    mov al, palabra[si]
    cmp palabra[di], al ; si son distintos de inmediato no son palindromes
    jne no_palindromo

    cmp si, aux2
    je palindromo

    inc si
    dec di

    jmp comparar

no_palindromo:
    mov aux1, 1
    jmp imprimir

mensaje1:
    mov al, 0Ah
    int 10h

    imprimir_mensaje fallomsj
    jmp fin

palindromo:
    jmp imprimir

mensaje2:
    mov al, 0Ah
    int 10h

    imprimir_mensaje exitomsj
    jmp fin

imprimir:
    mov di, aux2
    mov ah, 0Eh
    mov al, 0Ah
    int 10h
    mov si, -01d

for:
    mov ah, 0Eh
    inc si
    mov al, palabra[si]
    int 10h
    cmp si, di
    jne for

    mov al, aux1
    cmp al, 1
    je mensaje1
    jmp mensaje2

fin:
    ret

end
