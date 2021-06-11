;macro para capturar un caracter en consola
getChar macro
    mov ah, 01h
    int 21h
    endm


mediana macro buffer
    LOCAL IMPAR, FIN, NUMERITO
    mov decimal, 0
    ordenamiento_bubblesort_asc buffer, tamano
    mov bx, tamano
    and bx,1         ; compruebo el bit 0
    cmp bx,1         ; si bx=1 es impar
    je IMPAR
    
    
    xor bx, bx
    mov bx, tamano
    mov temp, bx
    mov di, bx
    mov bx, buffer[di]
    mov num1, bx
    mov bx, di
    sub bx, 2
    mov di, bx
    mov bx, buffer[di]
    mov num2, bx
    add bx, num1
    mov resultado, bx ;guarda el resultado de la suma

    
    dividir resultado, 0002

    mov bx, resultado
    and bx,1         ; compruebo el bit 0
    cmp bx,1         ; si bx=1 es impar
    je NUMERITO
    
    mov bx, entero
    mov median, bx
    mov bx, 0
    mov decMedian, bx

    print msjConsola
    ImprimirN16 median
    imprimirSalto punto
    ImprimirDec decMedian 
    print newLine

    jmp FIN

    IMPAR:
        xor bx,bx
        mov bx, tamano
        dec bx
        
        mov temp, bx ; actualizamos el tamaño
        mov di, bx
        
        mov bx, buffer[di]
        mov median, bx
        mov decMedian, 0
        ImprimirN16 median ;imprime el resultado
        imprimirSalto punto
        ImprimirN16 decMedian

        ; print newLine
        JMP FIN

    NUMERITO:
         mov bx, entero
        mov median, bx
        mov bx, 5000
        mov decMedian, bx

        ImprimirN16 median
        imprimirSalto punto
        ImprimirN16 decMedian 

    FIN:
        
endm


;=======CALCULO DE PROMEDIO=========
promedio macro buffer
    mov decimal, 0
    sumaArray buffer, tamano
    dividir resultado, tamano
    mov bx, entero
    mov prom, bx
    mov bx, decimal
    mov decProm, bx

    ;impresion de resultado
    print msjConsola
    ImprimirN16 prom
    imprimirSalto punto
    ImprimirDec decProm
    print newLine
endm

funcionModa macro tamanoBuffer
    LOCAL MAYOR, ciclo

    ;array_length16 vFrecuencia
    mov bx, tamanoBuffer
    dec bx
    mov temp, bx

    ;limpia registros
    xor di,di
    xor si, si

    mov si, 0
    mov di, 0
    mov bx, 0
    mov posArr, 0

    mov bx, vFrecuencia[di]
    mov ultimoVal, bx ;primer valor del arreglo
    mov moda, bx
    mov di, 2

    ciclo:
        inc si

        mov bx, ultimoVal
        cmp bx, vFrecuencia[di]	;array[j] = array[j-1]
        jb MAYOR

        cmp si, temp
        je FIN

        add di, 2
        jmp ciclo


    MAYOR:
        

        mov bx, di
        mov posArr, bx
        mov bx, vFrecuencia[di]
        mov ultimoVal, bx
        mov bx, vValores[di]
        mov moda, bx
        
        add di, 2
        jmp ciclo
    
    FIN:
        print msjConsola
        ImprimirN16 moda
        print newLine

endm

;===========CALCULO DE MODA
frecuencia macro buffer
    LOCAL IGUAL, OBLIGATORIO, IGUAL, PRIMERA, ciclo, PROX
    cleanDWarray vFrecuencia, SIZEOF vFrecuencia
    cleanDWarray vValores, SIZEOF vValores
    
    ordenamiento_bubblesort_asc buffer, tamano

    ;limpia registros
    xor di,di
    xor si, si
    xor cx, cx

    mov bx, 0
    mov tamanoArrFrecuencia, bx

    mov bx, 0
    mov posArr, bx

    mov si, 0
    mov di, 0
    mov cx, 0
    

    mov bx, buffer[di]
    mov ultimoVal, bx ;primer valor del arreglo
    mov di, 2

    ciclo:
        inc si
        
        ;operaciones para saber si es mayor
        mov bx, ultimoVal
        cmp bx, buffer[di]	;array[j] = array[j-1]
        je IGUAL

        ;codigo si no son iguales
        push di
        push bx

        mov di, posArr
        mov bx, vFrecuencia[di]
        cmp bx, '$'
        je PROX

        inc tamanoArrFrecuencia
        mov bx, vFrecuencia[di]
        inc bx
        mov vFrecuencia[di], bx
        mov ax, ultimoVal
        mov vValores[di], ax
        add di, 2
        mov posArr, di ; actualizamos la nueva pos del arreglo

        mov resultado, bx ;guardamos en resultado el valor

        jmp OBLIGATORIO

        IGUAL:
            push di
            push bx

            mov di, posArr
            mov bx, vFrecuencia[di]
            cmp bx, '$' ;si tenemos ese valor no hay datos inicial
            je PRIMERA

            ;print newLine
            mov bx, vFrecuencia[di]
            inc bx
            mov vFrecuencia[di], bx

            mov resultado, bx ;guardamos en resultado el valor


            jmp OBLIGATORIO

        PRIMERA:
            ;inc tamanoArrFrecuencia
            mov bx, 1
            mov vValores[di], bx
            mov vFrecuencia[di], bx
            jmp OBLIGATORIO
        
        PROX:
            inc tamanoArrFrecuencia
            mov bx, 1
            mov vFrecuencia[di], bx
            mov ax, ultimoVal
            mov vValores[di], ax
            add di, 2
            mov posArr, di ; actualizamos la nueva pos del arreglo

            mov resultado, bx ;guardamos en resultado el valor

        
        OBLIGATORIO: ;Siempre sucede
            pop bx ;sacamos valores
            pop di
            
            mov bx, buffer[di]
            mov ultimoVal, bx;actualizamos al valor siguiente
            add di,2
            cmp si, tamano
            jb ciclo

        
endm


;===== suma  array de numeros tipo word =======
sumaArray macro buffer, tamanoBuffer
    ;limpia registros
    xor di,di
    xor si, si
    xor bx, bx
    
    mov di, 0 ;inicio de variables
    mov si, 0
    mov resultado, 0 ;reset de resultado
    ;mov ax, buffer[0]
    print newLine
    ciclo:
        add bx, buffer[di]
        mov resultado, bx
        inc si
        add di,2
        cmp si, tamanoBuffer
    jnz ciclo
    
endm


;======IMPRIMIR DE ARRAY =======
imprimirArray macro buffer, tamanoBuffer
    LOCAL ciclo

    ; array_length16 buffer
    ; mov tamano, bx

    ;limpia registros
    xor di,di
    xor si, si

    mov si, 0
    print newLine
    ciclo:
        inc si
        ImprimirN16 buffer[di]
        imprimirSalto 10
        imprimirSalto 13
        
        add di,2
        cmp si, tamanoBuffer
    jb ciclo
endm


imprimirTablaFrecuencia macro buffer1, buffer2
    LOCAL ciclo

    ;limpia registros
    xor di,di
    xor si, si

    
    agregarTextoBuffer separadores, bufferContenido
    agregarTextoBuffer msjTablaFrecuencia, bufferContenido
    agregarTextoBuffer newLine, bufferContenido
    agregarTextoBuffer guion, bufferContenido
    agregarTextoBuffer guion, bufferContenido
    agregarTextoBuffer guion, bufferContenido
    agregarTextoBuffer guion, bufferContenido
    agregarTextoBuffer guion, bufferContenido
    agregarTextoBuffer guion, bufferContenido
    agregarTextoBuffer saltoLinea, bufferContenido

    xor si, si
    xor di, di
    ciclo:
        inc si
        agregarTextoBuffer orBarra, bufferContenido
        agregarTextoBuffer separadores, bufferContenido
        
        getNumero16 buffer1[di], bufferContenido
        agregarTextoBuffer separadores, bufferContenido
        agregarTextoBuffer orBarra, bufferContenido
        agregarTextoBuffer separadores, bufferContenido
        
        getNumero16 buffer2[di], bufferContenido
        agregarTextoBuffer separadores, bufferContenido
        agregarTextoBuffer orBarra, bufferContenido
        agregarTextoBuffer saltoLinea, bufferContenido
        agregarTextoBuffer guion, bufferContenido
        agregarTextoBuffer guion, bufferContenido
        agregarTextoBuffer guion, bufferContenido
        agregarTextoBuffer guion, bufferContenido
        agregarTextoBuffer guion, bufferContenido
        agregarTextoBuffer guion, bufferContenido
        agregarTextoBuffer saltoLinea, bufferContenido

        
        add di,2
        cmp si, tamanoArrFrecuencia
    jb ciclo
endm




;====== length de 16 bits ===========
array_length16 macro buffer
	LOCAL REPETIR, FIN
	xor si, si
	xor bx, bx
	REPETIR:	;
    	mov ax, buffer[si]
      	cmp al, '$'
        je FIN
        add si, 2
		inc bx
        jmp REPETIR

	FIN:
		;el resultado almacena en bx
endm



ordenamiento_bubblesort_asc macro buffer, tamanoBuffer ;
	LOCAL FIN, FORIN, FOR2, SENTENCIAS, MIF, LOOP_FOR
	mov cont, 0
	;array_length16 buffer	;obtiene numero elemento y alamecena en bx
    mov bx, tamanoBuffer
	mov cx, bx
	mov dx, cx
	sub dx, 1
	mov contTemp, bx
	FORIN:
		xor cx, cx
		xor bx, bx
		mov si, cont
		cmp si, contTemp          ; SI < DX
        jl FOR2            	; condicion true 
		jmp FIN				; condicion false
		FOR2:
			inc cont
			mov si, 0
			LOOP_FOR:
				inc bx
				add si, 2			;sirve para posicion buffer
				mov di, si
				sub di, 2
				cmp bx, contTemp
				jl MIF
				jmp FORIN
				MIF:; sentencia primer if
					mov ax, buffer[si]
					cmp ax, buffer[di]	;array[j] < array[j-1]
					jl SENTENCIAS			;condicion true
					jmp LOOP_FOR				;codicion false
				SENTENCIAS:
					mov ax, buffer[si]
					mov temp, ax			;temp = array[j]
					mov ax, buffer[di]
					mov buffer[si], ax		;array[j] = array[j-1]
					mov ax, temp
					mov buffer[di], ax	;array[j-1] = temp 
					mov ax, buffer[di]
			jmp LOOP_FOR
	jmp FORIN
		
	FIN:

	endm

ordenamiento_bubblesort_desc macro buffer, tamanoBuffer ;
	LOCAL FIN, FORIN, FOR2, SENTENCIAS, MIF, LOOP_FOR
	mov cont, 0
	;array_length16 buffer	;obtiene numero elemento y alamecena en bx
    mov bx, tamanoBuffer
	mov cx, bx
	mov dx, cx
	sub dx, 1
	mov contTemp, bx
	FORIN:
		xor cx, cx
		xor bx, bx
		mov si, cont
		cmp si, contTemp          ; SI < DX
        jl FOR2            	; condicion true 
		jmp FIN				; condicion false
		FOR2:
			inc cont
			mov si, 0
			LOOP_FOR:
				inc bx
				add si, 2			;sirve para posicion buffer
				mov di, si
				sub di, 2
				cmp bx, contTemp
				jl MIF
				jmp FORIN
				MIF:; sentencia primer if
					mov ax, buffer[si]
					cmp ax, buffer[di]	;array[j] < array[j-1]
					jg SENTENCIAS			;condicion true
					jmp LOOP_FOR				;codicion false
				SENTENCIAS:
					mov ax, buffer[si]
					mov temp, ax			;temp = array[j]
					mov ax, buffer[di]
					mov buffer[si], ax		;array[j] = array[j-1]
					mov ax, temp
					mov buffer[di], ax	;array[j-1] = temp 
					mov ax, buffer[di]
			jmp LOOP_FOR
	jmp FORIN
		
	FIN:

	endm


dividir macro num1,num2
local ciclo

    xor dx,dx
    mov ax,num1
    mov bx,num2
    div bx ; num1, num2
    xor cx,cx
    mov entero,ax
    ciclo:
        mov ax,dx
        xor dx,dx
        push bx
        mov bx,10
        mul bx
        pop bx

        xor dx,dx
        div bx

        push ax
        push dx
        push bx


        xor dx,dx
        mov ax,decimal
        mov bx,10
        mul bx
        mov decimal,ax

        pop bx
        pop dx
        pop ax

        add decimal,ax

        inc cx
        cmp cx,4
        jnz ciclo

endm


print macro cadena
    mov   ax,@data    ;Segmento
    mov   ds,ax          ;ds = ax = saludo
    mov   ah,09          ;Function(print string)
    mov   dx,offset cadena         ;DX = String terminated by "$"
    int   21h  
endm

Salto macro 
    mov dl,10 
    mov ah,02h
    int 21h
    mov dl,13 
    mov ah,02h
    int 21h
endm

imprimirSalto macro Num
    local zero
    xor ax,ax
    mov dl,NUm
    mov ah,02h
    int 21h
endm

imprimirDigito macro Num
    local zero
    xor ax,ax
    mov dl,NUm
    add dl,48
    mov ah,02h
    int 21h
endm

ImprimirN8 macro Regis
    local zero,noz
    mov bx,2
    xor ax,ax
    mov al,Regis
    mov cx,10
    zero:
    xor dx,dx
    div cx
    push dx
    dec bx
    jnz zero
    xor bx,2
    noz:
    pop dx
    imprimirDigito dl
    dec bx
    jnz noz
endm


ImprimirN16 macro Regis
    local zero,noz

    mov bx,4
    xor ax,ax
    mov ax,Regis
    mov cx,10
    zero:
    xor dx,dx
    div cx
    push dx
    dec bx
    jnz zero

    xor bx,4
    noz:
    pop dx
    imprimirDigito dl
    dec bx
    jnz noz

endm

ImprimirDec macro Regis
    local zero,noz

    mov bx,4
    xor ax,ax
    mov ax,Regis
    mov cx,10
    zero:
    xor dx,dx
    div cx
    push dx
    dec bx
    jnz zero

    xor bx,3
    noz:
    pop dx
    imprimirDigito dl
    dec bx
    jnz noz
    
    pop bx

endm

;==============imprimir vertical num en modo video==========================
ImprimirN163 macro Regis, col
local zero,noz

xor bx, bx
mov bh, 26
mov posInicioVertical, bh
xor bx, bx

mov bx,3
xor ax,ax
mov ax,Regis
mov cx,10
zero:
xor dx,dx
div cx
push dx
dec bx
jnz zero


xor bx,3
noz:
pop dx

;para imprimir vertical
push ax
push bx
push dx
push cx 
xor ax,ax
xor bx,bx
xor dx,dx
xor cx,cx
inc posInicioVertical
mover_cursor posInicioVertical,col

pop cx
pop dx
pop bx
pop ax
;fin

imprimirDigito dl

dec bx
jnz noz

endm


ImprimirN163V macro Regis
    local zero,noz

    mov bx,3
    xor ax,ax
    mov ax,Regis
    mov cx,10
    zero:
    xor dx,dx
    div cx
    push dx
    dec bx
    jnz zero

    xor bx,3
    noz:
    pop dx
    imprimirDigito dl
    dec bx
    jnz noz

endm

;=================== MODO VIDEO ================

getAncho macro anchito, numItem
	mov bx, numItem	;cantidad de elementos del array
	mov ax, 0244h
	mov dx, 0
	div bx
	mov anchito, ax

    mov bx, 2	;cantidad de elementos del array
	mov ax, anchito
	mov dx, 0
	div bx 
	mov anchito, ax
	
    endm

getAnchoLinea macro anchito, numItem
	mov bx, numItem	;cantidad de elementos del array
    dec bx
    mov tamanoGraficaLinea, bx
	mov ax, 0244h
	mov dx, 0
	div bx
	mov anchito, ax
endm

getAnchoLeyenda macro anchito, numItem
	mov bx, numItem	;cantidad de elementos del array
	mov ax, 048h
	mov dx, 0
	div bx
	mov anchito, al

    mov bx, 2	;cantidad de elementos del array
	mov al, anchito
	mov dx, 0
	div bx 
	mov anchito, al
	
endm


getAlto macro altito, numero
		push ax
		push bx
		xor ax, ax 
		mov ax, numero
		mov bx, 378d ;pixeles disponibles
		mul bx

        mov bx,numeroMayor
        div bx;REGIS / REGIS2
        xor cx,cx
		mov altito, ax
        
        mov ax, 428 ; cantidad de pixeles hasta el eje X
        sub ax, altito
        mov altito, ax
        
		pop bx 
		pop ax
endm

getAltoLeyenda macro altito, numero
		push ax
		push bx
		xor ax, ax 
		mov ax, numero
		mov bx, 25d ;pixeles disponibles
		mul bx

        mov bx,numeroMayor
        div bx;REGIS / REGIS2
        xor cx,cx
		mov resultado, ax
        
        mov ax, 28 ; cantidad de pixeles hasta el eje X
        sub ax, resultado
        mov altito, al
		pop bx 
		pop ax
endm



limpiarPantalla macro 
	mov ah,	00h
	mov al, 03h
	int 10h
endm

    
cleanDWarray macro buffer, length
	LOCAL INICIO,FIN
	PUSH SI
	PUSH CX
	xor si,si
	xor cx,cx
	mov cx,length
	INICIO:
		cmp si,cx
		je FIN
		mov [buffer+si],'$'
		inc si
		inc si
		jmp INICIO
	FIN:
	POP CX
	POP SI
endm

imprimirLeyendaAbajo macro buffer
    LOCAL ciclo
    push bx
    ;array_length16 buffer
    ;mov tamano, bx
    getAnchoLeyenda anchoLineaLeyenda, tamanoArrFrecuencia
    ;inc anchoLineaLeyenda

    ;limpia registros
    xor di,di
    xor si, si
    xor bx, bx

    mov bl, 4
    mov anchoLineaLeyendaDist, bl
    mov si, 0
    print newLine
    ciclo:
        inc si
        ImprimirN163 buffer[di], anchoLineaLeyendaDist

        mov bl, anchoLineaLeyendaDist
        add bl, anchoLineaLeyenda
        mov anchoLineaLeyendaDist, bl
        
        mov bl, anchoLineaLeyendaDist
        add bl, anchoLineaLeyenda
        mov anchoLineaLeyendaDist, bl
        inc anchoLineaLeyendaDist

        add di,2
        cmp si, tamanoArrFrecuencia
    jb ciclo

    pop bx
endm

imprimirLeyendaAbajoL macro buffer
    LOCAL ciclo
    push bx
    ;array_length16 buffer
    ;mov tamano, bx
    getAnchoLeyenda anchoLineaLeyenda, tamanoArrFrecuencia
    ;inc anchoLineaLeyenda

    ;limpia registros
    xor di,di
    xor si, si
    xor bx, bx

    mov bl, 4
    mov anchoLineaLeyendaDist, bl
    ;inc anchoLineaLeyendaDist
    mov si, 0
    print newLine
    ciclo:
        inc si
        ImprimirN163 buffer[di], anchoLineaLeyendaDist

        mov bl, anchoLineaLeyendaDist
        add bl, anchoLineaLeyenda
        mov anchoLineaLeyendaDist, bl
        
        mov bl, anchoLineaLeyendaDist
        add bl, anchoLineaLeyenda
        mov anchoLineaLeyendaDist, bl
        inc anchoLineaLeyendaDist

        add di,2
        cmp si, tamanoArrFrecuencia
    jb ciclo

    pop bx
endm


imprimirLeyendaVertical macro buffer
    LOCAL ciclo
    push bx
    ;array_length16 buffer
    ;mov tamanoArrFrecuencia, bx
    ;inc anchoLineaLeyenda

    ;limpia registros
    xor di,di
    xor si, si
    xor bx, bx

    
    mov si, 0
    ciclo:
        inc si
        ;obteniendo alto
        getAltoLeyenda AltoLineaLeyendaDist, buffer[di]
        dec AltoLineaLeyendaDist
        mover_cursor AltoLineaLeyendaDist, 0
        ImprimirN163V buffer[di]
        print newLine

        add di,2
        cmp si, tamanoArrFrecuencia
    jb ciclo

    pop bx
endm


ordenamientoTablaFrecuenciaAsc macro buffer, bufferFrecuencia ;
	LOCAL FIN, FORIN, FOR2, SENTENCIAS, MIF, LOOP_FOR
	mov cont, 0
	;array_length16 buffer	;obtiene numero elemento y alamecena en bx
    mov bx, tamanoArrFrecuencia
	mov cx, bx
	mov dx, cx
	sub dx, 1
	mov contTemp, bx
	FORIN:
		xor cx, cx
		xor bx, bx
		mov si, cont
		cmp si, contTemp          ; SI < DX
        jl FOR2            	; condicion true 
		jmp FIN				; condicion false
		FOR2:
			inc cont
			mov si, 0
			LOOP_FOR:
				inc bx
				add si, 2			;sirve para posicion buffer
				mov di, si
				sub di, 2
				cmp bx, contTemp
				jl MIF
				jmp FORIN
				MIF:; sentencia primer if
					mov ax, buffer[si]
					cmp ax, buffer[di]	;array[j] < array[j-1]
					jl SENTENCIAS			;condicion true
					jmp LOOP_FOR				;codicion false
				SENTENCIAS:
                    push bx
                    xor bx, bx

					mov ax, buffer[si]
					mov temp, ax			;temp = array[j]

                    mov bx, bufferFrecuencia[si]
					mov temp1, bx			
                    ;siguiente paso
					mov ax, buffer[di]
					mov buffer[si], ax		;array[j] = array[j-1]
					mov ax, temp

                    mov bx, bufferFrecuencia[di]
					mov bufferFrecuencia[si], bx
					mov bx, temp1
                    ;siguiente paso
					mov buffer[di], ax	;array[j-1] = temp 
					mov ax, buffer[di]
                    
                    mov bufferFrecuencia[di], bx 
					mov bx, bufferFrecuencia[di]
                    
                    pop bx
			jmp LOOP_FOR
	jmp FORIN
		
	FIN:

endm


ordenamientoTablaFrecuenciaDesc macro buffer, bufferFrecuencia ;
	LOCAL FIN, FORIN, FOR2, SENTENCIAS, MIF, LOOP_FOR
	mov cont, 0
	;array_length16 buffer	;obtiene numero elemento y alamecena en bx
    mov bx, tamanoArrFrecuencia
	mov cx, bx
	mov dx, cx
	sub dx, 1
	mov contTemp, bx
	FORIN:
		xor cx, cx
		xor bx, bx
		mov si, cont
		cmp si, contTemp          ; SI < DX
        jl FOR2            	; condicion true 
		jmp FIN				; condicion false
		FOR2:
			inc cont
			mov si, 0
			LOOP_FOR:
				inc bx
				add si, 2			;sirve para posicion buffer
				mov di, si
				sub di, 2
				cmp bx, contTemp
				jl MIF
				jmp FORIN
				MIF:; sentencia primer if
					mov ax, buffer[si]
					cmp ax, buffer[di]	;array[j] < array[j-1]
					jg SENTENCIAS			;condicion true
					jmp LOOP_FOR				;codicion false
				SENTENCIAS:
                    push bx
                    xor bx, bx

					mov ax, buffer[si]
					mov temp, ax			;temp = array[j]

                    mov bx, bufferFrecuencia[si]
					mov temp1, bx			
                    ;siguiente paso
					mov ax, buffer[di]
					mov buffer[si], ax		;array[j] = array[j-1]
					mov ax, temp

                    mov bx, bufferFrecuencia[di]
					mov bufferFrecuencia[si], bx
					mov bx, temp1
                    ;siguiente paso
					mov buffer[di], ax	;array[j-1] = temp 
					mov ax, buffer[di]
                    
                    mov bufferFrecuencia[di], bx 
					mov bx, bufferFrecuencia[di]
                    
                    pop bx
			jmp LOOP_FOR
	jmp FORIN
		
	FIN:

endm


;=========================================================================================================
pintar_pixel macro i, j, color
	push ax
	push bx
	push cx
    push dx

    mov ah, 0ch
    mov al, color
    mov bh, 00h
    mov cx, j
    mov dx, i
    int 10h
		
	pop dx
	pop cx
	pop bx
    pop ax
endm


pintar_marco macro izq, der,arr, aba, color
	local ciclo1, ciclo2
	push si
	xor si, si
	mov si, izq
	ciclo1:
		pintar_pixel aba, si, color
		inc si
		cmp si, der
	jne ciclo1

	xor si, si
	mov si, arr
	ciclo2:
		pintar_pixel si, izq, color
		inc si
		cmp si, aba
	jne ciclo2
	pop si
endm


mover_cursor macro fila, columna
    xor ax, ax
	mov ah, 02h
	mov bh, 00h
	mov dh, fila
	mov dl, columna
	int 10h
endm

DS_DATOS macro
	push ax
	mov ax,@data
	mov ds,ax
	pop ax
endm

	;Cambia DS a memoria de video
DS_VIDEO macro
	push ax
	mov ax, 0A000h
	mov ds, ax
	pop ax
endm


INI_VIDEO macro
	mov ax, 0012h
	int 10h
	; mov ax, 0A000h
	; mov ds, ax
endm

;Finalizar el modo video y retornar a modo texto
FIN_VIDEO macro
	mov ax, 0003h
	int 10h
	mov ax, @data
	mov ds, ax
endm

graficarBarras macro bufferFrecuencia, bufferValores, mensaje

    LOCAL PIVOTE,ciclo1, ciclo2
    ;datos para grafica
    ;array_length16 bufferFrecuencia;	obtienen el numero de items
	;mov tamano, bx
    getAncho anchoLinea2, tamanoArrFrecuencia
    
    ;==========GRAF======
    mov bx, contadorGrafica ; limpiar contadorGrafica
    mov bx, 0
    mov contadorGrafica, bx


    mov bx, posArreglo ; limpiar posArreglo
    mov bx, 0
    mov posArreglo, bx

    mov bx, posInicial ; definir pos inicial
    mov bx, 40
    mov posInicial, bx

    mov bx, posFinal ; definir un pos final inicial
    mov bx, 40
    mov posFinal, bx

    ;=========================== GRAFICA=================
    INI_VIDEO 
    ;pintar_pixel 120, 160, 0fh
    pintar_marco 39d, 619, 49, 429, 15d
	DS_DATOS
    xor di, di
	
    PIVOTE:
        
        ;obtener posicion del array
        mov dx, posArreglo
        mov di, dx
        add dx, 2
        mov posArreglo, dx
        
        ;obtiene el pixel siguiente a graficar del ancho
        mov bx, posFinal
        add bx, anchoLinea2
        mov posFinal, bx
        push bx; ancho fin primer ciclo

        ;obtiene alto de grafica
        getAlto tamanoAltoLinea, bufferFrecuencia[di]
        mov bx, tamanoAltoLinea
        mov si, bx
        push si 


        DS_VIDEO
		xor cx, cx
		xor si, si
        xor bx, bx
		;mov si, 202
        pop si
        pop bx

		ciclo1:
			xor cx, cx
			
            DS_DATOS;para ingresar la pos inicial para graficar
            mov cx, posInicial
            push posInicial
            DS_VIDEO
            pop cx ;termina el ancho inicial

			ciclo2:
				pintar_pixel si, cx, 9d
				inc cx
			cmp cx, bx
			jnz ciclo2
			inc si
		cmp si, 428d
		jne ciclo1



        ;===========para agregarle ciclo===========
        DS_DATOS
        ;obtiene el pixel final a grafica del ancho 
        mov bx, posFinal
        add bx, anchoLinea2
        mov posFinal, bx
        mov posInicial, bx
        ;miramos la cantidad de veces que se repite
        xor bx, bx
        inc contadorGrafica
        mov bx, contadorGrafica
        
        
        cmp bx, tamanoArrFrecuencia
        jnz PIVOTE ;fin ciclo

    mover_cursor 0,0
    print mensaje
    
    imprimirLeyendaVertical bufferFrecuencia
    imprimirLeyendaAbajo bufferValores
    getChar
    FIN_VIDEO


endm

;=============INGRESA NUMEROS DEL ARCHIVO XML================
IngresarNumeros macro numero
    push bx
    push ax

    xor di, di
    xor bx, bx
    xor ax, ax

    mov bx, posArregloNumero
    mov di, bx
    mov ax,numero
    mov vNumeros[di],ax

    add bx, 2
    mov posArregloNumero, bx
    inc tamano

    pop ax
    pop bx
endm


;==========GRAFICA DE LINEAS============0
bresenham macro x1, y1, x2, y2
    LOCAL CAMXP, CAMXN, CAMYP, CAMYN, COMCAM, CAMYMAYOR, CAMXMAYOR, ENDCOMCAM, FOR1, FOR1E1, FOR1E2, FOR2, FOR2E1, FOR2E2

    xor ax, ax
    xor bx, bx
    mov ax, x1
    mov bx, x2
    cmp bx, ax

    jb CAMXN
    jmp CAMXP

    CAMXN:
        sub ax, bx
        mov camX, ax

        xor ax, ax
        mov ax, -1
        mov incX, ax

        xor cx, cx
        xor dx, dx
        mov cx, y1
        mov dx, y2  
        cmp dx, cx

        jb CAMYN
        jmp CAMYP   

    CAMXP:
        sub bx, ax
        mov camX, bx

        xor ax, ax
        mov ax, 1
        mov incX, 1

        xor cx, cx
        xor dx, dx 
        mov cx, y1
        mov dx, y2  
        cmp dx, cx

        jb CAMYN
        jmp CAMYP 

    CAMYN:
        sub cx, dx
        mov camY, cx

        xor ax, ax
        mov ax, -1
        mov incY, ax

        jmp COMCAM
    
    CAMYP:
        sub dx, cx
        mov camY, dx

        xor ax, ax
        mov ax, 1
        mov incY, ax

        jmp COMCAM

    COMCAM:
        xor ax, ax
        xor bx, bx
        mov ax, camX    
        mov bx, camY    
        cmp ax, bx
        ja CAMXMAYOR
        jmp CAMYMAYOR

    CAMXMAYOR:
        add bx, bx
        mov inc2, bx

        sub bx, ax
        mov e, ax

        xor ax, ax
        xor bx, bx
        mov ax, camX
        mov bx, camY
        sub bx, ax
        add bx, bx
        mov inc1, bx

        xor si, si
        xor di, di
        mov si, 0
        mov di, camX

        FOR1:
            cmp si, di
            ja ENDCOMCAM

            xor bx, bx
            mov bx, e
            cmp e, 0
            jge FOR1E1 
            jmp FOR1E2

            FOR1E1:
                xor cx, cx
                xor dx, dx 
                mov cx, incY
                mov dx, yi
                add cx, dx
                mov yi, cx

                xor cx, cx
                xor dx, dx 
                mov cx, e
                mov dx, inc1
                add cx, dx
                mov e, cx

                xor cx, cx
                xor dx, dx 
                mov cx, xi
                mov dx, incX
                add cx, dx
                mov xi, cx

                pintarColor xi, yi, 14

                inc si
                jmp FOR1

            FOR1E2:
                ; e += inc2
                xor cx, cx
                xor dx, dx 
                mov cx, e
                mov dx, inc2
                add cx, dx
                mov e, cx

                ; xi += incx
                xor cx, cx
                xor dx, dx 
                mov cx, xi
                mov dx, incX
                add cx, dx
                mov xi, cx

                pintarColor xi, yi, 14

                inc si
                jmp FOR1

    
    CAMYMAYOR:
        add ax, ax
        mov inc2, ax

        sub ax, bx
        mov e, bx

        xor ax, ax
        xor bx, bx
        mov ax, camX
        mov bx, camY
        sub ax, bx
        add ax, ax
        mov inc1, ax


        ; CONDICION FOR si <= di (camY)
        xor si, si
        xor di, di
        mov si, 0
        mov di, camY

        FOR2:
            ; CONDICION FOR si <= di (camX)
            cmp si, di
            ja ENDCOMCAM

            ; CONDICION IF - ELSE  e >= 0
            xor bx, bx
            mov bx, e
            cmp e, 0
            jge FOR2E1  ; e >= 0
            jmp FOR2E2  ; else

            FOR2E1:
                
                xor cx, cx
                xor dx, dx 
                mov cx, incX
                mov dx, xi
                add cx, dx
                mov xi, cx

                
                xor cx, cx
                xor dx, dx 
                mov cx, e
                mov dx, inc1
                add cx, dx
                mov e, cx

                
                xor cx, cx
                xor dx, dx 
                mov cx, yi
                mov dx, incY
                add cx, dx
                mov yi, cx

                pintarColor xi, yi, 14

                inc si
                jmp FOR2

            FOR2E2:
                ; e += inc2
                xor cx, cx
                xor dx, dx 
                mov cx, e
                mov dx, inc2
                add cx, dx
                mov e, cx

                ; yi += incy
                xor cx, cx
                xor dx, dx 
                mov cx, yi
                mov dx, incY
                add cx, dx
                mov yi, cx

                pintarColor xi, yi, 14

                inc si
                jmp FOR2

    ENDCOMCAM:
        
endm

pintarColor macro cordX, cordY, color
    mov ah, 0ch     ;AH = 0CH
    mov al, color   ;AL = Valor del color a usar.
    mov bh, 0       ;BH = Página de vídeo donde EscribirArchivo el carácter.
    mov cx, cordX   ;CX = Columna donde EscribirArchivo el pixel (coordenada gráfica x)
    mov dx, cordY   ;DX = Fila donde EscribirArchivo el pixel (coordenada gráfica y).
    int 10h
endm


graficaLinea macro bufferValores, bufferFrecuencia, tamanoF
    local PIVOTE
    INI_VIDEO
    

    pintar_marco 39d, 619, 49, 429, 15d
    getAnchoLinea anchoLinea2, tamanoF

    mov bx, contadorGrafica ; limpiar contadorGrafica
    mov bx, 0
    mov contadorGrafica, bx


    mov bx, posArreglo ; limpiar posArreglo
    mov bx, 0
    mov posArreglo, bx

    mov bx, xi ; definir pos inicial
    mov bx, 40
    mov xi, bx

    mov bx, xf ; definir un pos final inicial
    mov bx, 40
    mov xf, bx

    PIVOTE:
        
        ;obtener posicion del array
        mov dx, posArreglo
        mov di, dx
        add dx, 2
        mov posArreglo, dx
        
        ;obtiene el pixel siguiente a graficar del ancho
        mov bx, xf
        add bx, anchoLinea2
        mov xf, bx
    
        ;obtiene alto de grafica
        getAlto yi, bufferFrecuencia[di]
        getAlto yf, bufferFrecuencia[di+2]

        ;imprime linea segun coordenada
        bresenham xi, yi, xf, yf
            
        xor bx, bx
        mov bx, xf
        mov xi, bx

        inc contadorGrafica
        mov bx, contadorGrafica
        cmp bx, tamanoGraficaLinea
        jnz PIVOTE ;fin ciclo
    
    mover_cursor 0,0
    print msjOrdenaNo
    imprimirLeyendaVertical bufferFrecuencia
    imprimirLeyendaAbajoL bufferValores
                
    
    getChar
    FIN_VIDEO

endm

;=================COMPARACION DE COMANDOS=============================
lecturaComando macro comando
    LOCAL END_CR, R_COMMAND, R_PATH
    LimpiarPath bufferentrada   ; PATH
    LimpiarPath buffercomando  ; COMANDO

    xor si, si
    xor di, di 

    R_COMMAND:
        cmp comando[si], 36 ; $
        je END_CR
        cmp comando[si], 32 ; ' ' 
        je R_PATH


        mov al, comando[si]
        mov buffercomando[si], al

        inc si
        jmp R_COMMAND

    R_PATH:
        inc si 
        cmp comando[si], 36 ; $
        je END_CR

        mov al, comando[si]
        mov bufferentrada[di], al

        inc di 
        jmp R_PATH

    END_CR:

endm

compararCadena macro buffer, command
    LOCAL END_COMP, COMP, NO_IGUALES

    mov cx, LENGTHOF  buffer
    xor si, si
    mov ah, 1

    COMP:
        cmp buffer[si], 0 
        je END_COMP

        mov al, buffer[si]
        cmp al, command[si]
        jne NO_IGUALES

        inc si 
        LOOP COMP

    NO_IGUALES:
        mov ah, 0

    END_COMP:
endm

LimpiarPath macro buffer

    LOCAL Repetir

    xor si,si
    xor cx,cx

    mov cx,LENGTHOF buffer

    Repetir:
        mov buffer[si], 0
        inc si
        Loop Repetir

endm

clearArray macro buffer, length
	LOCAL INICIO,FIN
	PUSH SI
	PUSH CX
	xor si,si
	xor cx,cx
	mov cx,length
	INICIO:
		cmp si,cx
		je FIN
		mov [buffer+si],'$'
		inc si
		jmp INICIO
	FIN:
	POP CX
	POP SI
endm


;===============MACROS PARA REPORTE==================
CrearArchivo macro buffer,handle
    LOCAL ERROR, FIN
    mov ah, 3ch
    mov cx, 00h
    lea dx, buffer
    int 21h
    jc ERROR
    mov handle,ax

    jmp FIN
    ERROR:
        print errorCreateFile
    FIN:
endm

agregarTextoBuffer macro bufferRead, buffer
    LOCAL GETEXT
    push si
    push di

    xor si, si
    xor di, di
    mov di, indice
    mov cx, LENGTHOF bufferRead

    GETEXT:
        mov al, bufferRead[si]
        mov buffer[di], al
        inc si
        inc di
        LOOP GETEXT
        
        mov indice, di
    pop di
    pop si
endm

getNumero16 macro Regis, buffer
    LOCAL zero,noz
    push di
    push si

    mov bx,4
    xor ax,ax
    mov ax,Regis
    mov cx,10
    mov di, indice

    zero:
        xor dx,dx
        div cx
        push dx
        dec bx
        jnz zero
        xor bx,4

    noz:
        pop dx
        
        add dl, 48
        mov buffer[di], dl
        inc di

        dec bx
        jnz noz
        mov indice, di
        
        pop si
        pop di
endm

getNumero8 macro Regis, buffer
    LOCAL zero,noz

    mov bx,2
    xor ax,ax       
    mov al,Regis    
    mov cx,10       
    mov di, indice

    zero:
        xor dx,dx
        div cx      ; ax/cx
        push dx
        dec bx
        jnz zero
        xor bx,2

    noz:
        pop dx
        
        add dl, 48
        mov buffer[di], dl
        inc di

        dec bx
        jnz noz
        mov indice, di

endm

obtenerFecha macro buffer
    mov ah, 02ah
    int 21h

    mov anio, cx
    mov mes, dh
    mov dia_mes, dl 

    agregarTextoBuffer msgFecha, buffer   

    getNumero8 dia_mes, buffer
    agregarTextoBuffer msgDiagonal, buffer     
    getNumero8 mes, buffer
    agregarTextoBuffer msgDiagonal, buffer     
    getNumero16 anio, buffer

    
    mov ah, 2ch
    int 21h

    mov horas, ch
    mov minutos, cl
    mov segundos, dh  

    agregarTextoBuffer msgHora, buffer   

    getNumero8 horas, buffer
    agregarTextoBuffer msgDospuntos, buffer    
    getNumero8 minutos, buffer
    agregarTextoBuffer msgDospuntos, buffer   
    getNumero8 segundos, buffer

endm


EscribirArchivo macro handle, bufferRead, num
    LOCAL ERROR, FIN
    mov ah, 40h
    mov bx, handle
    mov cx, num
    lea dx, offset bufferRead
    int 21h
    jc ERROR

    JMP FIN

    ERROR:
        print errorReadFile

    FIN:

endm