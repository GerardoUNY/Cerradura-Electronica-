
unsigned short kp;
char code1[10] ,user1[4];
char msg1[20] = "...SISTEMA...",msg2[12] = "  CODIGO  ";
char msg3[] = "  PERMITIDO",msg4[15] = "  DENEGADO";
char msg5[15] = "NUEVO CODIGO",msg6[] = " PROTEGIDO " ;
char msg7[] = " *BIENVENIDO* " , msg8[] = " *PELIGRO* ";
char msg9[] = " EXITOSO ",msg10[] = "*HECHO*";

 void Move_Delay() {
  Delay_ms(100);
}
int i=0,j,cnt,u=0;

char keypadPort at PORTD;


sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;
sbit LCD_RS_Direction at TRISB2_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;

void code_enter()
{
kp = 0;

do

kp = Keypad_Key_Click();
while (!kp);

switch (kp)
  {
    case 1: kp = 49; break; // 1
    case 2: kp = 50; break; // 2
    case 3: kp = 51; break; // 3
    case 5: kp = 52; break; // 4
    case 6: kp = 53; break; // 5
    case 7: kp = 54; break; // 6
    case 9: kp = 55; break; // 7
    case 10: kp = 56; break; // 8
    case 11: kp = 57; break; // 9
    case  4: kp = 65; break; // A
    case  8: kp = 66; break; // B
    case 12: kp = 67; break; // C
    case 16: kp = 68; break; // D
    case 13: kp = 42; break; // *
    case 14: kp = 48; break; // 0
    case 15: kp = 35; break; // #
  }
code1[i] = kp;
Lcd_Chr(2, i+6, code1[i]);
i++;
}
void delay_20ms()
{
Delay_ms(20);

}
void code_read()
{
  delay_20ms();
  user1[0] = EEPROM_Read(0x00);
  delay_20ms();
  user1[1] = EEPROM_Read(0x01);
  delay_20ms();
  user1[2] = EEPROM_Read(0x02);
  delay_20ms();
  user1[3] = EEPROM_Read(0x03);
  delay_20ms();
}
void code_write()
{
  delay_20ms();
  EEPROM_Write(0x00,code1[0]);
  delay_20ms();
  EEPROM_Write(0x01,code1[1]);
  delay_20ms();
  EEPROM_Write(0x02,code1[2]);
  delay_20ms();
  EEPROM_Write(0x03,code1[3]);
}
void change_code()
{ top2:
  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Out(1, 2, " NUEVO CODIGO");
  Delay_ms(500);
i=0;
code_enter();
if(code1[0] == 42)
{goto top2 ;}
code_enter();
if(code1[1] == 42)
{goto top2 ;}
code_enter();
if(code1[2] == 42)
{goto top2 ;}
code_enter();
if(code1[3] == 42)
{goto top2 ;}
code_enter();
if(code1[4] == 42)
{goto top2 ;}
if(code1[4] == 35){
code_write();
code_read();
Delay_ms(500);
Lcd_Out(2,5,msg10);
Delay_ms(1500);
}
 else {
Lcd_Cmd(_LCD_CLEAR);
Lcd_Out(1,7, "ERROR");
Delay_ms(1000); }
}
void main()
{
  ADCON1 |= 0x07;
  TRISA = 0x00;

  Keypad_Init();
  Lcd_Init();
  code_read();

  if(user1[0] == 0xFF && user1[1] == 0xFF && user1[2] == 0xFF && user1[3] == 0xFF
  )
  {
  EEPROM_Write(0x00,'2');
  delay_20ms();
  EEPROM_Write(0x01,'5');
  delay_20ms();
  EEPROM_Write(0x02,'8');

  delay_20ms();
  EEPROM_Write(0x03,'0');
 }
 code_read();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Delay_ms(500);
 Lcd_Out(1, 2,msg1 );
 Lcd_Out(2, 3,msg6 );
 Delay_ms(3000);
 Lcd_Cmd(_LCD_CLEAR);
 cnt=0;
 do
 { top:
 PORTA.B0=1;
 PORTA.B3=0;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(2, 4, "PRECIONAR '*'");
   i = 0;
   code_enter();
   if(code1[0] == 42)
 {   top3:
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_Out(1, 4, msg2);

     i = 0;
     code_enter();
     if(code1[0] == 42)
     {goto top3 ;}
     code_enter();
     if(code1[1] == 42)
     {goto top3 ;}
     code_enter();
     if(code1[2] == 42)
     {goto top3 ;}
     code_enter();
     if(code1[3] == 42)
     {goto top3 ;}
     code_enter();
     if(code1[4] == 42)
     {goto top3 ;}

     if(code1[0] == '1' && code1[1] == '1' && code1[2] == '1' && code1[3] == '1' && code1[4] == '1')          //check master code
     {
       code_enter();
       if(code1[5] == 35)
       {
         change_code();
         goto top ;
       }
     }
     if(cnt<3 && code1[0] == user1[0] && code1[1] == user1[1] && code1[2] == user1
[2] && code1[3] == user1[3] && code1[4] == 35)
     { if(PORTA.B2 == 1)
      {
       PORTA.B2=0;
       cnt=0;
       Lcd_Cmd(_LCD_CLEAR);
       Lcd_Out(1,2,msg1);
       Delay_ms(3000);
       Lcd_Cmd(_LCD_CLEAR);
       goto top ;
       }

       Lcd_Cmd(_LCD_CLEAR);
       Lcd_Out(1, 2, msg3);
       Lcd_Out(2, 2, msg7);
       cnt=0;
       PORTA.B0=0;
       PORTA.B2=1;
       Delay_ms(6000);
       Lcd_Cmd(_LCD_CLEAR);
       Lcd_Out(2, 2, msg7);

       for(i=0; i<3; i++) {
       Lcd_Cmd(_LCD_SHIFT_RIGHT);
       Move_Delay();}
       Delay_ms(500);
       for(i=0; i<5; i++) {
       Lcd_Cmd(_LCD_SHIFT_LEFT);
       Move_Delay();}
       Delay_ms(500);
       for(i=0; i<2; i++) {
       Lcd_Cmd(_LCD_SHIFT_RIGHT);
       Move_Delay();}
       Delay_ms(2000);
      }

else
{
cnt++;
  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Out(1, 3,msg4 );
  Delay_ms(2000);
}
if(cnt>=3)
{
do
{
PORTA.B2=0;
PORTA.B0=0;
PORTA.B3=1;
while(u<3) {
Lcd_Cmd(_LCD_CLEAR);
Delay_ms(500);
Lcd_Out(1, 3, msg8 );
Delay_ms(500);
Lcd_Cmd(_LCD_CLEAR);
Delay_ms(500);
Lcd_Out(1, 3, msg8 );
Delay_ms(1000);
u++;
}
cnt=2;
u=0;
goto top ;
}
while(1);
}
}
}
while(1);
}