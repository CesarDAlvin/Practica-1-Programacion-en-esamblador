; TEAM PAMBACODE
; ESTE CÓDIGO MUESTRA UN MENSAJE EN UN DISPLAY LCD 16x2 Y REALIZA UNA ANIMACIÓN SIMPLE EN PANTALLA
; SE IMPRIMIRÁ EL MENSAJE EN AMBAS LÍNEAS DEL LCD Y SE EJECUTARÁ UN RETARDO PARA VISUALIZARLO,
; LUEGO SE REALIZARÁ UNA ANIMACIÓN EN LA PANTALLA GRÁFICA DEL SIMULADOR.
; 2025/03/09 - V.3.2.0
; TRABAJARON: CESAR ARTURO / CesarDAlvin | SARA CRYSTEL / Sara130401 | CERON DAUZON / Juryelcd

JMP boot	; Salta a la etiqueta 'boot' para iniciar el programa

; Constantes
stackTop    EQU 0xFF    ; Puntero inicial de la pila
txtDisplay  EQU 0x2E0   ; Dirección de memoria de la pantalla de texto
vslDisplay  EQU 0x300   ; Dirección de memoria de la pantalla visual

; Definición de datos
Es1:	
	DB "Pelota  "	; Cadena de texto a imprimir
	DB 0		; Terminador de cadena (carácter nulo)
Es2:	
	DB "Boing!!"	; Cadena de texto a imprimir
	DB 0		; Terminador de cadena (carácter nulo)

; Pelota1 (Inicio)
Pelota1:
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
   	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x00\x00\x00\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
   	DB "\x1F\x1F\x1F\x1F\x1F\x00\x14\x14\x14\x00\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x00\x14\x14\x14\x00\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x00\x14\x14\x14\x00\x1F\x1F\x1F\x1F\x1F\x1F"
    	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x00\x00\x00\x1F\x1F\x1F\x1F\x1F\x1F\x1F"

; Pelota2 (Rebote)
Pelota2:
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
   	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x1F\x00\x00\x00\x1F\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x00\x14\x14\x14\x00\x1F\x1F\x1F\x1F\x1F\x1F"
	DB "\x1F\x1F\x1F\x1F\x1F\x00\x14\x14\x14\x00\x1F\x1F\x1F\x1F\x1F\x1F"
    DB "\x1F\x1F\x1F\x1F\x1F\x1F\x00\x00\x00\x1F\x1F\x1F\x1F\x1F\x1F\x1F"


; Programa principal
boot:
	MOV SP, stackTop

.loop:
	; Dibuja a la pelota
	MOV C, Pelota1
	MOV D, vslDisplay
	CALL draw_sprite
    
	; Imprime "Es1"
	MOV C, Es1
	MOV D, txtDisplay
	CALL print

	; Retraso de 2 segundos
	CALL delay

	; Dibuja el impulso de la pelota
	MOV C, Pelota2
	MOV D, vslDisplay
	CALL draw_sprite
    
	; Imprime "Es2"
	MOV C, Es2
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
    MOV B, 5          ; B = 31 #ajustamos hasta que la velocidad de los frames se ve continua y adecuada
.outer_loop:
    MOV C, 255         ; C = 255 (bucle interno para consumir ciclos)
.inner_loop:
    DEC C              ; Resta 1 a C
    JNZ .inner_loop    ; Si C ≠ 0, sigue en el bucle interno
    DEC B              ; Resta 1 a B
    JNZ .outer_loop    ; Si B ≠ 0, sigue en el bucle externo
    RET                ; Retorna al llamador
