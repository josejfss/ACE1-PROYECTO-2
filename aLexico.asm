Analisisarchivo macro archivo
    LOCAL S0I,S1I,S2I,S3I,S4I,S5I,S6I,S7I,S8I, S0INTER, S1INTER, S2,S3,S4,S5,S6,S7, SC0,SC1,SC2,SC3,SC4,SC5,SC6,SC7, S1F,S2F,S3F,S4F,S5F,S6F,S7F,S8F, END_ANALIZADOR, SERROR, A1,A2,A3, UNIDADES, DECENAS, CENTENAS
    xor si, si
    xor di, di 

    
    S0I: 
        cmp archivo[si], 36 ; $
        je END_ANALIZADOR

        cmp archivo[si], 60
        je S1I

        jmp SERROR

    S1I: 
        inc si
        cmp archivo[si], 78
        je S2I

        cmp archivo[si], 110
        je S2I

        jmp SERROR

    S2I: 
        inc si
        cmp archivo[si], 85
        je S3I

        cmp archivo[si], 117
        je S3I

        jmp SERROR

    S3I: 
        inc si
        cmp archivo[si], 77
        je S4I

        cmp archivo[si], 109
        je S4I

        jmp SERROR

    S4I: 
        inc si
        cmp archivo[si], 69
        je S5I

        cmp archivo[si], 101
        je S5I

        jmp SERROR

    S5I: 
        inc si
        cmp archivo[si], 82
        je S6I

        cmp archivo[si], 114
        je S6I
        
        jmp SERROR

    S6I: 
        inc si
        cmp archivo[si], 79
        je S7I

        cmp archivo[si], 111
        je S7I

        jmp SERROR

    S7I: 
        inc si
        cmp archivo[si], 83
        je S8I

        cmp archivo[si], 115
        je S8I

        jmp SERROR 
    
    S8I: 
        inc si
        cmp archivo[si], 62
        je S0INTER

        jmp SERROR

    
    
    S0INTER:
        inc si

        cmp archivo[si], 13
        je S0INTER
        cmp archivo[si], 10
        je S0INTER
        cmp archivo[si], 32 
        je S0INTER
        cmp archivo[si], 09 
        je S0INTER

        cmp archivo[si], 60
        je S1INTER

        jmp SERROR

    S1INTER: 

        inc si
        cmp archivo[si], 47
        je S1F

        cmp archivo[si], 78
        je S2

        cmp archivo[si], 110
        je S2

        jmp SERROR

    ; UMERO

    S2: 
        inc si
        cmp archivo[si], 85
        je S3

        cmp archivo[si], 117
        je S3

        jmp SERROR

    S3: 
        inc si
        cmp archivo[si], 77
        je S4

        cmp archivo[si], 109
        je S4

        jmp SERROR

    S4: 
        inc si
        cmp archivo[si], 69
        je S5

        cmp archivo[si], 101 
        je S5

        jmp SERROR

    S5: 
        inc si
        cmp archivo[si], 82 
        je S6

        cmp archivo[si], 114 
        je S6
        
        jmp SERROR

    S6: 
        inc si
        cmp archivo[si], 79 
        je S7

        cmp archivo[si], 111 
        je S7

        jmp SERROR
    
    S7: 
        xor di, di

        inc si
        cmp archivo[si], 62 
        je A1

        jmp SERROR

    A1: 
        inc si

        cmp archivo[si], 48 
        jb SERROR
        cmp archivo[si], 57 
        ja SERROR

        xor ax, ax
        mov al, archivo[si]
        sub al, 48
        push ax

        jmp A2

    A2: 
        inc si

        cmp archivo[si], 60 
        je UNIDADES

        cmp archivo[si], 48 
        jb SERROR
        cmp archivo[si], 57 
        ja SERROR

        xor ax, ax
        mov al, archivo[si]
        sub al, 48
        push ax

        jmp A3

    A3: 
        inc si

        cmp archivo[si], 60 
        je DECENAS

        cmp archivo[si], 48 
        jb SERROR
        cmp archivo[si], 57 
        ja SERROR

        xor ax, ax
        mov al, archivo[si]
        sub al, 48
        push ax

        inc si
        cmp archivo[si], 60
        je CENTENAS

    UNIDADES:
        xor ax, ax
        mov num1, ax
        ; unidad 
        pop ax
        mov num1, ax
        jmp SC0

    DECENAS:
        xor ax, ax
        mov num1, ax
        xor bx, bx
        xor cx, cx
        ; unidades
        pop cx
        ; decena
        xor bx, bx
        pop bx
        mov ax, 10
        mul bl

        add cx, ax

        mov num1, cx
        jmp SC0

    CENTENAS:
        xor ax, ax
        mov num1, ax
        xor bx, bx
        xor cx, cx

        ; unidades
        pop cx
        ; decena
        xor bx, bx
        pop bx
        mov ax, 10
        mul bl

        add cx, ax 

        ; decena
        xor ax, ax
        xor bx, bx
        pop bx
        mov ax, 100
        mul bl
        
        add cx, ax 

        mov num1, cx

        jmp SC0

    SC0: 
        IngresarNumeros num1

        inc si
        cmp archivo[si], 47
        je SC1

        jmp SERROR

    SC1: 
        inc si
        cmp archivo[si], 78
        je SC2

        cmp archivo[si], 110
        je SC2

        jmp SERROR

    SC2: 
        inc si
        cmp archivo[si], 85
        je SC3

        cmp archivo[si], 117 
        je SC3

        jmp SERROR

    SC3: 
        inc si
        cmp archivo[si], 77 
        je SC4

        cmp archivo[si], 109 
        je SC4

        jmp SERROR

    SC4: 
        inc si
        cmp archivo[si], 69
        je SC5

        cmp archivo[si], 101 
        je SC5

        jmp SERROR

    SC5: 
        inc si
        cmp archivo[si], 82 
        je SC6

        cmp archivo[si], 114 
        je SC6
        
        jmp SERROR

    SC6: 
        inc si
        cmp archivo[si], 79 
        je SC7

        cmp archivo[si], 111
        je SC7

        jmp SERROR

    SC7: 
        inc si
        cmp archivo[si], 62 
        je S0INTER

        jmp SERROR

    ; <NUMEROS> 

    S1F: 
        inc si
        cmp archivo[si], 78 
        je S2F

        cmp archivo[si], 110 
        je S2F

        jmp SERROR

    S2F: 
        inc si
        cmp archivo[si], 85
        je S3F

        cmp archivo[si], 117
        je S3F

        jmp SERROR

    S3F: 
        inc si
        cmp archivo[si], 77 
        je S4F

        cmp archivo[si], 109
        je S4F

        jmp SERROR

    S4F: 
        inc si
        cmp archivo[si], 69 
        je S5F

        cmp archivo[si], 101 
        je S5F

        jmp SERROR

    S5F: 
        inc si
        cmp archivo[si], 82 
        je S6F

        cmp archivo[si], 114 
        je S6F
        
        jmp SERROR

    S6F: 
        inc si
        cmp archivo[si], 79 
        je S7F

        cmp archivo[si], 111 
        je S7F

        jmp SERROR

    S7F: 
        inc si
        cmp archivo[si], 83 
        je S8F

        cmp archivo[si], 115 
        je S8F

        jmp SERROR 
    
    S8F: 
        inc si
        cmp archivo[si], 62 
        je END_ANALIZADOR

        jmp SERROR

    
    SERROR:
        print msjErrorAnalisis
        jmp END_ANALIZADOR

    END_ANALIZADOR:
        print msjAnalisis
        
endm