; TEAM PAMBACODE
; ESTE CÓDIGO MUESTRA UN MENSAJE EN UN DISPLAY LCD 16x2 Y REALIZA UNA ANIMACIÓN SIMPLE EN PANTALLA
; SE IMPRIMIRÁ EL MENSAJE EN AMBAS LÍNEAS DEL LCD Y SE EJECUTARÁ UN RETARDO PARA VISUALIZARLO,
; LUEGO SE REALIZARÁ UNA ANIMACIÓN EN LA PANTALLA GRÁFICA DEL SIMULADOR.
; 2025/03/09 - V.2.0.1
; TRABAJARON: CESAR ARTURO / CesarDAlvin | SARA CRYSTEL / Sara130401 | CERON DAUZON / Juryelcd

;------------------------------------------------------------------------------
; Configuración inicial del programa
;------------------------------------------------------------------------------
org 0x100                   ; Define el comienzo del programa en offset 100h (formato COM)

;------------------------------------------------------------------------------
; Sección de datos
;------------------------------------------------------------------------------
msg_line1 db 'Hola, Mundo LCD!',0   ; Mensaje para la línea 1 (terminado en 0 para marcar fin de cadena)
msg_line2 db 'Linea 2: Ejemplo!',0     ; Mensaje para la línea 2 (terminado en 0)
ani_char db '*'                        ; Carácter que se usará en la animación gráfica

;------------------------------------------------------------------------------
; Inicio del programa principal
;------------------------------------------------------------------------------
start:
    mov ax, cs         ; Mueve el valor del segmento de código (CS) a AX
    mov ds, ax         ; Establece DS = CS para que el segmento de datos sea el mismo que el de código

    ;-- Muestra mensajes en el LCD simulando la escritura en ambas líneas --
    call lcd_clear     ; Llama a la subrutina que limpia el display LCD
    call lcd_write_line1  ; Llama a la subrutina que escribe msg_line1 en la primera línea del LCD
    call lcd_write_line2  ; Llama a la subrutina que escribe msg_line2 en la segunda línea del LCD

    ;-- Retardo para mantener el mensaje visible (delay similar a C) --
    mov cx, 0FFFFh     ; Carga un valor alto en CX para crear un retardo (el valor se puede ajustar)
    call delay         ; Llama a la subrutina de retardo

    ;-- Realiza una animación simple en la pantalla gráfica --
    call graphic_animation  ; Llama a la subrutina que ejecuta la animación

    ;-- Finaliza el programa --
    mov ax, 4C00h      ; Prepara el código de finalización para DOS (función 4Ch de INT 21h)
    int 21h            ; Llama a la interrupción 21h para terminar el programa

;------------------------------------------------------------------------------
; Subrutina: delay
; Descripción: Genera un retardo mediante un bucle que decrementa el registro CX.
; Cada iteración (con NOP y LOOP) consume tiempo, generando una pausa.
;------------------------------------------------------------------------------
delay:
    push cx            ; Guarda el valor de CX en la pila para no perderlo
delay_loop:
    nop                ; NOP significa "No OPeration": no hace nada pero consume tiempo
    loop delay_loop    ; Decrementa CX y salta a delay_loop si CX ≠ 0
    pop cx             ; Recupera el valor original de CX (aunque en este caso ya no se utiliza)
    ret                ; Retorna a la instrucción que llamó a delay

;------------------------------------------------------------------------------
; Subrutina: lcd_clear
; Descripción: Limpia el display LCD. En un hardware real se enviarían comandos específicos,
; pero en este simulador se asume una función abstracta.
;------------------------------------------------------------------------------
lcd_clear:
    ; Aquí se simula la limpieza del LCD (por ejemplo, llenando la memoria del LCD con espacios).
    ret                ; Retorna inmediatamente

;------------------------------------------------------------------------------
; Subrutina: lcd_write_line1
; Descripción: Escribe el mensaje de la primera línea (msg_line1) en el LCD.
;------------------------------------------------------------------------------
lcd_write_line1:
    ; Se simula la escritura copiando el mensaje en la posición asignada a la línea 1.
    ret                ; Retorna inmediatamente

;------------------------------------------------------------------------------
; Subrutina: lcd_write_line2
; Descripción: Escribe el mensaje de la segunda línea (msg_line2) en el LCD.
;------------------------------------------------------------------------------
lcd_write_line2:
    ; Se simula la escritura copiando el mensaje en la posición asignada a la línea 2.
    ret                ; Retorna inmediatamente

;------------------------------------------------------------------------------
; Subrutina: graphic_animation
; Descripción: Realiza una animación simple en la pantalla gráfica.
; La animación consiste en mover el carácter '*' horizontalmente de izquierda a derecha.
;------------------------------------------------------------------------------
graphic_animation:
    mov si, 0          ; Inicializa el contador (posición horizontal) en 0
animation_loop:
    ; Aquí se simula la limpieza y redibujado de la pantalla gráfica.
    ; En un hardware real se podría escribir directamente en la memoria de video.
    
    ; Simulación: Se “dibuja” el carácter en la posición actual (representativo)
    ; Por ejemplo: escribir en una dirección de memoria ficticia: [video_memory + si] = '*'
    
    mov cx, 0FFFh      ; Carga un valor de retardo para que el movimiento sea visible
    call delay         ; Llama a la subrutina delay para pausar entre movimientos
    
    inc si             ; Incrementa la posición horizontal (mueve el carácter a la derecha)
    cmp si, 16         ; Compara SI con 16 (ancho del LCD/posición final)
    jl animation_loop  ; Si SI es menor que 16, vuelve al inicio del bucle para seguir animando
    ret                ; Retorna al programa principal

;------------------------------------------------------------------------------
; Relleno y firma del sector (para formatos de archivo de 512 bytes, como en arranques)
;------------------------------------------------------------------------------
times 510 - ($ - $$) db 0   ; Rellena hasta 510 bytes con 0
dw 0AA55h                   ; Firma del sector de arranque (valor característico)
