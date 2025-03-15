; TEAM PAMBACODE
; ESTE CÓDIGO MUESTRA UN MENSAJE EN UN DISPLAY LCD 16x2 Y REALIZA UNA ANIMACIÓN SIMPLE EN PANTALLA
; SE IMPRIMIRÁ EL MENSAJE EN AMBAS LÍNEAS DEL LCD Y SE EJECUTARÁ UN RETARDO PARA VISUALIZARLO,
; LUEGO SE REALIZARÁ UNA ANIMACIÓN EN LA PANTALLA GRÁFICA DEL SIMULADOR.
; 2025/03/09 - V.3.0.0
; TRABAJARON: CESAR ARTURO / CesarDAlvin | SARA CRYSTEL / Sara130401 | CERON DAUZON / Juryelcd

	JMP boot	; Salta a la etiqueta 'boot' para iniciar el programa

; Constantes
stackTop    EQU 0xFF    ; Puntero inicial de la pila
txtDisplay  EQU 0x2E0   ; Dirección de memoria de la pantalla de texto
vslDisplay  EQU 0x300   ; Dirección de memoria de la pantalla visual

; Definición de datos
hello:	
	DB "Hello World!"	; Cadena de texto a imprimir
	DB 0				; Terminador de cadena (carácter nulo)

sprite: 
	DB "\xFF\xFF\xFF\xFF\xFF\xC4\xC4\xC4"	; Datos del sprite (16x16)
	DB "\xC4\xC4\xFF\xFF\xFF\xFF\xFF\xFF"
	DB "\xFF\xFF\xFF\xFF\xC4\xC4\xC4\xC4"
	DB "\xC4\xC4\xC4\xC4\xC4\xFF\xFF\xFF"
	DB "\xFF\xFF\xFF\xFF\x8C\x8C\x8C\xF4"
	DB "\xF4\x8C\xF4\xFF\xFF\xFF\xFF\xFF"
	DB "\xFF\xFF\xFF\x8C\xF4\x8C\xF4\xF4"
	DB "\xF4\x8C\xF4\xF4\xF4\xFF\xFF\xFF"
	DB "\xFF\xFF\xFF\x8C\xF4\x8C\x8C\xF4"
	DB "\xF4\xF4\x8C\xF4\xF4\xF4\xFF\xFF"
	DB "\xFF\xFF\xFF\x8C\x8C\xF4\xF4\xF4"
	DB "\xF4\x8C\x8C\x8C\x8C\xFF\xFF\xFF"
	DB "\xFF\xFF\xFF\xFF\xFF\xF4\xF4\xF4"
	DB "\xF4\xF4\xF4\xF4\xFF\xFF\xFF\xFF"
	DB "\xFF\xFF\xFF\xFF\x8C\x8C\xC4\x8C"
	DB "\x8C\x8C\xFF\xFF\xFF\xFF\xFF\xFF"
	DB "\xFF\xFF\xFF\x8C\x8C\x8C\xC4\x8C"
	DB "\x8C\xC4\x8C\x8C\x8C\xFF\xFF\xFF"
	DB "\xFF\xFF\x8C\x8C\x8C\x8C\xC4\xC4"
	DB "\xC4\xC4\x8C\x8C\x8C\x8C\xFF\xFF"
	DB "\xFF\xFF\xF4\xF4\x8C\xC4\xF4\xC4"
	DB "\xC4\xF4\xC4\x8C\xF4\xF4\xFF\xFF"
	DB "\xFF\xFF\xF4\xF4\xF4\xC4\xC4\xC4"
	DB "\xC4\xC4\xC4\xF4\xF4\xF4\xFF\xFF"
	DB "\xFF\xFF\xF4\xF4\xC4\xC4\xC4\xC4"
	DB "\xC4\xC4\xC4\xC4\xF4\xF4\xFF\xFF"
	DB "\xFF\xFF\xFF\xFF\xC4\xC4\xC4\xFF"
	DB "\xFF\xC4\xC4\xC4\xFF\xFF\xFF\xFF"
	DB "\xFF\xFF\xFF\x8C\x8C\x8C\xFF\xFF"
	DB "\xFF\xFF\x8C\x8C\x8C\xFF\xFF\xFF"
	DB "\xFF\xFF\x8C\x8C\x8C\x8C\xFF\xFF"
	DB "\xFF\xFF\x8C\x8C\x8C\x8C\xFF\xFF"

; Programa principal
boot:
	MOV SP, stackTop	; Inicializa el puntero de la pila

	; Imprime "Hello World!" en la pantalla de texto
	MOV C, hello		; Apunta el registro C a la cadena "Hello World!"
	MOV D, txtDisplay	; Apunta el registro D a la pantalla de texto
	CALL print			; Llama a la subrutina para imprimir

	; Dibuja el sprite en la pantalla visual
	MOV C, sprite		; Apunta el registro C al sprite
	MOV D, vslDisplay	; Apunta el registro D a la pantalla visual
	CALL draw_sprite	; Llama a la subrutina para dibujar el sprite

	HLT					; Detiene la ejecución del programa

; Subrutina para imprimir una cadena de texto
print:
	PUSH A				; Guarda el valor de A en la pila
	PUSH B				; Guarda el valor de B en la pila
	MOV B, 0			; Inicializa B en 0 (para comparar con el terminador)
.loop_print:
	MOVB AL, [C]		; Obtiene un carácter de la cadena (apuntada por C)
	MOVB [D], AL		; Escribe el carácter en la pantalla de texto (apuntada por D)
	INC C				; Incrementa C para apuntar al siguiente carácter
	INC D				; Incrementa D para apuntar a la siguiente posición en la pantalla
	CMPB BL, [C]		; Compara el carácter actual con el terminador (0)
	JNZ .loop_print		; Si no es el terminador, repite el bucle
	POP B				; Restaura el valor de B desde la pila
	POP A				; Restaura el valor de A desde la pila
	RET					; Retorna de la subrutina

; Subrutina para dibujar un sprite
draw_sprite:
	PUSH A				; Guarda el valor de A en la pila
	PUSH B				; Guarda el valor de B en la pila
.loop_draw:
	MOVB AL, [C]		; Obtiene un byte del sprite (apuntado por C)
	MOVB [D], AL		; Escribe el byte en la pantalla visual (apuntada por D)
	INC C				; Incrementa C para apuntar al siguiente byte del sprite
	INC D				; Incrementa D para apuntar a la siguiente posición en la pantalla
	CMP D, 0x400		; Compara D con el final de la memoria de la pantalla visual
	JNZ .loop_draw		; Si no ha llegado al final, repite el bucle
	POP B				; Restaura el valor de B desde la pila
	POP A				; Restaura el valor de A desde la pila
	RET					; Retorna de la subrutina
    
    delay:
    MOV A, 0xFF   ; Carga un valor grande en A
outer_loop:
    MOV B, 0xFF   ; Carga otro valor grande en B
inner_loop:
    DEC B         ; Decrementa B
    JNZ inner_loop ; Si B no es 0, sigue el bucle
    DEC A         ; Decrementa A
    JNZ outer_loop ; Si A no es 0, repite el bucle
    RET           ; Retorna de la subrutina
