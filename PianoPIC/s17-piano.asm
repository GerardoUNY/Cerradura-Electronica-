;/////////////        www.rodrigocarita.com     ///////////////////////
; Vamos a crear un pequeño piano con las 7 notas. Usaremos el TMR2 como pwm
; Para eso vamos a encontrar los valores optimos que nos permitirán llegar a
; las frecuencias de cada nota.
; DO -> 261.63 Hz --> 382 ms
; RE -> 293.66 --> 3.4 ms
; MI -> 329.63 --> 3 ms
; FA -> 349.23 --> 2.86 ms
; SOL -> 392 --> 2.55 ms
; LA -> 440 --> 2.27 ms
; SI -> 493.88 --> 2 ms

; El valor de cristal que ocupa estos rangos es 4 MHZ. Así que con los cálculos.
;...............................................................................
; A Pre-escala: 16
; Para DO PR2 = 238 
; Para RE PR2 = 211 
; Para MI PR2 = 189
; Para FA PR2 = 177
; Para SOL PR2 = 158
; Para LA PR2 = 141
; Para SI PR2 = 126
;/////////////////////////////////////////////////////////////////////////////
; OJO estamos trabajando con un cristal de 4MHz y dutty 50%

INCLUDE <P16F877A.INC>
LIST P=16F877A
INCLUDE <mimacro.INC> ;Incluimos la macro
__config 0x3f32 ; Este es un comando de fusibles, lo estudiaremos más adelante.
CBLOCK
ENDC
ORG 0;
;//////////// Variables que son los resultados de cálculo ///////////////////
banco 1           ;Vamos al banco 1
MOVLW b'01111111' ;Configuramos los 7 pines del puerto B
MOVWF TRISB       ;como entrada. Ahi conectaremos los pulsadores
BCF TRISC,0       ;Declaramos como salida el pin 0 del puerto C (LED)
BCF TRISC,2       ;Declaramos como salida el pin de PWM (CCP1)
banco 0           ;Regresamos al Banco 0
CLRF PORTC        ;Limpiamos todo el puerto C
CLRF PORTB        ;Limpiamos todo el puerto B

MOVLW b'00001100' ; Cargamos el valor, para activar el modo PWM
MOVWF CCP1CON     ;  en el registro CCP


movlw b'00000011' ; Configuramos el Preescalador con valor (16) del TMR2
movwf T2CON       ; En el registro T2CON

PROGRAMA          ; Título de programa para bucle
BCF T2CON,TMR2ON  ; Apagamos el TMR2 como condición inicial
BCF PORTC,0       ; Apagamos el LED como condición inicial
MOVLW .0          ; Ingresamos un dutty Cyle al 0% de PR2
MOVWF CCPR1L      ; En el registro CCPR1L

BTFSC PORTB,0   ;Comprobamos si el PIN 0 del puerto B (Do) ha sido pulsado
GOTO RUTDO      ;Caso sea verdadero vamos la subrutina RUTDO
BTFSC PORTB,1   ;Comprobamos si el PIN 1 del puerto B (Re) ha sido pulsado
GOTO RUTRE      ;Caso sea verdadero vamos la subrutina RUTRE
BTFSC PORTB,2   ;Comprobamos si el PIN 2 del puerto B (Mi) ha sido pulsado
GOTO RUTMI      ;Caso sea verdadero vamos la subrutina RUTMI
BTFSC PORTB,3   ;Comprobamos si el PIN 3 del puerto B (Fa) ha sido pulsado
GOTO RUTFA      ;Caso sea verdadero vamos la subrutina RUTFA
BTFSC PORTB,4   ;Comprobamos si el PIN 4 del puerto B (Sol) ha sido pulsado
GOTO RUTSOL     ;Caso sea verdadero vamos la subrutina RUTSOL
BTFSC PORTB,5   ;Comprobamos si el PIN 5 del puerto B (La) ha sido pulsado
GOTO RUTLA      ;Caso sea verdadero vamos la subrutina RUTLA
BTFSC PORTB,6   ;Comprobamos si el PIN 6 del puerto B (Si) ha sido pulsado
GOTO RUTSI      ;Caso sea verdadero vamos la subrutina RUTSI
GOTO PROGRAMA   ;Repetimos el programa

RUTDO             ;Subrutina para la tecla Do
BSF PORTC,0       ;Encendemos el LED
BSF T2CON,TMR2ON  ;Encendemos el TMR2
banco 1           ;Vamos la banco 1
MOVLW .238        ;Cargamos el valor de cálculo de la nota Do
movwf PR2         ;en el registro PR2
banco 0           ;Vamos l banco 0
MOVLW .119        ;Cargamos el valor del Dutty cycle 50% del PR2
MOVWF CCPR1L      ;en el registro CCPR1L
BTFSC PORTB,0     ;Comprobamos si se ha dejado de pulsar la tecla
GOTO $-1          ;Caso falso: Seguimos comprobando
GOTO PROGRAMA     ;Caso verdadero: Repetimos el programa

RUTRE               ;Subrutina para la tecla Re
BSF PORTC,0         ;Encendemos el LED
BSF T2CON,TMR2ON    ;Encendemos el TMR2
banco 1             ;Vamos la banco 1
MOVLW .211          ;Cargamos el valor de cálculo de la nota Re
MOVWF PR2           ;en el registro PR2
banco 0             ;Vamos l banco 0
MOVLW .105          ;Cargamos el valor del Dutty cycle 50% del PR2
MOVWF CCPR1L        ;en el registro CCPR1L
BTFSC PORTB,1       ;Comprobamos si se ha dejado de pulsar la tecla
GOTO $-1            ;Caso falso: Seguimos comprobando
GOTO PROGRAMA       ;Caso verdadero: Repetimos el programa

RUTMI               ;Subrutina para la tecla Mi
BSF PORTC,0         ;Encendemos el LED
BSF T2CON,TMR2ON    ;Encendemos el TMR2
banco 1             ;Vamos la banco 1
MOVLW .189          ;Cargamos el valor de cálculo de la nota Mi
MOVWF PR2           ;en el registro PR2
banco 0             ;Vamos l banco 0
MOVLW .94           ;Cargamos el valor del Dutty cycle 50% del PR2
MOVWF CCPR1L        ;en el registro CCPR1L
BTFSC PORTB,2       ;Comprobamos si se ha dejado de pulsar la tecla
GOTO $-1            ;Caso falso: Seguimos comprobando
GOTO PROGRAMA       ;Caso verdadero: Repetimos el programa

RUTFA               ;Subrutina para la tecla Fa
BSF PORTC,0         ;Encendemos el LED
BSF T2CON,TMR2ON    ;Encendemos el TMR2
banco 1             ;Vamos la banco 1
MOVLW .177          ;Cargamos el valor de cálculo de la nota Fa
MOVWF PR2           ;en el registro PR2
banco 0             ;Vamos l banco 0
MOVLW .99           ;Cargamos el valor del Dutty cycle 50% del PR2
MOVWF CCPR1L        ;en el registro CCPR1L
BTFSC PORTB,3       ;Comprobamos si se ha dejado de pulsar la tecla
GOTO $-1            ;Caso falso: Seguimos comprobando
GOTO PROGRAMA       ;Caso verdadero: Repetimos el programa

RUTSOL              ;Subrutina para la tecla Sol
BSF PORTC,0         ;Encendemos el LED
BSF T2CON,TMR2ON    ;Encendemos el TMR2
banco 1             ;Vamos la banco 1
MOVLW .158          ;Cargamos el valor de cálculo de la nota Sol
movwf PR2           ;en el registro PR2
banco 0             ;Vamos l banco 0
MOVLW .79           ;Cargamos el valor del Dutty cycle 50% del PR2
MOVWF CCPR1L        ;en el registro CCPR1L
BTFSC PORTB,4       ;Comprobamos si se ha dejado de pulsar la tecla
GOTO $-1            ;Caso falso: Seguimos comprobando
GOTO PROGRAMA       ;Caso verdadero: Repetimos el programa

RUTLA               ;Subrutina para la tecla La
BSF PORTC,0         ;Encendemos el LED
BSF T2CON,TMR2ON    ;Encendemos el TMR2
banco 1             ;Vamos la banco 1
MOVLW .141          ;Cargamos el valor de cálculo de la nota La
movwf PR2           ;en el registro PR2
banco 0             ;Vamos l banco 0
MOVLW .70           ;Cargamos el valor del Dutty cycle 50% del PR2
MOVWF CCPR1L        ;en el registro CCPR1L
BTFSC PORTB,5       ;Comprobamos si se ha dejado de pulsar la tecla
GOTO $-1            ;Caso falso: Seguimos comprobando
GOTO PROGRAMA       ;Caso verdadero: Repetimos el programa

RUTSI               ;Subrutina para la tecla Si
BSF PORTC,0         ;Encendemos el LED
BSF T2CON,TMR2ON    ;Encendemos el TMR2
banco 1             ;Vamos la banco 1
MOVLW .126          ;Cargamos el valor de cálculo de la nota Si
movwf PR2           ;en el registro PR2
banco 0             ;Vamos l banco 0
MOVLW .63           ;Cargamos el valor del Dutty cycle 50% del PR2
MOVWF CCPR1L        ;en el registro CCPR1L
BTFSC PORTB,6       ;Comprobamos si se ha dejado de pulsar la tecla
GOTO $-1            ;Caso falso: Seguimos comprobando
GOTO PROGRAMA       ;Caso verdadero: Repetimos el programa 

END


 


