/*
 * music.asm
 * Module "music" , look up table avec la mélodie et fonction music et play pour jouer les notes.
 *  
   
  
 */



.include "sound.asm"					; inclus les routines pour la musique et les labels pour les notes 

 ;Notes de la musique
musique:
	.db	si2,1,si2,fam2,1,fam2,si2,1,si2,fam2,1,fam2,1,fam2,so2,1  
	.db so2,1,so2,la2,so2,fam2,1,fam2,1,fam2,mi2,1,mi2,1,mi2,1
	.db mi2,re2,1,re2,1,re2,1,re2,dom2,1,dom2,re2,dom2,1,si,1
	.db	0 ;fin de la musique 

music:	
	ldi		zl, low(2*musique)			;initialise le pointeur z au debut de la musique 
	ldi		zh,high(2*musique)
play:	
	cpi		b3,1						;regarde si le boutton SW1=1, interrupetion pour arreter la musique 
	breq	end1 
	lpm									;charge la note à jouer dans r0
	adiw	zl,1						;incremente le poointeur z 
	tst		r0							;test si c'est la fin de la musique 
	breq	end							;saute à end si fin de la musique
	mov		a0,r0						;met la note r0 dans a0
	ldi		b0,100					
	rcall	sound						;appelle la sous routine sound de sound.asm
	rjmp	play

end:
	rjmp music							;recommence la musique 

end1:
	rcall efface_lcd					;efface le lcd 
	jmp main							;retour au menu principal

			
	