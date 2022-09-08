#define __SFR_OFFSET 0x20
 
#include "avr/io.h"

.global start
.global forever
.equ  portd , 0x0b
.equ  ddrd , 0x0a
.equ  pind , 0x09
.equ  portc , 0x08
.equ  ddrc  , 0x07
.equ  pinc  , 0x06
.equ  portb , 0x05
.equ  ddrb  , 0x04
.equ  pinb  , 0x03
.equ  porta , 0x02
.equ  ddra  , 0x01
.equ  pina  , 0x00
.equ  tifr0 , 0x15
.equ  ocr0b , 0x28
.equ  ocr0a , 0x27
.equ  tcnt0 , 0x26
.equ  tccr0b , 0x25
.equ  tccr0a , 0x24

.equ rojo, 0x01
.equ amarillo, 0x02
.equ verde, 0x04


start:
  LDI R16, 0x00
  LDI R17, 0xFF
  OUT ddrb, R17 ; Semaforo no prioritario
  OUT ddra, R17 ; Semaforo prioritario
  OUT ddrc, R16 ; Switch para coches
  OUT porta, R16  ; Escribir 0 en PORTA
  OUT portb, R16  ; Escribir 0 en PORTD
  OUT tccr0a, R16   ; Setting all bits of TCCR0A as 0
  LDI R19, 0x02
  LDI R31, verde
  LDI R30, amarillo
  LDI R27, rojo
  RET

forever:
  Ent5:SBIS pinc, 4
  RJMP Ent4
  LDI R23, 80
  OUT porta, R31
  OUT portb, R27
  RCALL delayUniv
  LDI R23, 20
  OUT porta, R30
  OUT portb, R27
  RCALL delayUniv
  LDI R23, 80
  OUT porta, R27
  OUT portb, R31
  RCALL delayUniv
  LDI R23, 20
  OUT porta, R27
  OUT portb, R30
  RCALL delayUniv
  RJMP Ent5
 
  Ent4:SBIS pinc, 3
  RJMP Ent3
  LDI R23, 80
  OUT porta, R31
  OUT portb, R27
  RCALL delayUniv
  LDI R23, 20
  OUT porta, R30
  OUT portb, R27
  RCALL delayUniv
  LDI R23, 64
  OUT porta, R27
  OUT portb, R31
  RCALL delayUniv
  LDI R23, 16
  OUT porta, R27
  OUT portb, R30
  RCALL delayUniv
  RJMP Ent5

  Ent3:SBIS pinc, 2
  RJMP Ent2
  LDI R23, 80;
  OUT porta, R31
  OUT portb, R27
  RCALL delayUniv
  LDI R23, 20;
  OUT porta, R30
  OUT portb, R27
  RCALL delayUniv
  LDI R23, 48
  OUT porta, R27
  OUT portb, R31
  RCALL delayUniv
  LDI R23, 12
  OUT porta, R27
  OUT portb, R30
  RCALL delayUniv
  RJMP Ent5

  Ent2:SBIS pinc, 1
  RJMP Ent1
  LDI R23, 80
  OUT porta, R31
  OUT portb, R27
  RCALL delayUniv
  LDI R23, 20
  OUT porta, R30
  OUT portb, R27
  RCALL delayUniv
  LDI R23, 32
  OUT porta, R27
  OUT portb, R31
  RCALL delayUniv
  LDI R23, 8
  OUT porta, R27
  OUT portb, R30
  RCALL delayUniv
  RJMP Ent5

  Ent1:SBIS pinc, 0
  RJMP Ent0
  LDI R23, 80
  OUT porta, R31
  OUT portb, R27
  RCALL delayUniv
  LDI R23, 20;
  OUT porta, R30
  OUT portb, R27
  RCALL delayUniv
  LDI R23, 16
  OUT porta, R27
  OUT portb, R31
  RCALL delayUniv
  LDI R23, 4
  OUT porta, R27
  OUT portb, R30
  RCALL delayUniv
  RJMP Ent5

  Ent0:LDI R23, 80;
  RCALL delayUniv
  ;SBI porta, 2
  ;SBI portb, 0
  OUT porta, R31
  OUT portb, R27
  RJMP Ent5
 
  delayUniv:
L3:LDI R22, 0xA0
L2:OUT tccr0b, R19
L:IN R21, tifr0
  SBRS R21, 0
  RJMP L
  OUT tccr0b, R16
  LDI R18, 0x01
  OUT tifr0, R18
  DEC R22
  BRNE L2
  DEC R23
  BRNE L3
  OUT tccr0b, R16
  OUT tcnt0, R16
  RET
 
  RET
