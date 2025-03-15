; TEAM PAMBACODE
; ESTE CÓDIGO MUESTRA UN MENSAJE EN UN DISPLAY LCD 16x2 Y REALIZA UNA ANIMACIÓN SIMPLE EN PANTALLA
; SE IMPRIMIRÁ EL MENSAJE EN AMBAS LÍNEAS DEL LCD Y SE EJECUTARÁ UN RETARDO PARA VISUALIZARLO,
; LUEGO SE REALIZARÁ UNA ANIMACIÓN EN LA PANTALLA GRÁFICA DEL SIMULADOR.
; 2025/03/09 - V.2.0.2
; TRABAJARON: CESAR ARTURO / CesarDAlvin | SARA CRYSTEL / Sara130401 | CERON DAUZON / Juryelcd

JMP boot	; Salta a la etiqueta 'boot' para iniciar el programa

; Constantes
stackTop    EQU 0xFF    ; Puntero inicial de la pila
txtDisplay  EQU 0x2E0   ; Dirección de memoria de la pantalla de texto
vslDisplay  EQU 0x300   ; Dirección de memoria de la pantalla visual

; Definición de datos
Derecha:	
	DB "Mario mira      derecha  "	; Cadena de texto a imprimir
	DB 0				; Terminador de cadena (carácter nulo)
Izquierda:	
	DB "Mario mira      izquierda"	; Cadena de texto a imprimir
	DB 0				; Terminador de cadena (carácter nulo)

; Mario 1 (Mira a la derecha)
mario1:
	DB "\xFF\xFF\xFF\xFF\xFF\xC4\xC4\xC4\xC4\xC4\xFF\xFF\xFF\xFF\xFF\xFF"
	DB "\xFF\xFF\xFF\xFF\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xFF\xFF\xFF"
	DB "\xFF\xFF\xFF\xFF\x8C\x8C\x8C\xF4\xF4\x8C\xF4\xFF\xFF\xFF\xFF\xFF"
	DB "\xFF\xFF\xFF\x8C\xF4\x8C\xF4\xF4\xF4\x8C\xF4\xF4\xF4\xFF\xFF\xFF"
	DB "\xFF\xFF\xFF\x8C\xF4\x8C\x8C\xF4\xF4\xF4\x8C\xF4\xF4\xF4\xFF\xFF"
	DB "\xFF\xFF\xFF\x8C\x8C\xF4\xF4\xF4\xF4\x8C\x8C\x8C\x8C\xFF\xFF\xFF"
	DB "\xFF\xFF\xFF\xFF\xFF\xF4\xF4\xF4\xF4\xF4\xF4\xF4\xFF\xFF\xFF\xFF"
	DB "\xFF\xFF\xFF\xFF\x8C\x8C\xC4\x8C\x8C\x8C\xFF\xFF\xFF\xFF\xFF\xFF"
	DB "\xFF\xFF\xFF\x8C\x8C\x8C\xC4\x8C\x8C\xC4\x8C\x8C\x8C\xFF\xFF\xFF"
	DB "\xFF\xFF\x8C\x8C\x8C\x8C\xC4\xC4\xC4\xC4\x8C\x8C\x8C\x8C\xFF\xFF"
	DB "\xFF\xFF\xF4\xF4\x8C\xC4\xF4\xC4\xC4\xF4\xC4\x8C\xF4\xF4\xFF\xFF"
	DB "\xFF\xFF\xF4\xF4\xF4\xC4\xC4\xC4\xC4\xC4\xC4\xF4\xF4\xF4\xFF\xFF"
	DB "\xFF\xFF\xF4\xF4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xF4\xF4\xFF\xFF"
	DB "\xFF\xFF\xFF\xFF\xC4\xC4\xC4\xFF\xFF\xC4\xC4\xC4\xFF\xFF\xFF\xFF"
	DB "\xFF\xFF\xFF\x8C\x8C\x8C\xFF\xFF\xFF\xFF\x8C\x8C\x8C\xFF\xFF\xFF"
	DB "\xFF\xFF\x8C\x8C\x8C\x8C\xFF\xFF\xFF\xFF\x8C\x8C\x8C\x8C\xFF\xFF"

; Mario 2 (Mira a la izquierda)
mario2:
	DB "\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xC4\xC4\xC4\xC4\xC4\xFF\xFF\xFF"
	DB "\xFF\xFF\xFF\xFF\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xFF\xFF"
	DB "\xFF\xFF\xFF\xFF\xFF\xFF\xF4\x8C\xF4\xF4\x8C\x8C\x8C\xFF\xFF\xFF"
	DB "\xFF\xFF\xFF\xF4\xF4\xF4\x8C\xF4\xF4\xF4\x8C\xF4\x8C\xFF\xFF\xFF"
	DB "\xFF\xFF\xF4\xF4\xF4\xF4\x8C\xF4\xF4\xF4\x8C\x8C\xF4\x8C\xFF\xFF"
	DB "\xFF\xFF\xFF\x8C\x8C\x8C\x8C\xF4\x8C\x8C\xF4\xF4\xF4\xF4\xFF\xFF"
	DB "\xFF\xFF\xFF\xFF\xF4\xF4\xF4\xF4\xF4\xF4\xF4\xF4\xFF\xFF\xFF\xFF"
	DB "\xFF\xFF\xFF\xFF\xFF\xFF\x8C\x8C\x8C\x8C\xC4\x8C\x8C\xFF\xFF\xFF"
	DB "\xFF\xFF\xFF\x8C\x8C\x8C\x8C\xC4\x8C\x8C\xC4\x8C\x8C\x8C\xFF\xFF"
	DB "\xFF\xFF\x8C\x8C\x8C\x8C\x8C\xC4\xC4\xC4\xC4\x8C\x8C\x8C\x8C\xFF"
	DB "\xFF\xFF\xF4\xF4\x8C\xF4\x8C\xC4\xF4\xC4\xC4\xF4\xC4\x8C\xF4\xF4"
	DB "\xFF\xFF\xF4\xF4\xF4\xF4\xC4\xC4\xC4\xC4\xC4\xC4\xF4\xF4\xF4\xFF"
	DB "\xFF\xFF\xF4\xF4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xC4\xF4\xF4\xFF"
	DB "\xFF\xFF\xFF\xFF\xC4\xC4\xC4\xFF\xFF\xC4\xC4\xC4\xFF\xFF\xFF\xFF"
	DB "\xFF\xFF\xFF\x8C\x8C\x8C\xFF\xFF\xFF\xFF\x8C\x8C\x8C\xFF\xFF\xFF"
	DB "\xFF\xFF\x8C\x8C\x8C\x8C\xFF\xFF\xFF\xFF\x8C\x8C\x8C\x8C\xFF\xFF"
; Programa principal
boot:
	MOV SP, stackTop

.loop:
	; Dibuja el frame mario1
	MOV C, mario1
	MOV D, vslDisplay
	CALL draw_sprite
    
    ; Imprime "Derecha"
	MOV C, Derecha
	MOV D, txtDisplay
	CALL print

	; Retraso de 2 segundos
	CALL delay

	; Dibuja el frame mario2
	MOV C, mario2
	MOV D, vslDisplay
	CALL draw_sprite
    
    ; Imprime "Izquierda"
	MOV C, Izquierda
	MOV D, txtDisplay
	CALL print

	; Retraso de 2 segundos
	CALL delay

	JMP .loop	; Repite el ciclo
    
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
    
; Subrutina de retardo para 2 segundos a 4kHz
delay:
    MOV B, 31          ; B = 31
.outer_loop:
    MOV C, 255         ; C = 255 (bucle interno para consumir ciclos)
.inner_loop:
    DEC C              ; Resta 1 a C
    JNZ .inner_loop    ; Si C ≠ 0, sigue en el bucle interno
    DEC B              ; Resta 1 a B
    JNZ .outer_loop    ; Si B ≠ 0, sigue en el bucle externo
    RET                ; Retorna al llamador
