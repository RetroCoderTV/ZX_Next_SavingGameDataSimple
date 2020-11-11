	
    
;;;;;Tiles



; TILE_DEFINITIONS_SIZE equ 2048

; caveman_palette:
;     incbin 'assets/_filename_.nxp',0

;     MMU 6,16
;     org $c000

;     incbin 'assets/_filename_.til',0,TILE_DEFINITIONS_SIZE


; ; 	;courtesy of ped7g:
; ;     ; patch tile gfx with grid gfx
; ; tileN=1
; ;     DUP 128-tileN
; ;         ORG $C000 + tileN*32
; ;         DB $FF
; ;         DB {b $ } | $F0
; ;         ORG $C000 + tileN*32 + 1*4
; ;         DB {b $ } | $F0
; ;         ORG $C000 + tileN*32 + 2*4
; ;         DB {b $ } | $F0
; ;         ORG $C000 + tileN*32 + 6*4 + 3
; ;         DB {b $ } | $0F
; ;         ORG $C000 + tileN*32 + 7*4 + 3
; ;         DB $FF
; ; tileN=tileN+1
; ;     EDUP



;;
;;Caveman Walk Animation:
; A>B>C>D>A>B>C>D

;;;sprites

SPRITE_COUNT equ 1  ;<--- TOTAL SPRITE COUNT 

    MMU 6,14
    org $c000

face1:
	db  $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0;
	db  $A0, $A8, $A8, $A8, $A8, $A8, $A8, $A8, $A8, $A8, $A8, $A8, $A8, $A8, $A8, $A0;
	db  $A0, $A8, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $A8, $A0;
	db  $A0, $A8, $CC, $CC, $61, $61, $CC, $CC, $CC, $CC, $61, $61, $CC, $CC, $A8, $A0;
	db  $A0, $A8, $CC, $CC, $61, $61, $CC, $CC, $CC, $CC, $61, $61, $CC, $CC, $A8, $A0;
	db  $A0, $A8, $CC, $CC, $61, $61, $CC, $CC, $CC, $CC, $61, $61, $CC, $CC, $A8, $A0;
	db  $A0, $A8, $CC, $CC, $61, $61, $CC, $CC, $CC, $CC, $61, $61, $CC, $CC, $A8, $A0;
	db  $A0, $A8, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $A8, $A0;
	db  $A0, $A8, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $A8, $A0;
	db  $A0, $A8, $CC, $CC, $CC, $CC, $CC, $61, $61, $CC, $CC, $CC, $CC, $CC, $A8, $A0;
	db  $A0, $A8, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $A8, $A0;
	db  $A0, $A8, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $A8, $A0;
	db  $A0, $A8, $CC, $61, $61, $61, $61, $61, $61, $61, $61, $61, $61, $CC, $A8, $A0;
	db  $A0, $A8, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $A8, $A0;
	db  $A0, $A8, $A8, $A8, $A8, $A8, $A8, $A8, $A8, $A8, $A8, $A8, $A8, $A8, $A8, $A0;
	db  $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0;

    
;;;;;;Fonts
       
    
    MMU 6,17
	org 0xC000

	ds 64,0
	; incbin "fonts/font1.spr"
	; incbin "fonts/font2.spr"
	; incbin "fonts/font3.spr"
	; incbin "fonts/font4.spr"
	; incbin "fonts/font5.spr"
	; incbin "fonts/font6.spr"
	incbin "fonts/font7.spr"
	; incbin "fonts/font8.spr"
	; incbin "fonts/font9.spr"
	; incbin "fonts/font10.spr"
	; incbin "fonts/font11.spr"
	; incbin "fonts/font12.spr"
	; incbin "fonts/font13.spr"
	; incbin "fonts/font14.spr"
	; incbin "fonts/font15.spr"
	; incbin "fonts/font16.spr"
	; ; incbin "fonts/font17.spr"
	; incbin "fonts/font18.spr" *not mapped same as others (?)
	



; ;; Layer2

; 	MMU 7 n,40
; 	org $e000
; 	incbin "assets/skybigrotated.bmp", 1078