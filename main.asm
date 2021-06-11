include ope.asm
include macrop.asm
include aLexico.asm
include Archivo.asm

;================   SEGMENTO DE DATOS   =========================
.model small    ;declaracion de programas
.stack          ;declaracion de stack
.data           ;declaracion de datos

vcadena			db 100 dup(0)
vcomando		db 100 dup('$')
vPath           db 100 dup('$')
vNumeros        dw 1050 dup('$')

;========comandos===============
bufferentrada           db 50 dup('$'), 0
buffercomando           db 50 dup('$'), 0


temp                    dw 0
newLine                 db 0ah, 0dh,    ' ', '$'
saltoLinea              db ' ', 0Ah, 0dh
; ============= mensajes=================
msjCaratula		        db 0ah, 0dh,    'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1', 10, 13, 
									'SECCION A', 10, 13, 
                                    'PRIMER SEMESTRE 2021', 10, 13, 
                                    'NOMBRE: JOSE FRANCISCO SANTOS', 10, 13, 
									'CARNE: 201643762 ', 10, 13,
                                    'PROYECTO 2 ASSEMBLER', 10, 13,  '$'

    msjError         db 'Error', '$'
    msjArchivoC         db 'txt creado', '$'

    msjDatos db     'NOMBRE: JOSE FRANCISCO SANTOS', 10, 13, 
					'CARNE: 201643762 ', 10, 13,
                                    
    msjConsola      db 0ah, 0dh,   'consola1>', '$'

    msjErrorAnalisis db 0ah, 0dh,   'Error de analisis archivo', '$' 
    msjAnalisis db 0ah, 0dh,   'Analisis de archivo completa', '$'
    msjEsperar db 0ah, 0dh,   'Esto puede demorar, espere por favor', '$' 
    msjTablaFrecuencia      db 0ah, 0dh,   'Tabla Frecuencia'
    msjOrdenaNo      db 0ah, 0dh,   'Eje X=No.  Eje Y=Frecuencia.  Ordenado por No.', '$'  
    msjOrdenaFAsc      db 0ah, 0dh,   'Eje X=No.  Eje Y=Frecuencia.  Ordenado por Frecuencia Asc', '$' 
    msjOrdenaFDesc      db 0ah, 0dh,   'Eje X=No.  Eje Y=Frecuencia.  Ordenado por Frecuencia Desc.', '$'

;===============opciones comando========================
    op_cprom        db 'cprom'
    op_cmediana    db 'cmediana'
    op_cmoda        db 'cmoda'
    op_cmax        db 'cmax'
    op_cmin        db 'cmin'
    op_gbarra_asc    db 'gbarra_asc'
    op_gbarra_desc    db 'gbarra_desc'
    op_ghist        db 'ghist'
    op_glinea        db 'glinea'
    op_abrir        db 'abrir'
    op_limpiar        db 'limpiar'
    op_reporte        db 'reporte'
    op_info        db 'info'
    op_salir        db 'salir'

;===============ARCHIVO=============
    errorCreateFile DB 0Ah, 0Ah, 09h, 09h, 'ERROR, Crear archivo... $'
    errorCloseFile  DB 0Ah, 0Ah, 09h, 09h, 'ERROR, Cerrar Archivo... $'
    errorOpenFile   DB 0Ah, 0Ah, 09h, 09h, 'ERROR, Abrir Archivo... $'
    errorReadFile   DB 0Ah, 0Ah, 09h, 09h, 'ERROR, Leer archivo... $'
    errorWriteFile  DB 0Ah, 0Ah, 09h, 09h, 'ERROR, Escribir Archivo... $'
    okCreateFile  DB 0Ah, 0Ah, 09h, 09h, 'ERROR, Escribir Archivo... $'

    bufferContenido DB 29999 DUP('$'), '$'
    manejador	  	DW ?

;=========PROMEDIO============
    tamano dw 0
    pos dw 0
    entero dw 0
    decimal dw 0
    ultimoVal dw 0
    posArr dw 0
    num1 dw 0 ;MEDIANA
    num2 dw 0 ;MEDIANA
    median dw 0 ; resultado de mediana
    decMedian dw 0; decimal de la media
    prom dw 0 ;  entero de promedio
    decProm dw 0; decimal de promedio
    moda dw 0
    numMinimo dw 0
    numMaximo dw 0
    resultado dw 0
    cont            dw 0
    contTemp        dw 0

    punto db "."
    posArregloNumero dw 0

    ;===================ARREGLOS DE TABLA DE FRECUENCIA=========
    vFrecuencia     dw 2200 dup('$')
    vValores     dw 2200 dup('$')


    ;========MODO VIDEO=======
    ;modovideo
  
    anchoLineaLeyenda 		db 0
    anchoLineaLeyendaDist 		db 0
    AltoLineaLeyendaDist 		db 0
    AltoLineaLeyenda db 3
    anchoLinea2		dw 0
    tamanoAltoLinea dw 0
    distanciaLinea  dw 0
    
    
    numeroMayor     dw 0
    posArreglo      dw 0
    tamanoArrFrecuencia dw 0
    posInicioVertical db 27

    ;============variables grafica de barra
    camX    dw ?
    camY    dw ?
    incX    dw 1
    incY    dw 1
    inc1    dw ?
    inc2    dw ?
    e        dw ?

    xi        dw 20
    xf        dw 109

    yi        dw 250
    yf        dw 39

    x        dw ?
    y        dw ?

    tamanoGraficaLinea dw 0


    ;===============valores minimos y maximos
    valorMayor dw 0
    valorMenor dw 0
    ;=============GRAFICA BARRAS=============
    posInicial  dw 30
    posFinal     dw 30
    contadorGrafica dw 0
    temp1            dw 0


    ;==========REPORTE=============
    msgFecha        db ' Fecha: '
    msgHora            db ' Hora: '
    msgDospuntos    db ':'
    msgDiagonal        db '/'

    pathOut            db '201643762.txt', 0
    txtModa            db ' MODA  '
    txtMediana            db ' MEDIANA  '
    txtPromedio            db ' PROMEDIO  '
    txtMaximo           db ' MAXIMO  '
    txtMinimo           db ' MINIMO  '
    indice            dw 0

    handlerentrada         dw ?

    horas         DB ?
    minutos     DB ?
    segundos     DB ?

    dia_mes     DB ?
    mes         DB ?
    anio         DW ?

    ;=========SIMBOLOS========
    guion       db '-----'
    orBarra         db '|'
    separadores     db '     '

.code

getDatos proc
    ;promedio
    promedio vNumeros
    agregarTextoBuffer txtPromedio, bufferContenido
    getNumero16 prom, bufferContenido
    agregarTextoBuffer punto, bufferContenido
    getNumero16 decProm, bufferContenido
    agregarTextoBuffer saltoLinea, bufferContenido

    ;mediana
    mediana vNumeros
    agregarTextoBuffer txtMediana, bufferContenido
    getNumero16 median, bufferContenido
    agregarTextoBuffer punto, bufferContenido
    getNumero16 decMedian, bufferContenido
    agregarTextoBuffer saltoLinea, bufferContenido

    ;moda
    frecuencia vNumeros
    funcionModa tamanoArrFrecuencia
    agregarTextoBuffer txtModa, bufferContenido
    getNumero16 moda, bufferContenido
    agregarTextoBuffer saltoLinea, bufferContenido

    ;minNum
    ordenamiento_bubblesort_asc vNumeros, tamano
    xor bx, bx
    mov bx, vNumeros[0]
    mov valorMenor, bx
    agregarTextoBuffer txtMinimo, bufferContenido
    getNumero16 valorMenor, bufferContenido
    agregarTextoBuffer saltoLinea, bufferContenido

    ;MaxNum
    ordenamiento_bubblesort_desc vNumeros, tamano
    xor bx, bx
    mov bx, vNumeros[0]
    mov valorMayor, bx
    agregarTextoBuffer txtMaximo, bufferContenido
    getNumero16 valorMayor, bufferContenido
    agregarTextoBuffer saltoLinea, bufferContenido
    ret
getDatos endp


mov dx,@data   ;la cadena esta en el segmento de data
mov ds,dx
main proc ; inicio codigo
    
    INICIO:
    
    clearArray vcomando, SIZEOF vcomando ;limpiamos la variable comando
    print msjConsola
    leerCadena vcomando

    ;Lectura de comando
    lecturaComando vcomando

    
    ;comprobaciones de comando
    
    compararCadena buffercomando, op_cprom ;comando cprom
    cmp ah, 1
    je PROME
    ; cmediana
    compararCadena buffercomando, op_cmediana
    cmp ah, 1
    je MDIANA
    ; cmoda
    compararCadena buffercomando, op_cmoda
    cmp ah, 1
    je MODACOMANDO

    ; cmax
    compararCadena buffercomando, op_cmax
    cmp ah, 1
    je MAXCOMANDO
    ; cmin
    compararCadena buffercomando, op_cmin
    cmp ah, 1
    je MINCOMANDO
    ; gbarra_asc
    compararCadena buffercomando, op_gbarra_asc
    cmp ah, 1
    je GRAPASC
    ; gbarra_des
    compararCadena buffercomando, op_gbarra_desc
    cmp ah, 1
    je GRAPDESC
    ; ghist
    compararCadena buffercomando, op_ghist
    cmp ah, 1
    je GRAPHIST
    ; glinea
    compararCadena buffercomando, op_glinea
    cmp ah, 1
    je GRAPLINEA
    
    ; abrir
    compararCadena buffercomando, op_abrir
    cmp ah, 1
    je LECTURAARC

    compararCadena buffercomando, op_limpiar
    cmp ah, 1
    je LIMPEZAP
            
    compararCadena buffercomando, op_reporte
    cmp ah, 1
    je REPORTE
            
    ; info
    compararCadena buffercomando, op_info
    cmp ah, 1
    je INFO
    ; salir --------------------------
    compararCadena buffercomando, op_salir
    cmp ah, 1
    je SALIR



    print msjError
    
    jmp INICIO

    PROME:
        promedio vNumeros
        
        JMP INICIO

    REPORTE:
        CrearArchivo pathOut, handlerentrada
        clearArray bufferContenido, SIZEOF bufferContenido
        print msjEsperar
        mov indice, 0
        obtenerFecha bufferContenido
        agregarTextoBuffer msjDatos, bufferContenido
        agregarTextoBuffer saltoLinea, bufferContenido ; salto linea
        frecuencia vNumeros
        imprimirTablaFrecuencia vValores, vFrecuencia
        call getDatos
        EscribirArchivo handlerentrada, bufferContenido, indice
        cerrarArchivo handlerentrada
        print msjArchivoC
        JMP INICIO

    MAXCOMANDO:
        ordenamiento_bubblesort_desc vNumeros, tamano
        xor bx, bx
        mov bx, vNumeros[0]
        mov valorMayor, bx
        print msjConsola
        ImprimirN16 valorMayor
        print newLine

        JMP INICIO

    GRAPASC:
        frecuencia vNumeros
        ordenamientoTablaFrecuenciaDesc vFrecuencia, vValores
        mov bx, vFrecuencia[0]
        mov numeroMayor, bx
        xor bx, bx

        ordenamientoTablaFrecuenciaAsc vFrecuencia, vValores
        graficarBarras vFrecuencia, vValores, msjOrdenaFAsc

        JMP INICIO

    GRAPDESC:
        frecuencia vNumeros
        ordenamientoTablaFrecuenciaDesc vFrecuencia, vValores
        mov bx, vFrecuencia[0]
        mov numeroMayor, bx
        xor bx, bx

        graficarBarras vFrecuencia, vValores, msjOrdenaFDesc

        JMP INICIO
    

    GRAPHIST:
        frecuencia vNumeros
        ordenamientoTablaFrecuenciaDesc vFrecuencia, vValores
        mov bx, vFrecuencia[0]
        mov numeroMayor, bx
        xor bx, bx

        frecuencia vNumeros
        graficarBarras vFrecuencia, vValores, msjOrdenaNo

        JMP INICIO

    GRAPLINEA:
        frecuencia vNumeros
        ordenamientoTablaFrecuenciaDesc vFrecuencia, vValores
        mov bx, vFrecuencia[0]
        mov numeroMayor, bx
        xor bx, bx

        frecuencia vNumeros
        graficaLinea vValores, vFrecuencia, tamanoArrFrecuencia

        JMP INICIO

    
    MINCOMANDO:
        ordenamiento_bubblesort_asc vNumeros, tamano
        xor bx, bx
        mov bx, vNumeros[0]
        mov valorMenor, bx
        print msjConsola
        ImprimirN16 valorMenor
        print newLine

        JMP INICIO
    
    INFO:
        print msjCaratula
        JMP INICIO


    LECTURAARC:
        ;Limpieza de datos
        mov posArregloNumero, 0
        mov tamano, 0
        cleanDWarray vNumeros, SIZEOF vNumeros
        print msjEsperar
        abrirArchivo 	bufferentrada, manejador
	    leerArchivo		bufferContenido, SIZEOF bufferContenido, manejador
	    cerrarArchivo	manejador
        Analisisarchivo bufferContenido
        clearArray bufferContenido, SIZEOF bufferContenido ;limpieza numero
        jmp INICIO

    LIMPEZAP:
        limpiarPantalla
        jmp INICIO

    MDIANA:
        mediana vNumeros
        
        jmp INICIO
    
    MODACOMANDO:
        frecuencia vNumeros
        funcionModa tamanoArrFrecuencia
        
        jmp INICIO
        

    SALIR:
        mov ah,4ch
        int 21h

main  endp              ;Termina proceso
end main