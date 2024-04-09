            LIST P=16F877A
	    INCLUDE "P16F877A.INC"
	    CBLOCK 0X20
	    T1
	    T2
	    T3
            CONT
            CONT2
            CONT3
	    ENDC
	    __CONFIG _FOSC_HS & _WDTE_OFF & _PWRTE_ON & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _WRT_OFF & _CP_OFF
	    ORG 0X0000
        
            BANKSEL     TRISB
	    CLRF        TRISB
            CLRF        TRISC
	    BANKSEL     PORTB
	    CLRF        PORTB
      
INICIO  
        CLRF        PORTC
        MOVLW       .0
        MOVWF       CONT3
        
RESETCONT2       
        MOVLW       .0
        MOVWF       CONT2
       
RESETCONT       
        MOVLW       .0
        MOVWF       CONT
      
        CALL        DISPLAY
        CALL        RETARDO
        INCF        CONT,F
        MOVF        CONT,W
        XORLW       .10
        BTFSS       STATUS, Z
        GOTO        $-6
        
        INCF        CONT2,F       
        MOVF        CONT2,W
        XORLW       .10
        BTFSS       STATUS,Z
        GOTO        RESETCONT
        
        INCF        CONT3,F
        MOVF        CONT3,W
        MOVWF       PORTC
        XORLW       .10
        BTFSS       STATUS,Z
        GOTO        RESETCONT2

	    GOTO        INICIO 
        
DISPLAY 
        SWAPF       CONT2,W
        ADDWF       CONT,W
        MOVWF       PORTB
        RETURN
 
        
        
        
        
               
;//////////////////////////////////////////////////////////////////  
;///////// 1S /////////
RETARDO     
	    MOVLW     .7
	    MOVWF     T3
X3	    CALL      RETARDO1
	    DECFSZ    T3
	    GOTO      X3
	    RETURN	   	    
;//////// 100mS /////////	    
RETARDO1     
	    MOVLW     .100
	    MOVWF     T2
X2	    CALL      RETARDO2
	    DECFSZ    T2
	    GOTO      X2
	    RETURN	    	    
;//////// 1mS //////////	    
RETARDO2     
	    MOVLW     .249
	    MOVWF     T1
X1	    NOP
	    DECFSZ    T1
	    GOTO      X1
	    RETURN
              
        END