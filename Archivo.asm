abrirArchivo MACRO path, handle

    LOCAL ERROR, FIN

    MOV ah, 3dh
    MOV al, 10b
    LEA dx, path
    INT 21h
    MOV handle, ax
    JC    ERROR 
    JNC    FIN

    ERROR:
        imprimir errorOpenFile
        JMP FIN

    FIN:

ENDM

cerrarArchivo MACRO handle

    LOCAL ERROR, FIN

    MOV ah, 3eh
    MOV handle, bx
    INT 21h
    JC  ERROR 
    JNC FIN

    ERROR:
        imprimir errorCloseFile
        JMP FIN

    FIN:

ENDM

leerArchivo MACRO buffer, size, handle
    LOCAL ERROR, FIN

    MOV ah, 3fh
    MOV bx, handle
    MOV cx, size
    LEA dx, buffer
    INT 21h
    JC     ERROR 
    JNC FIN

    ERROR:
        imprimir errorReadFile
        JMP FIN

    FIN:

ENDM