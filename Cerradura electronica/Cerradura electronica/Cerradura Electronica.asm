
_Move_Delay:

;Cerradura Electronica.c,9 :: 		void Move_Delay() {
;Cerradura Electronica.c,10 :: 		Delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_Move_Delay0:
	DECFSZ     R13+0, 1
	GOTO       L_Move_Delay0
	DECFSZ     R12+0, 1
	GOTO       L_Move_Delay0
	NOP
	NOP
;Cerradura Electronica.c,11 :: 		}
L_end_Move_Delay:
	RETURN
; end of _Move_Delay

_code_enter:

;Cerradura Electronica.c,30 :: 		void code_enter()
;Cerradura Electronica.c,32 :: 		kp = 0;
	CLRF       _kp+0
;Cerradura Electronica.c,34 :: 		do
L_code_enter1:
;Cerradura Electronica.c,36 :: 		kp = Keypad_Key_Click();
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;Cerradura Electronica.c,37 :: 		while (!kp);
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_code_enter1
;Cerradura Electronica.c,39 :: 		switch (kp)
	GOTO       L_code_enter4
;Cerradura Electronica.c,41 :: 		case 1: kp = 49; break; // 1
L_code_enter6:
	MOVLW      49
	MOVWF      _kp+0
	GOTO       L_code_enter5
;Cerradura Electronica.c,42 :: 		case 2: kp = 50; break; // 2
L_code_enter7:
	MOVLW      50
	MOVWF      _kp+0
	GOTO       L_code_enter5
;Cerradura Electronica.c,43 :: 		case 3: kp = 51; break; // 3
L_code_enter8:
	MOVLW      51
	MOVWF      _kp+0
	GOTO       L_code_enter5
;Cerradura Electronica.c,44 :: 		case 5: kp = 52; break; // 4
L_code_enter9:
	MOVLW      52
	MOVWF      _kp+0
	GOTO       L_code_enter5
;Cerradura Electronica.c,45 :: 		case 6: kp = 53; break; // 5
L_code_enter10:
	MOVLW      53
	MOVWF      _kp+0
	GOTO       L_code_enter5
;Cerradura Electronica.c,46 :: 		case 7: kp = 54; break; // 6
L_code_enter11:
	MOVLW      54
	MOVWF      _kp+0
	GOTO       L_code_enter5
;Cerradura Electronica.c,47 :: 		case 9: kp = 55; break; // 7
L_code_enter12:
	MOVLW      55
	MOVWF      _kp+0
	GOTO       L_code_enter5
;Cerradura Electronica.c,48 :: 		case 10: kp = 56; break; // 8
L_code_enter13:
	MOVLW      56
	MOVWF      _kp+0
	GOTO       L_code_enter5
;Cerradura Electronica.c,49 :: 		case 11: kp = 57; break; // 9
L_code_enter14:
	MOVLW      57
	MOVWF      _kp+0
	GOTO       L_code_enter5
;Cerradura Electronica.c,50 :: 		case  4: kp = 65; break; // A
L_code_enter15:
	MOVLW      65
	MOVWF      _kp+0
	GOTO       L_code_enter5
;Cerradura Electronica.c,51 :: 		case  8: kp = 66; break; // B
L_code_enter16:
	MOVLW      66
	MOVWF      _kp+0
	GOTO       L_code_enter5
;Cerradura Electronica.c,52 :: 		case 12: kp = 67; break; // C
L_code_enter17:
	MOVLW      67
	MOVWF      _kp+0
	GOTO       L_code_enter5
;Cerradura Electronica.c,53 :: 		case 16: kp = 68; break; // D
L_code_enter18:
	MOVLW      68
	MOVWF      _kp+0
	GOTO       L_code_enter5
;Cerradura Electronica.c,54 :: 		case 13: kp = 42; break; // *
L_code_enter19:
	MOVLW      42
	MOVWF      _kp+0
	GOTO       L_code_enter5
;Cerradura Electronica.c,55 :: 		case 14: kp = 48; break; // 0
L_code_enter20:
	MOVLW      48
	MOVWF      _kp+0
	GOTO       L_code_enter5
;Cerradura Electronica.c,56 :: 		case 15: kp = 35; break; // #
L_code_enter21:
	MOVLW      35
	MOVWF      _kp+0
	GOTO       L_code_enter5
;Cerradura Electronica.c,57 :: 		}
L_code_enter4:
	MOVF       _kp+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_code_enter6
	MOVF       _kp+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_code_enter7
	MOVF       _kp+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_code_enter8
	MOVF       _kp+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_code_enter9
	MOVF       _kp+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_code_enter10
	MOVF       _kp+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_code_enter11
	MOVF       _kp+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_code_enter12
	MOVF       _kp+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_code_enter13
	MOVF       _kp+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_code_enter14
	MOVF       _kp+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_code_enter15
	MOVF       _kp+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_code_enter16
	MOVF       _kp+0, 0
	XORLW      12
	BTFSC      STATUS+0, 2
	GOTO       L_code_enter17
	MOVF       _kp+0, 0
	XORLW      16
	BTFSC      STATUS+0, 2
	GOTO       L_code_enter18
	MOVF       _kp+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_code_enter19
	MOVF       _kp+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_code_enter20
	MOVF       _kp+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_code_enter21
L_code_enter5:
;Cerradura Electronica.c,58 :: 		code1[i] = kp;
	MOVF       _i+0, 0
	ADDLW      _code1+0
	MOVWF      FSR
	MOVF       _kp+0, 0
	MOVWF      INDF+0
;Cerradura Electronica.c,59 :: 		Lcd_Chr(2, i+6, code1[i]);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      6
	ADDWF      _i+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _i+0, 0
	ADDLW      _code1+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Cerradura Electronica.c,60 :: 		i++;
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Cerradura Electronica.c,61 :: 		}
L_end_code_enter:
	RETURN
; end of _code_enter

_delay_20ms:

;Cerradura Electronica.c,62 :: 		void delay_20ms()
;Cerradura Electronica.c,64 :: 		Delay_ms(20);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_delay_20ms22:
	DECFSZ     R13+0, 1
	GOTO       L_delay_20ms22
	DECFSZ     R12+0, 1
	GOTO       L_delay_20ms22
	NOP
;Cerradura Electronica.c,66 :: 		}
L_end_delay_20ms:
	RETURN
; end of _delay_20ms

_code_read:

;Cerradura Electronica.c,67 :: 		void code_read()
;Cerradura Electronica.c,69 :: 		delay_20ms();
	CALL       _delay_20ms+0
;Cerradura Electronica.c,70 :: 		user1[0] = EEPROM_Read(0x00);
	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _user1+0
;Cerradura Electronica.c,71 :: 		delay_20ms();
	CALL       _delay_20ms+0
;Cerradura Electronica.c,72 :: 		user1[1] = EEPROM_Read(0x01);
	MOVLW      1
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _user1+1
;Cerradura Electronica.c,73 :: 		delay_20ms();
	CALL       _delay_20ms+0
;Cerradura Electronica.c,74 :: 		user1[2] = EEPROM_Read(0x02);
	MOVLW      2
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _user1+2
;Cerradura Electronica.c,75 :: 		delay_20ms();
	CALL       _delay_20ms+0
;Cerradura Electronica.c,76 :: 		user1[3] = EEPROM_Read(0x03);
	MOVLW      3
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _user1+3
;Cerradura Electronica.c,77 :: 		delay_20ms();
	CALL       _delay_20ms+0
;Cerradura Electronica.c,78 :: 		}
L_end_code_read:
	RETURN
; end of _code_read

_code_write:

;Cerradura Electronica.c,79 :: 		void code_write()
;Cerradura Electronica.c,81 :: 		delay_20ms();
	CALL       _delay_20ms+0
;Cerradura Electronica.c,82 :: 		EEPROM_Write(0x00,code1[0]);
	CLRF       FARG_EEPROM_Write_Address+0
	MOVF       _code1+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Cerradura Electronica.c,83 :: 		delay_20ms();
	CALL       _delay_20ms+0
;Cerradura Electronica.c,84 :: 		EEPROM_Write(0x01,code1[1]);
	MOVLW      1
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _code1+1, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Cerradura Electronica.c,85 :: 		delay_20ms();
	CALL       _delay_20ms+0
;Cerradura Electronica.c,86 :: 		EEPROM_Write(0x02,code1[2]);
	MOVLW      2
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _code1+2, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Cerradura Electronica.c,87 :: 		delay_20ms();
	CALL       _delay_20ms+0
;Cerradura Electronica.c,88 :: 		EEPROM_Write(0x03,code1[3]);
	MOVLW      3
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _code1+3, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Cerradura Electronica.c,89 :: 		}
L_end_code_write:
	RETURN
; end of _code_write

_change_code:

;Cerradura Electronica.c,90 :: 		void change_code()
;Cerradura Electronica.c,91 :: 		{ top2:
___change_code_top2:
;Cerradura Electronica.c,92 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Cerradura Electronica.c,93 :: 		Lcd_Out(1, 2, " NUEVO CODIGO");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Cerradura_32Electronica+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Cerradura Electronica.c,94 :: 		Delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_change_code23:
	DECFSZ     R13+0, 1
	GOTO       L_change_code23
	DECFSZ     R12+0, 1
	GOTO       L_change_code23
	DECFSZ     R11+0, 1
	GOTO       L_change_code23
	NOP
	NOP
;Cerradura Electronica.c,95 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
;Cerradura Electronica.c,96 :: 		code_enter();
	CALL       _code_enter+0
;Cerradura Electronica.c,97 :: 		if(code1[0] == 42)
	MOVF       _code1+0, 0
	XORLW      42
	BTFSS      STATUS+0, 2
	GOTO       L_change_code24
;Cerradura Electronica.c,98 :: 		{goto top2 ;}
	GOTO       ___change_code_top2
L_change_code24:
;Cerradura Electronica.c,99 :: 		code_enter();
	CALL       _code_enter+0
;Cerradura Electronica.c,100 :: 		if(code1[1] == 42)
	MOVF       _code1+1, 0
	XORLW      42
	BTFSS      STATUS+0, 2
	GOTO       L_change_code25
;Cerradura Electronica.c,101 :: 		{goto top2 ;}
	GOTO       ___change_code_top2
L_change_code25:
;Cerradura Electronica.c,102 :: 		code_enter();
	CALL       _code_enter+0
;Cerradura Electronica.c,103 :: 		if(code1[2] == 42)
	MOVF       _code1+2, 0
	XORLW      42
	BTFSS      STATUS+0, 2
	GOTO       L_change_code26
;Cerradura Electronica.c,104 :: 		{goto top2 ;}
	GOTO       ___change_code_top2
L_change_code26:
;Cerradura Electronica.c,105 :: 		code_enter();
	CALL       _code_enter+0
;Cerradura Electronica.c,106 :: 		if(code1[3] == 42)
	MOVF       _code1+3, 0
	XORLW      42
	BTFSS      STATUS+0, 2
	GOTO       L_change_code27
;Cerradura Electronica.c,107 :: 		{goto top2 ;}
	GOTO       ___change_code_top2
L_change_code27:
;Cerradura Electronica.c,108 :: 		code_enter();
	CALL       _code_enter+0
;Cerradura Electronica.c,109 :: 		if(code1[4] == 42)
	MOVF       _code1+4, 0
	XORLW      42
	BTFSS      STATUS+0, 2
	GOTO       L_change_code28
;Cerradura Electronica.c,110 :: 		{goto top2 ;}
	GOTO       ___change_code_top2
L_change_code28:
;Cerradura Electronica.c,111 :: 		if(code1[4] == 35){
	MOVF       _code1+4, 0
	XORLW      35
	BTFSS      STATUS+0, 2
	GOTO       L_change_code29
;Cerradura Electronica.c,112 :: 		code_write();
	CALL       _code_write+0
;Cerradura Electronica.c,113 :: 		code_read();
	CALL       _code_read+0
;Cerradura Electronica.c,114 :: 		Delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_change_code30:
	DECFSZ     R13+0, 1
	GOTO       L_change_code30
	DECFSZ     R12+0, 1
	GOTO       L_change_code30
	DECFSZ     R11+0, 1
	GOTO       L_change_code30
	NOP
	NOP
;Cerradura Electronica.c,115 :: 		Lcd_Out(2,5,msg10);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _msg10+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Cerradura Electronica.c,116 :: 		Delay_ms(1500);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      157
	MOVWF      R12+0
	MOVLW      5
	MOVWF      R13+0
L_change_code31:
	DECFSZ     R13+0, 1
	GOTO       L_change_code31
	DECFSZ     R12+0, 1
	GOTO       L_change_code31
	DECFSZ     R11+0, 1
	GOTO       L_change_code31
	NOP
	NOP
;Cerradura Electronica.c,117 :: 		}
	GOTO       L_change_code32
L_change_code29:
;Cerradura Electronica.c,119 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Cerradura Electronica.c,120 :: 		Lcd_Out(1,7, "ERROR");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_Cerradura_32Electronica+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Cerradura Electronica.c,121 :: 		Delay_ms(1000); }
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_change_code33:
	DECFSZ     R13+0, 1
	GOTO       L_change_code33
	DECFSZ     R12+0, 1
	GOTO       L_change_code33
	DECFSZ     R11+0, 1
	GOTO       L_change_code33
	NOP
	NOP
L_change_code32:
;Cerradura Electronica.c,122 :: 		}
L_end_change_code:
	RETURN
; end of _change_code

_main:

;Cerradura Electronica.c,123 :: 		void main()
;Cerradura Electronica.c,125 :: 		ADCON1 |= 0x07;
	MOVLW      7
	IORWF      ADCON1+0, 1
;Cerradura Electronica.c,126 :: 		TRISA = 0x00;
	CLRF       TRISA+0
;Cerradura Electronica.c,128 :: 		Keypad_Init();
	CALL       _Keypad_Init+0
;Cerradura Electronica.c,129 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Cerradura Electronica.c,130 :: 		code_read();
	CALL       _code_read+0
;Cerradura Electronica.c,132 :: 		if(user1[0] == 0xFF && user1[1] == 0xFF && user1[2] == 0xFF && user1[3] == 0xFF
	MOVF       _user1+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_main36
	MOVF       _user1+1, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_main36
	MOVF       _user1+2, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_main36
	MOVF       _user1+3, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_main36
;Cerradura Electronica.c,133 :: 		)
L__main84:
;Cerradura Electronica.c,135 :: 		EEPROM_Write(0x00,'2');
	CLRF       FARG_EEPROM_Write_Address+0
	MOVLW      50
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Cerradura Electronica.c,136 :: 		delay_20ms();
	CALL       _delay_20ms+0
;Cerradura Electronica.c,137 :: 		EEPROM_Write(0x01,'5');
	MOVLW      1
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      53
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Cerradura Electronica.c,138 :: 		delay_20ms();
	CALL       _delay_20ms+0
;Cerradura Electronica.c,139 :: 		EEPROM_Write(0x02,'8');
	MOVLW      2
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      56
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Cerradura Electronica.c,141 :: 		delay_20ms();
	CALL       _delay_20ms+0
;Cerradura Electronica.c,142 :: 		EEPROM_Write(0x03,'0');
	MOVLW      3
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      48
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Cerradura Electronica.c,143 :: 		}
L_main36:
;Cerradura Electronica.c,144 :: 		code_read();
	CALL       _code_read+0
;Cerradura Electronica.c,145 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Cerradura Electronica.c,146 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Cerradura Electronica.c,147 :: 		Delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main37:
	DECFSZ     R13+0, 1
	GOTO       L_main37
	DECFSZ     R12+0, 1
	GOTO       L_main37
	DECFSZ     R11+0, 1
	GOTO       L_main37
	NOP
	NOP
;Cerradura Electronica.c,148 :: 		Lcd_Out(1, 2,msg1 );
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _msg1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Cerradura Electronica.c,149 :: 		Lcd_Out(2, 3,msg6 );
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _msg6+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Cerradura Electronica.c,150 :: 		Delay_ms(3000);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_main38:
	DECFSZ     R13+0, 1
	GOTO       L_main38
	DECFSZ     R12+0, 1
	GOTO       L_main38
	DECFSZ     R11+0, 1
	GOTO       L_main38
	NOP
	NOP
;Cerradura Electronica.c,151 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Cerradura Electronica.c,152 :: 		cnt=0;
	CLRF       _cnt+0
	CLRF       _cnt+1
;Cerradura Electronica.c,153 :: 		do
L_main39:
;Cerradura Electronica.c,154 :: 		{ top:
___main_top:
;Cerradura Electronica.c,155 :: 		PORTA.B0=1;
	BSF        PORTA+0, 0
;Cerradura Electronica.c,156 :: 		PORTA.B3=0;
	BCF        PORTA+0, 3
;Cerradura Electronica.c,157 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Cerradura Electronica.c,158 :: 		Lcd_Out(2, 4, "PRECIONAR '*'");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_Cerradura_32Electronica+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Cerradura Electronica.c,159 :: 		i = 0;
	CLRF       _i+0
	CLRF       _i+1
;Cerradura Electronica.c,160 :: 		code_enter();
	CALL       _code_enter+0
;Cerradura Electronica.c,161 :: 		if(code1[0] == 42)
	MOVF       _code1+0, 0
	XORLW      42
	BTFSS      STATUS+0, 2
	GOTO       L_main42
;Cerradura Electronica.c,162 :: 		{   top3:
___main_top3:
;Cerradura Electronica.c,163 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Cerradura Electronica.c,164 :: 		Lcd_Out(1, 4, msg2);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _msg2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Cerradura Electronica.c,166 :: 		i = 0;
	CLRF       _i+0
	CLRF       _i+1
;Cerradura Electronica.c,167 :: 		code_enter();
	CALL       _code_enter+0
;Cerradura Electronica.c,168 :: 		if(code1[0] == 42)
	MOVF       _code1+0, 0
	XORLW      42
	BTFSS      STATUS+0, 2
	GOTO       L_main43
;Cerradura Electronica.c,169 :: 		{goto top3 ;}
	GOTO       ___main_top3
L_main43:
;Cerradura Electronica.c,170 :: 		code_enter();
	CALL       _code_enter+0
;Cerradura Electronica.c,171 :: 		if(code1[1] == 42)
	MOVF       _code1+1, 0
	XORLW      42
	BTFSS      STATUS+0, 2
	GOTO       L_main44
;Cerradura Electronica.c,172 :: 		{goto top3 ;}
	GOTO       ___main_top3
L_main44:
;Cerradura Electronica.c,173 :: 		code_enter();
	CALL       _code_enter+0
;Cerradura Electronica.c,174 :: 		if(code1[2] == 42)
	MOVF       _code1+2, 0
	XORLW      42
	BTFSS      STATUS+0, 2
	GOTO       L_main45
;Cerradura Electronica.c,175 :: 		{goto top3 ;}
	GOTO       ___main_top3
L_main45:
;Cerradura Electronica.c,176 :: 		code_enter();
	CALL       _code_enter+0
;Cerradura Electronica.c,177 :: 		if(code1[3] == 42)
	MOVF       _code1+3, 0
	XORLW      42
	BTFSS      STATUS+0, 2
	GOTO       L_main46
;Cerradura Electronica.c,178 :: 		{goto top3 ;}
	GOTO       ___main_top3
L_main46:
;Cerradura Electronica.c,179 :: 		code_enter();
	CALL       _code_enter+0
;Cerradura Electronica.c,180 :: 		if(code1[4] == 42)
	MOVF       _code1+4, 0
	XORLW      42
	BTFSS      STATUS+0, 2
	GOTO       L_main47
;Cerradura Electronica.c,181 :: 		{goto top3 ;}
	GOTO       ___main_top3
L_main47:
;Cerradura Electronica.c,183 :: 		if(code1[0] == '1' && code1[1] == '1' && code1[2] == '1' && code1[3] == '1' && code1[4] == '1')          //check master code
	MOVF       _code1+0, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_main50
	MOVF       _code1+1, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_main50
	MOVF       _code1+2, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_main50
	MOVF       _code1+3, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_main50
	MOVF       _code1+4, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_main50
L__main83:
;Cerradura Electronica.c,185 :: 		code_enter();
	CALL       _code_enter+0
;Cerradura Electronica.c,186 :: 		if(code1[5] == 35)
	MOVF       _code1+5, 0
	XORLW      35
	BTFSS      STATUS+0, 2
	GOTO       L_main51
;Cerradura Electronica.c,188 :: 		change_code();
	CALL       _change_code+0
;Cerradura Electronica.c,189 :: 		goto top ;
	GOTO       ___main_top
;Cerradura Electronica.c,190 :: 		}
L_main51:
;Cerradura Electronica.c,191 :: 		}
L_main50:
;Cerradura Electronica.c,192 :: 		if(cnt<3 && code1[0] == user1[0] && code1[1] == user1[1] && code1[2] == user1
	MOVLW      128
	XORWF      _cnt+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main92
	MOVLW      3
	SUBWF      _cnt+0, 0
L__main92:
	BTFSC      STATUS+0, 0
	GOTO       L_main54
	MOVF       _code1+0, 0
	XORWF      _user1+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main54
	MOVF       _code1+1, 0
	XORWF      _user1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main54
;Cerradura Electronica.c,193 :: 		[2] && code1[3] == user1[3] && code1[4] == 35)
	MOVF       _code1+2, 0
	XORWF      _user1+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main54
	MOVF       _code1+3, 0
	XORWF      _user1+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main54
	MOVF       _code1+4, 0
	XORLW      35
	BTFSS      STATUS+0, 2
	GOTO       L_main54
L__main82:
;Cerradura Electronica.c,194 :: 		{ if(PORTA.B2 == 1)
	BTFSS      PORTA+0, 2
	GOTO       L_main55
;Cerradura Electronica.c,196 :: 		PORTA.B2=0;
	BCF        PORTA+0, 2
;Cerradura Electronica.c,197 :: 		cnt=0;
	CLRF       _cnt+0
	CLRF       _cnt+1
;Cerradura Electronica.c,198 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Cerradura Electronica.c,199 :: 		Lcd_Out(1,2,msg1);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _msg1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Cerradura Electronica.c,200 :: 		Delay_ms(3000);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_main56:
	DECFSZ     R13+0, 1
	GOTO       L_main56
	DECFSZ     R12+0, 1
	GOTO       L_main56
	DECFSZ     R11+0, 1
	GOTO       L_main56
	NOP
	NOP
;Cerradura Electronica.c,201 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Cerradura Electronica.c,202 :: 		goto top ;
	GOTO       ___main_top
;Cerradura Electronica.c,203 :: 		}
L_main55:
;Cerradura Electronica.c,205 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Cerradura Electronica.c,206 :: 		Lcd_Out(1, 2, msg3);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _msg3+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Cerradura Electronica.c,207 :: 		Lcd_Out(2, 2, msg7);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _msg7+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Cerradura Electronica.c,208 :: 		cnt=0;
	CLRF       _cnt+0
	CLRF       _cnt+1
;Cerradura Electronica.c,209 :: 		PORTA.B0=0;
	BCF        PORTA+0, 0
;Cerradura Electronica.c,210 :: 		PORTA.B2=1;
	BSF        PORTA+0, 2
;Cerradura Electronica.c,211 :: 		Delay_ms(6000);
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_main57:
	DECFSZ     R13+0, 1
	GOTO       L_main57
	DECFSZ     R12+0, 1
	GOTO       L_main57
	DECFSZ     R11+0, 1
	GOTO       L_main57
	NOP
;Cerradura Electronica.c,212 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Cerradura Electronica.c,213 :: 		Lcd_Out(2, 2, msg7);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _msg7+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Cerradura Electronica.c,215 :: 		for(i=0; i<3; i++) {
	CLRF       _i+0
	CLRF       _i+1
L_main58:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main93
	MOVLW      3
	SUBWF      _i+0, 0
L__main93:
	BTFSC      STATUS+0, 0
	GOTO       L_main59
;Cerradura Electronica.c,216 :: 		Lcd_Cmd(_LCD_SHIFT_RIGHT);
	MOVLW      28
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Cerradura Electronica.c,217 :: 		Move_Delay();}
	CALL       _Move_Delay+0
;Cerradura Electronica.c,215 :: 		for(i=0; i<3; i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Cerradura Electronica.c,217 :: 		Move_Delay();}
	GOTO       L_main58
L_main59:
;Cerradura Electronica.c,218 :: 		Delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main61:
	DECFSZ     R13+0, 1
	GOTO       L_main61
	DECFSZ     R12+0, 1
	GOTO       L_main61
	DECFSZ     R11+0, 1
	GOTO       L_main61
	NOP
	NOP
;Cerradura Electronica.c,219 :: 		for(i=0; i<5; i++) {
	CLRF       _i+0
	CLRF       _i+1
L_main62:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main94
	MOVLW      5
	SUBWF      _i+0, 0
L__main94:
	BTFSC      STATUS+0, 0
	GOTO       L_main63
;Cerradura Electronica.c,220 :: 		Lcd_Cmd(_LCD_SHIFT_LEFT);
	MOVLW      24
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Cerradura Electronica.c,221 :: 		Move_Delay();}
	CALL       _Move_Delay+0
;Cerradura Electronica.c,219 :: 		for(i=0; i<5; i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Cerradura Electronica.c,221 :: 		Move_Delay();}
	GOTO       L_main62
L_main63:
;Cerradura Electronica.c,222 :: 		Delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main65:
	DECFSZ     R13+0, 1
	GOTO       L_main65
	DECFSZ     R12+0, 1
	GOTO       L_main65
	DECFSZ     R11+0, 1
	GOTO       L_main65
	NOP
	NOP
;Cerradura Electronica.c,223 :: 		for(i=0; i<2; i++) {
	CLRF       _i+0
	CLRF       _i+1
L_main66:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main95
	MOVLW      2
	SUBWF      _i+0, 0
L__main95:
	BTFSC      STATUS+0, 0
	GOTO       L_main67
;Cerradura Electronica.c,224 :: 		Lcd_Cmd(_LCD_SHIFT_RIGHT);
	MOVLW      28
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Cerradura Electronica.c,225 :: 		Move_Delay();}
	CALL       _Move_Delay+0
;Cerradura Electronica.c,223 :: 		for(i=0; i<2; i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Cerradura Electronica.c,225 :: 		Move_Delay();}
	GOTO       L_main66
L_main67:
;Cerradura Electronica.c,226 :: 		Delay_ms(2000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main69:
	DECFSZ     R13+0, 1
	GOTO       L_main69
	DECFSZ     R12+0, 1
	GOTO       L_main69
	DECFSZ     R11+0, 1
	GOTO       L_main69
	NOP
	NOP
;Cerradura Electronica.c,227 :: 		}
	GOTO       L_main70
L_main54:
;Cerradura Electronica.c,231 :: 		cnt++;
	INCF       _cnt+0, 1
	BTFSC      STATUS+0, 2
	INCF       _cnt+1, 1
;Cerradura Electronica.c,232 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Cerradura Electronica.c,233 :: 		Lcd_Out(1, 3,msg4 );
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _msg4+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Cerradura Electronica.c,234 :: 		Delay_ms(2000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main71:
	DECFSZ     R13+0, 1
	GOTO       L_main71
	DECFSZ     R12+0, 1
	GOTO       L_main71
	DECFSZ     R11+0, 1
	GOTO       L_main71
	NOP
	NOP
;Cerradura Electronica.c,235 :: 		}
L_main70:
;Cerradura Electronica.c,236 :: 		if(cnt>=3)
	MOVLW      128
	XORWF      _cnt+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main96
	MOVLW      3
	SUBWF      _cnt+0, 0
L__main96:
	BTFSS      STATUS+0, 0
	GOTO       L_main72
;Cerradura Electronica.c,240 :: 		PORTA.B2=0;
	BCF        PORTA+0, 2
;Cerradura Electronica.c,241 :: 		PORTA.B0=0;
	BCF        PORTA+0, 0
;Cerradura Electronica.c,242 :: 		PORTA.B3=1;
	BSF        PORTA+0, 3
;Cerradura Electronica.c,243 :: 		while(u<3) {
L_main76:
	MOVLW      128
	XORWF      _u+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main97
	MOVLW      3
	SUBWF      _u+0, 0
L__main97:
	BTFSC      STATUS+0, 0
	GOTO       L_main77
;Cerradura Electronica.c,244 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Cerradura Electronica.c,245 :: 		Delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main78:
	DECFSZ     R13+0, 1
	GOTO       L_main78
	DECFSZ     R12+0, 1
	GOTO       L_main78
	DECFSZ     R11+0, 1
	GOTO       L_main78
	NOP
	NOP
;Cerradura Electronica.c,246 :: 		Lcd_Out(1, 3, msg8 );
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _msg8+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Cerradura Electronica.c,247 :: 		Delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main79:
	DECFSZ     R13+0, 1
	GOTO       L_main79
	DECFSZ     R12+0, 1
	GOTO       L_main79
	DECFSZ     R11+0, 1
	GOTO       L_main79
	NOP
	NOP
;Cerradura Electronica.c,248 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Cerradura Electronica.c,249 :: 		Delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main80:
	DECFSZ     R13+0, 1
	GOTO       L_main80
	DECFSZ     R12+0, 1
	GOTO       L_main80
	DECFSZ     R11+0, 1
	GOTO       L_main80
	NOP
	NOP
;Cerradura Electronica.c,250 :: 		Lcd_Out(1, 3, msg8 );
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _msg8+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Cerradura Electronica.c,251 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main81:
	DECFSZ     R13+0, 1
	GOTO       L_main81
	DECFSZ     R12+0, 1
	GOTO       L_main81
	DECFSZ     R11+0, 1
	GOTO       L_main81
	NOP
	NOP
;Cerradura Electronica.c,252 :: 		u++;
	INCF       _u+0, 1
	BTFSC      STATUS+0, 2
	INCF       _u+1, 1
;Cerradura Electronica.c,253 :: 		}
	GOTO       L_main76
L_main77:
;Cerradura Electronica.c,254 :: 		cnt=2;
	MOVLW      2
	MOVWF      _cnt+0
	MOVLW      0
	MOVWF      _cnt+1
;Cerradura Electronica.c,255 :: 		u=0;
	CLRF       _u+0
	CLRF       _u+1
;Cerradura Electronica.c,256 :: 		goto top ;
	GOTO       ___main_top
;Cerradura Electronica.c,259 :: 		}
L_main72:
;Cerradura Electronica.c,260 :: 		}
L_main42:
;Cerradura Electronica.c,262 :: 		while(1);
	GOTO       L_main39
;Cerradura Electronica.c,263 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
