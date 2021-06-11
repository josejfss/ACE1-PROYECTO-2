
imprimirC MACRO character

    MOV ah, 02h
    MOV dl, character
    INT 21h

ENDM  


imprimir MACRO string

    MOV ah, 09h
    MOV dx, offset string
    INT 21h

ENDM


imprimir MACRO string

    MOV ah, 09h
    MOV dx, offset string
    INT 21h

ENDM


leerCadena MACRO buffer

    LOCAL LEER, FIN
    XOR si, si

    LEER:
        leerCaracter
        CMP al, 13                 ; 0ah->\n (LINE FEED) 0dh-> retorno de carro
            JE FIN

        MOV buffer[si], al
        INC si
        JMP LEER

    FIN:
        MOV buffer[si], 00h

ENDM  


limpiarConsola MACRO

    MOV AX,0600H     ;Llamada a la función
    MOV BH,07H         ;color de fondo y color de letra
    MOV CX,0000H     ;coordenadas de inicio
    MOV DX,184FH     ;coordenadas de fin
    INT 10H

ENDM


copyData MACRO arrayDestination,array_source
    LOCAL COPY

    COPY:
        CLD
        LEA si, array_source
        LEA di, arrayDestination
        MOV cx, LENGTHOF arrayDestination - 1
        REP MOVSB

ENDM   


limpiarBuffer MACRO buffer
    MOV al, 24h

    LEA di, buffer
    MOV cx, LENGTHOF buffer
    CLD
    REP stosb

ENDM

parseInt macro numero
	LOCAL INICIO,FIN,NEGATIVO, POSITIVO
	xor ax,ax
	xor bx,bx
	xor cx,cx
	mov bx,10	;multiplicador 10
	xor si,si
	INICIO:
		mov cl,numero[si] 
		inc si
		cmp cl, 45		; si es negativo
		je INICIO		; entonces vuelve al inicio corriendo una pos
		cmp cl,48
		jl CMPSIGNO
		cmp cl,57
		jg CMPSIGNO
		sub cl,48	;restar 48 para que me de el numero
		mul bx		;multplicar ax por 10
		add ax,cx	;sumar lo que tengo mas el siguiente
		jmp INICIO

	CMPSIGNO:
		mov cl, numero[0]
		cmp cl, 45			;si viene con numeros negativos
		je NEGATIVO
		jmp FIN
		NEGATIVO:					
			mov bx, -1
			mul bx
		
	FIN:
	;mov entero, ax
ENDM

leerCaracter MACRO
	MOV ah, 01h     ;; con ECHO
	; MOV ah, 08h 	;; sin ECHO
	INT 21h
ENDM