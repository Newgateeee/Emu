

imprime macro numero
    mov ah,02h
    mov dl, numero
    add dl,30h
    int 21h
    

    
endm
.model small
.stack 64
.data 
num db 0

mov cx,9
inicio:
mov num,cl 
imprime num
loop inicio
mov ah,04ch
int 21h
end