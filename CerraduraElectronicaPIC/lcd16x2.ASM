; :::::::::::::::::::::: www.rodrigocarita.com ::::::::::::::::::::::::::::::
; Librer�a: lcd16x2.asm
; Versi�n : 1.2
; ---------------------------------------------------------------------------
; Esta archivo requiere de las librer�as RETARDOS.ASM y conversor.ASM

cblock 
	NumCadena 	        ;n�mero de la cadena 
	indice
	memocaracter		
	memoriaw
	caractertemp
         ubicacionlcdfcr
	ubicacionlcdccr
	Varregcomp
endc

DATOS EQU PORTD			;lineas de datos = portD
pinlcd EQU PORTD		;lineas de control = portD

RS EQU 1 ;linea de control RS = bit1
RW EQU 2 ;linea de control RW = bit2
E EQU 3	 ;linea de control E = bit3

on_display_cursor_blink	EQU	0FH     ;Activa el display, el cursor y hace parpadear el cursor
solo_display		EQU	0CH     ; Apaga el cursor y su parpadeo Pertenece al comando Display ON/OFF
limpiar_lcd			EQU	01H     ; limpia los caracteres de la pantalla
apagar_el_display 	EQU	08H		; apaga la pantalla
salto_enter			EQU	0C0H	; Se dirije a la segunda l�nea
home_inicio			EQU	02H     ; Vuelve al inicio

mover_cursor_izquierda EQU 10H	; Mueve el cursor a la izquierda
mover_cursor_derecha EQU 14H	; Mueve el cursor a la derecha

mover_pantalla_izquierda	EQU	18H	; Mueve toda al pantalla a la izquierda
mover_pantalla_derecha		EQU	1CH	; Mueve toda la pantalla a la derecha

off					EQU  0
on					EQU  1

;//////////////////////////////////////////////////////////////////
; Como la conexi�n al lcd lo estamos desarrollando mediante 4 hilos,
;Para enviar datos de 8 bits se va a realizar por partes.
;Esta subrutina se encarga de enmascarar el byte para en primer lugar
;A los bits de mayor peso y luego de un impulso en el pin de Enable
;Enviar� el segundo.
ESCRIBIRCOMANDO				   ;Subrutina para separar en 2 grupos un byte y enviarlos al controlador por partes.
	movwf   memocaracter       ;Desde la macro llegamos con un valor en w, ahora lo guardaremos el registro memocaracter.
	call    COMPROBARSIOCUPADO ;Llamamos a la subrutina que comprueba que el controlador est� desocupado.
	movf    memocaracter,w     ;Extraemos en W el valor que guardamos en el registro memocaracter. 
	andlw   b'11110000'        ;El c�digo de enmascaramiento que nos permitir� quedarnos con los 4bits MSB.
	movwf   DATOS              ;Guardamos el valor del enmasacaramiento en un registro llamado DATOS.
	bcf     pinlcd,RW          ;Para que el LCD reciba comandos RW se encuentre en 0.
	bcf     pinlcd,RS          ;Otro pin que debemos poner a 0 para que el modulo trabaje en modo comando.
	nop						   ;Esperamos un peque�o tiempo 0.2uS.
	bsf     pinlcd,E           ;Realizamos el impulso en el pin de Enable para realizar la transferencia del Dato.
	nop						   ; Ancho del impulso 0.2uS.					
	bcf     pinlcd,E           ; Fin del impulso. 
	swapf   memocaracter,w     ;Ahora nos queda extraer los 4LSB, los intercambiamos con los de MSB y almacenamos en W.
	andlw   b'11110000'         ;Volvemos a realizar el enmascaramiento de los 4MSB despues del intercambio con swapf.
	movwf   DATOS              ;El resultado lo guardamos en el registro DATOS.
	nop						   ; Esperamos un peque�o tiempo 0.2uS.
	bsf     pinlcd,E           ;Realizamos el impulso en el pin de Enable para enviar la segunda parte del comando.
	nop						   ; Ancho del impulso 0.2uS.
	bcf     pinlcd,E           ;Fin del impulso.
RETURN					   ; Regresamos a donde nos han llamado.

ESCRIBIRCARACTER				;Subrutina para separar en 2 grupos un byte y enviarlos al controlador por partes.
	movwf	memoriaw			;Posiblemente se llegue a la subrutina con un valor en W, vamos a guardarlo y devolverlo al final.
	movwf   memocaracter        ;Desde la macro llegamos con un valor en w, ahora lo guardaremos el registro memocaracter.
	call    COMPROBARSIOCUPADO  ;Llamamos a la subrutina que comprueba que el controlador est� desocupado.
	movf    memocaracter,w      ;Extraemos en W el valor que guardamos en el registro memocaracter.    
	andlw   b'11110000'         ;El c�digo de enmascaramiento que nos permitir� quedarnos con los 4bits MSB.
	movwf   DATOS           	;Guardamos el valor del enmasacaramiento en un registro llamado DATOS.
	bcf     pinlcd,RW        	;Para que el LCD reciba datos RW se encuentre en 0.
	bsf     pinlcd,RS        	;Pin que debemos poner a 1 para que el modulo trabaje en modo visualizaci�n. 
	nop							;Esperamos un peque�o tiempo 0.2uS.
	bsf     pinlcd,E         	;Realizamos el impulso en el pin de Enable para realizar la transferencia del Dato.
	nop							;Ancho del impulso 0.2uS.
	bcf     pinlcd,E			;Fin del impulso.	
	swapf   memocaracter,w		;Ahora nos queda extraer los 4LSB, los intercambiamos con los de MSB y almacenamos en W.
	andlw   b'11110000'        	;Volvemos a realizar el enmascaramiento de los 4MSB despues del intercambio con swapf.
	movwf   DATOS           	;El resultado lo guardamos en el registro DATOS.
	bcf     pinlcd,RW        	;Aseguramos que el pin RW se encuenre en 0 para empezar a recibir datos.
	bsf     pinlcd,RS        	;Aseguramos que el Pin RS se encuentre en modo visualizaci�n. (recibe caracteres).
	nop							;Esperamos un peque�o tiempo 0.2uS.
	bsf     pinlcd,E         	;Realizamos el impulso en el pin de Enable para realizar la transferencia del Dato.
	nop							;Ancho del impulso 0.2uS.
	bcf     pinlcd,E			;Fin del impulso
	movf	memoriaw,W			;Finalizada la subrutina devolvemos el valor de W para que no modifique el proceso
RETURN						;Fin de la subrutina
	
COMPROBARSIOCUPADO 				;Subrutina Testear� la bandera de Busy para saber si el controlador del m�dulo est� ocupado.
	banco	1					;Vamos al banco 1 para cambiar los pines D4 a D7 como entrada, por ahi recibiremos el dato
	movlw	b'11110000'			;Pines D4 a D7 como entrada
	movwf	TRISD				;Conectados al puerto D
	banco	0					;Volvemos al banco 0 para realizar el testeo
	bcf     pinlcd,RS        	;Configuramos el controlador en modo Comando
	bsf     pinlcd,RW        	;Configuramos el LCD para que nos envie datos.
	nop							;Esperamos un peque�o tiempo 0.2uS
	bsf     pinlcd,E         	;Activamos el pin de Enable para que empiece la transferencia y el m�dulo nos responda.
	nop							;Esperamos un prque�o tiempo de 0.2uS
	movf    DATOS,W         	;Extrae el valor del registro DATOS (4msb) y lo guarda en W est� es la primera respuesta
	bcf     pinlcd,E         	;Apagamos el pin de Enable para leer los 4lsb restantes.
	andlw   0F0h            	;La respuesta anterior la enmascaramos
	movwf   caractertemp		;Almacenamos el caracter temporalmente
	nop							;Esperamos un peque�o tiempo					
	bsf     pinlcd,E			;Activamos el pin de Enable para que comience la transferencia.
	nop							;Esperamos otro peque�o tiempo
	swapf   DATOS,w         	;Leemos la respuesta y lo intercambiamos con los 4msb para guardarlo en W
	bcf     pinlcd,E         	;Apagamos la transferencia.
	andlw   00Fh            	;Enmascaramos la segunda respuesta
	iorwf   caractertemp,1      ;Combina nibbles Juntamos la primera con la segunda respuesta para formar la respuesta gral
	btfsc   caractertemp,7      ;Comprobamos el pin 7 de la respuesta, esta es la bandera de busy, si se encuentra en 1=ocupado
	goto    COMPROBARSIOCUPADO  ;Si la respuesta es ocupado repetiremos todo el proceso denuevo
	bcf     pinlcd,RW        	;Si la respuesta es desocupado Continuamos, en este caso apagamos el bit de intercambio de datos
	banco	1					;Vamos al banco 1 para dejar las cosas como estaban antes
	movlw	0x00				;Ahora todos los pines como Salida
	movwf	TRISD				;Del puerto D
	banco	0					;Vamos al banco 0
RETURN						;Salimos de la subrutina

Inicio_lcd						; Esta es la subrutina de secuencia para iniciar el LCD
	banco 0					    ; Nos dirijimos al banco 0 para manipular pines
	bcf	pinlcd,E				; Apagamos el pin de E
	bcf	pinlcd,RW				; Apagamos el pin de RW
	bcf	pinlcd,RS				; Apagamos el pin de RS
	movlw	0x0F				; Encendemos los pines del LCD
	movwf	DATOS				; En el puerto D

	banco 1					    ; Vamos al banco 1
	movlw B'00001111'     	;Declaramos Todos los pines como salida 
	movwf TRISD				;Del puerto D
	bcf	TRISD,E					;Aseguramos que el Pin E sea salida	
	bcf	TRISD,RW				;Aseguramos que el pin RW sea salida
	bcf	TRISD,RS				;Aseguramos que el pin RS sea salida
	banco	0					;Regresamos al banco 0

; ///////////Comienza la secuencia de inicializaci�n de la pantalla LCD//////////////////////
	milisegundo .20				;Despues de encendido tengo que esperar un tiempo mayor a 15ms
	movlw   B'00110000'     	;Primer valor pedido por el fabricante
	movwf   DATOS				;Lo escribimos en el Puerto D
	nop							;Esperamos un peque�o tiempo
	bsf     pinlcd,E         	;Enviamos un impulso al pin de Enable para enviar el dato
	nop							;Ancho del impulso 0,2 uS
	bcf     pinlcd,E			;Fin del impulso	
	milisegundo .10				;Antes de pasar al siguiente paso debo esperar m�s de 5ms
	movlw   B'00110000'     	;Segundo valor pedido por el fabricante
	movwf   DATOS           	;Lo escribimos en el Puerto D
	nop							;Esperamos un peque�o tiempo
	bsf     pinlcd,E         	;Enviamos un impulso al pin de Enable para enviar el dato
	nop							;Ancho del impulso 0,2 uS
	bcf     pinlcd,E			;Fin del impulso	
	movlw   B'00110000'     	;Tercer valor pedido por el fabricante
	movwf   DATOS            	;Lo escribimos en el Puerto D
	nop							;Esperamos un peque�o tiempo
	bsf     pinlcd,E         	;Enviamos un impulso al pin de Enable para enviar el dato
	nop							;Ancho del impulso 0,2 uS
	bcf     pinlcd,E			;Fin del impulso
	milisegundo .2				;Antes de pasar al siguiente paso debo esperar m�s de 100uS
	movlw   B'00100000'			;Cargamos comando de configuraci�n de comunicaci�n de 4bits
	movwf   DATOS				;Escribimos el comando en el puerto D
	nop							;Esperamos un tiempo antes de realizar la transferencia
	bsf     pinlcd,E         	;Enviamos un impulso al pin de Enable para enviar el dato
	nop							;Ancho del impulso 0,2 uS
	bcf     pinlcd,E			;Fin del impulso

	movlw   B'00101000'     ;Interfaz de 4 bits, 2 lineas
	call    ESCRIBIRCOMANDO		; de caracteres de 5x7
	
	movlw   on_display_cursor_blink     ;FH Display on, cursor on,blink
	call    ESCRIBIRCOMANDO
	
	movlw   limpiar_lcd     	; Limpia el LCD
	call    ESCRIBIRCOMANDO
	
	movlw   B'00000110'     ; Configura para que cada que se escriba un caracter cursor aumente en 1
	call    ESCRIBIRCOMANDO		
	
	movlw   B'10000000'     ; Vamos a HOME
	call    ESCRIBIRCOMANDO
	RETURN

;//////////////////////////////////////////////////////////////
;///// Comandos para escribir en el LCD un registro de 3 d�gitos

PARAESCR1B1RREGISTRO		;t�tulo de subrutina
	MOVWF Varregcomp			;Guarda el valor de ingreso en un Registro
	convertir_a_bcd Varregcomp  ;Separa en 3 registros (d�gitos)el valor
	
	;Para valores inferiores a 10
	MOVLW d'10'           ;Carga el valor de 10 en una variable    
	SUBWF Varregcomp,0    ;De comparaci�n.
	BTFSS STATUS,C        ;El resultado es de 1 d�gito?
	GOTO UND1G            ;Caso verdadero subrutina para escribir 1 digito
	MOVLW d'100'          ;Carga el valor de 100 en una variable
	SUBWF Varregcomp,0    ;De comparaci�n 
	BTFSS STATUS,C        ;El resultado es de dos digitos?
	GOTO D0SDIG           ;Caso verdadero subrutina de escribir 2 digitos
	MOVLW d'255'          ;Carga el valor de 100 en una
	SUBWF Varregcomp,0	  ;En una variable de comparaci�n	
	BTFSS STATUS,C		  ;El resultado es mayor a 200?
	GOTO TRESD1G          ;Caso falso. Va a la subrutina de escribir 3 dig   
	escribir 'O'          ;Caso verdadero, empieza a escribir un mensaje
	escribir 'U'
	escribir 'T'
	FUERALIM1T3           ;t�tulo de finalizaci�n de subrutina
	RETURN           ; <------- El return est� ah�
	
	UND1G		           ;Subrutina para escribir 1 d�gito
	escribir ' '           ;Escribe 2 espacios 
	escribir ' '
	escribirreg bcd_unidad ;Escribe el digito
	GOTO FUERALIM1T3       ;Se va a finalizar la subrutina 
	D0SDIG                 ;Subrutina para escribir 2 d�gitos 
	escribir ' '           ;Escribe un espacio  
	escribirreg bcd_decena ;Escribe el pen�ltimo digito
	escribirreg bcd_unidad ;Escribe el �ltimo digito
	GOTO FUERALIM1T3       ;Se va a finalizar la subrutina
	TRESD1G                ;Subrutina para escribir 3 d�gitos
	escribirreg bcd_centena;Escribe el antepen�ltimo digito
	escribirreg bcd_decena ;Escribe el pen�ltimo digito
	escribirreg bcd_unidad ;Escribe el pen�ltimo digito
	GOTO FUERALIM1T3       ;Se va a finalizar la subrutina 
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\Subrutina para borrar fila \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	
	subp4arab0rf1l
	cargarvalor .16,indice
	escribir ' '
	DECFSZ indice,1
	GOTO $-2	
	RETURN
;................... Descarga la actualizaciones en: www.rodrigocarita.com	