; En el programa presente se programar� una cerradura electr�nica.

; Los materiales para su implementaci�n son los siguientes.
; Llave contacto (Puede ser reemplazado por un switch)
; Teclado 4x4
; LCD 16x2
; Pic16f877A (Con sus componentes: oscilador y condensadores)
; Led (Simula una puerta)

;---- Descripci�n: La cerradura electr�nica, se encargar� de abrir una puerta
; despues de haber ingresado correctamente la clave en el teclado num�rico 4x4

; Se constar� de una llave contacto, el cual tendr� que activar la secuencia de
; apertura de la puerta. (Servomotor desbloquea la puerta)

; Explicado.

; - Al principio la puerta est� completamente cerrada
; - Llega un usuario, ingresa la clave de 4 digitos
; - Luego de ingresar la clave, girar� la llave contacto.
; - Si la clave fu� correcta, entonces se iniciar� la secuencia de apertura

; La explicaci�n y demostraci�n en la web. www.rodrigocarita.com en la secci�n
; sistemas digitales 2 / teclado 4x4. Tambi�n en youtube.
;-------------------------------- Cabecera ------------------------------------
INCLUDE <P16F877A.INC>
LIST P=16F877A
INCLUDE <mimacro.INC> ;Incluimos la macro
__config 0x3f32 ; Este es un comando de fusibles, lo estudiaremos m�s adelante.
;------------------------------------------------------------------------------
;----------------------------- Variables --------------------------------------
#DEFINE PUERTA PORTC,6 ;Definimos el pin donde est� conectada la puerta (LED)
#DEFINE LLAVE PORTC,1  ;Definimos el pin donde est� conectada la llave (Switch)

CBLOCK 0x20 ;Bloque de variables y memorias.
teclapulsada ;Variable donde se guardaremos la 1ra tecla pulsada
teclapulsada2 ;Variable donde se guardaremos la 2da tecla pulsada
teclapulsada3 ;Variable donde se guardaremos la 3ra tecla pulsada
teclapulsada4 ;Variable donde se guardaremos la 4ta tecla pulsada
ENDC        ;Finalizamos bloque
;-------------------------------------------------------------------------------
;-------------------------  Configuraciones  -----------------------------------
ORG 0;

banco 1         ;Nos vamos al banco 1
BCF TRISC,6     ;Declaramos el pin 6 del puerto C como salida (LED o Puerta)
BSF TRISC,1     ;Declaramos el pin 1 del puerto C como entrada (Switch o Llave)
banco 0         ;Nos vamos al banco 0
;------------------------------------------------------------------------------
;---------------------------- Programa Principal ------------------------------
BCF PUERTA      ; Apagamos el bit de puerta (Puerta cerrada)
iniciarlcd       ; Iniciamos el LCD conectado al puerto D
cursor_off       ; Apagamos el parpadeo del cursor
iniciar_teclado  ; Iniciamos el teclado conectado al puerto B
CALL ESCRIBETITULO ;Llamamos a la subrutina para escribir el t�tulo
CALL ESCRIBEPARTE2 ; Llamamos a la subrutina para escribir (Clave: )

;{ Desde aqu� viene el bucle principal
PROGRAMA
BTFSC LLAVE  ;No podemos arrancar el programa, hasta que la llave est� cerrada.
GOTO PROGRAMA
lcdfc .2,.8 ;Posicionamos el cursor en la fila 2, columna 8

leertecla    ;Leemos la primeratecla
MOVWF teclapulsada  ; Lo guardamos en el registro teclapulsada
escribirreg teclapulsada ;Escribirmos la tecla en el teclado
milisegundo .250 ;Esperamos 200 milisegundos antirebote

leertecla    ;Leemos la segunda tecla
MOVWF teclapulsada2  ; Lo guardamos en el registro teclapulsada
escribirreg teclapulsada2 ;Escribirmos la tecla en el teclado
milisegundo .250 ;Esperamos 200 milisegundos antirebote

leertecla    ;Leemos la tercera tecla
MOVWF teclapulsada3  ; Lo guardamos en el registro teclapulsada
escribirreg teclapulsada3 ;Escribirmos la tecla en el teclado
milisegundo .250 ;Esperamos 200 milisegundos antirebote

leertecla    ;Leemos la cuarta tecla
MOVWF teclapulsada4  ; Lo guardamos en el registro teclapulsada
escribirreg teclapulsada4 ;Escribirmos la tecla en el teclado
milisegundo .250 ;Esperamos 200 milisegundos antirebote

;----------------------- Secci�n de la contrase�a: 4621 --------------------
csni teclapulsada,.4, DENEGADO ;Si al consultar la contrase�a, 1 digito falla
csni teclapulsada2,.6, DENEGADO ;automaticamente se ir� a la subrutina
csni teclapulsada3,.2, DENEGADO ; llamada denegado
csni teclapulsada4,.1, DENEGADO
;----------------------- Secuencia de apertura ------------------------------
;Si se ha llegado aqu� es porque la contrase�a es correcta. Entonces se crea una
;subrutina especial para la secuencia.
CALL PERMITIDO  ;Aqu� estar� la subrutina de apertura de la puerta.
GOTO PROGRAMA
;} Finaliz� el bucle principal

;-------------------- Secci�n de subrutina principal ------------------------

DENEGADO ;aqu� empieza la subrutina en caso la contrase�a sea erronea
;Primer paso ser� limpiar lo escrito
lcdfc .2,.8 ;Posicionamos el cursor en la fila 2, columna 8
escribir ' '
escribir ' '
escribir ' '
escribir ' '
GOTO PROGRAMA ; Reiniciamos el programa

PERMITIDO ;Aqu� la secuencia de cosas que sucederan cuando sea correcta

CALL ESCRIBEPARTE3 ;Escribimos el mensaje de correcto.
BTFSS LLAVE ;Esperamos a que se abra la llave
GOTO $-1    ;Seguimos esperando
BSF PUERTA  ;Abrimos la Puerta

BTFSC LLAVE ;Testeamos si se cerr� la llave (osea la puerta)
GOTO $-1 ;Mantenemos la puerta abierta, hasta que se cierre la llave
BCF PUERTA ; Cerramos la puerta
borrarfila .1 ;Borramos el mensaje de la fila 1, para escribir denuevo el otro
CALL ESCRIBETITULO ; Escribimos denuevo el t�tulo
lcdfc .2,.8 ;Posicionamos el cursor en la fila 2, columna 8
escribir ' '
escribir ' '
escribir ' '
escribir ' '
RETURN



;----------------------- Secci�n de subrutinas secundarias --------------------
;{
ESCRIBETITULO ; Escribiremos un mensaje inicial.
lcdfc .1,.6
escribir 'A'
escribir 'C'
escribir 'C'
escribir 'E'
escribir 'S'
escribir 'O'
RETURN
;}
;{
ESCRIBEPARTE2 ; Escribiremos un mensaje en la parte inferior
lcdfc .2,.1
escribir 'C'
escribir 'L'
escribir 'A'
escribir 'V'
escribir 'E'
escribir ':'
escribir ' '
RETURN
;}
;{
ESCRIBEPARTE3 ; Escribiremos un mensaje en la parte inferior
lcdfc .1,.5
escribir 'C'
escribir 'O'
escribir 'R'
escribir 'R'
escribir 'E'
escribir 'C'
escribir 'T'
escribir 'O'
RETURN
;}

;------------------------------------------------------------------------------

;INCLUDE <matematica.asm> ;Incluimos la librer�a de matem�tica v 1.1
INCLUDE <teclado4x4.asm> ;Incluimos la librer�a de teclado matricial 4x4 v 1.0
INCLUDE <lcd16x2.asm>   ;Incluimos la librer�a de lcd v 1.2
INCLUDE <Retardos.asm>  ;Incluimos la librer�a de retardos v 1.0
INCLUDE <conversor.asm> ;incluimos la librer�a conversor requerida por lcd  v 1.0
END



