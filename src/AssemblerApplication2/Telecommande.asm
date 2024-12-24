/*
 * Telecommande.asm
  Module Télécommande : fonction telecommande qui permet de lire la temperature saisie depuis la télécommande et stocke le resultat.
  340997	Rim El Qabli
  341115	Frottier Zoé
 */ 

 .equ			T1 = 1760			;periode 

telecommande:						;Lecture et decodage chiffre des dizaines
		CLR2		b1,b0			;efface les registre b0,b1
		ldi			b2,14			;initialise un compteur de bits 
		WP1			PINE,IR			;Attend si PINE=1 	
		WAIT_US		(T1/4)			
	
loop1:	
		P2C		PINE,IR			
		ROL2		b1,b0			
		WAIT_US		(T1-4)			
		DJNZ		b2,loop1			
		mov a2,b0					; stocke le chiffre des dizaines dans a2
	
		WAIT_MS		500				;Attend entre la saisie des deux chiffres

		CLR2		b1,b0			;Lecture et décodage du chiffres des unitées
		ldi			b2,14			
		WP1			PINE,IR			 	
		WAIT_US		(T1/4)	

loop:	
		P2C			PINE,IR		
		ROL2		b1,b0		
		WAIT_US		(T1-4)			
		DJNZ		b2,loop			
							
									;stocke le deuxieme chiffre dans b0
		mov			a1,b0			;Convertit les deux chiffres en un nombre
		ldi			r16,9
		mov			r17,a2
mul_loop:
		add			r17,a2
		dec			r16
		brne		mul_loop
		add			a1,r17
		mov			c2,a1			;stocke la temperature cible dans c2
	ret 