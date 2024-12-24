/*
 * Affichage.asm
   Module Affichage : fonctions qui affichent des messages sur l'écran lcd
	 340997	Rim El Qabli
	 341115	Frottier Zoé
 */ 

 .include "lcd.asm"					; inclus les routines LCD
 .include "printf.asm"				; inclus les routines d'affichage 

 afficheTcible:
	rcall		LCD_clear			;efface le contenu du lcd
	rcall		LCD_lf				;met le curseur sur la deuxieme ligne 
	PRINTF		LCD					
.db	"Temp cible=",FDEC,10,"C",0
ret

affiche_msg_pret:
	rcall		LCD_clear
	PRINTF		LCD
.db "**!c'est pret!**",0

	rcall		LCD_lf
	PRINTF		LCD
.db "****************",0
ret

affiche_msg_principal:
rcall		LCD_home				
	PRINTF		LCD					
.db "****READTEA****",0
rcall		LCD_lf					;met le curseur sur la deuxieme ligne
	PRINTF LCD
.db	"Temp cible=",0	
ret
		
affiche_Tact:						;affiche la temperature mesuré par le capteur de temperature
	rcall		LCD_home
	PRINTF	LCD
.db	"Temp act=",FDEC,18,"C",0
ret 

efface_lcd:
	rcall LCD_clear	
	ret