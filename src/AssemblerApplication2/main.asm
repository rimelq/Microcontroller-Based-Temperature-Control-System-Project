/* Projet de Microcontroleur Readtea
	main.asm
	340997	Rim El Qabli
	341115	Frottier Zoé
*/
.include "macros.asm"
.include "definitions.asm"

; === Table d'interruption  ===
.org	0
	jmp	reset
	jmp	ext_int0
	jmp ext_int1
	
ext_int0:						;	Interruption retour menu principal
	ldi a3,1
	rcall LCD_clear	
	reti

ext_int1:						; Interruption stop music et retour menu principal 
	ldi b3,1
	reti

reset:
	LDSP		RAMEND 			
	rcall		wire1_init				; initialise l'interface 1-wire(R) 
	rcall		LCD_init				; initialise le lcd 
	OUTI		EIMSK,0b00000011		; active les interruptions sur les bouttons SW0 ET SW1 
	sbi			DDRE,SPEAKER			; met la pin SPEAKER en sortie 
	sei									; autorise les interruptions 
	rjmp		main					; saute au main 


.include "Telecommande.asm"
.include "Temperature.asm"
.include "music.asm"
.include "Affichage.asm"


main:
	ldi			a3,0					; initialise le registre pour l'interruption de retour au menu principal
	rcall		affiche_msg_principal
	rcall		telecommande			;appelle la sous-routine qui recoit les chiffres de la télécommande , les décode et stocke le resultat dans c2
	rcall		afficheTcible			;appelle la sous-routine qui affiche la temperature cible saisie avec la télécommande
	rcall		loopCompareTemp			;apppelle la sous-routine qui compare la temperature actuelle et la temperature cible 
	rjmp		main

bip:			;réponse du microcontroleur lorsque Tcible=Tact
	rcall		affiche_msg_pret
	rcall		music

