/*
 * Temperature.asm
	Module Temperature : fonction temperature pour lire , decoder et stocker la temperature depuis le capteur de temperature  
	340997	Rim El Qabli
	341115	Frottier Zo�

 */ 
 .include "wire1.asm"					; inclus les routines communication 1-wire

 temperature:
	ldi			b3,0					;intialise le registre pour le retour menu principal ( modifi� avec l'interruption)
	rcall		wire1_reset			
	CA	wire1_write, skipROM		
	CA	wire1_write, convertT		
	WAIT_MS		750						
	
	
	rcall		wire1_reset				;mesure la temp�rature 
	CA			wire1_write, skipROM
	CA			wire1_write, readScratchpad	
	rcall		wire1_read
			
	mov			c0,a0
	rcall		wire1_read			
	mov			a1,a0
	mov			a0,c0					; temperature stock� dans a0 et a1
	
	andi		a0,0b11110000			;Masquage pour r�cuperer la partie enti�re de la temperature et stocker le resultat dans a0
	swap		a0
	andi		a1,0b00001111
	swap		a1
	add			a0,a1

	rcall		affiche_Tact			;affiche la temperature actuelle sur le LCD
	cpi			a3,1					;verifie si il y a eu une interruption pour retourner au menu principal ( boutton SW0)
	brne		PC+2
	rjmp		main					;retour au menu si interruption (a3=1)
ret  



loopCompareTemp:
	rcall	temperature					;mesure la temperature 
    cp c2, a0;							;compare la temperature cible (dans c2) avec la temperature actuelle (dans a0)
	breq bip2							;saute � bip2 
	rjmp loopCompareTemp

bip2:	rjmp bip						;saute � bip qui affiche le message et saute � la musique 