	macro LOAD_DATA name,dest,size, offset 
		ld ix,name
		ld hl,dest
		ld bc,size
		ld de,offset
		call load_data
	endm 

	macro SAVE_DATA name,source,size
		ld ix,name
		ld hl,source
		ld bc,size
		call save_data
	endm

	macro ESXDOS command
		rst 8
		db command
	endm


;TODO:
;success signal of some kind.
;better error handling.

	
M_GETSETDRV 	equ $89
F_OPEN 			equ $9a
F_CLOSE 		equ $9b
F_READ 			equ $9d
F_WRITE 		equ $9e
F_SEEK 			equ $9f
F_GET_DIR 		equ $a8
F_SET_DIR 		equ $a9

FA_READ 		equ $01
FA_WRITE 		equ $02
FA_APPEND 		equ $06
FA_OVERWRITE 	equ $0C

; ***************************************************************************
; * F_OPEN ($9a) *
; ***************************************************************************
; Open a file.
; Entry:
; A=drive specifier (overridden if filespec includes a drive)
; IX [HL from dot command]=filespec, null-terminated
; B=access modes, a combination of:
; any/all of:
; esx_mode_read $01 request read access
; esx_mode_write $02 request write access
; esx_mode_use_header $40 read/write +3DOS header
; plus one of:
; esx_mode_open_exist $00 only open existing file
; esx_mode_open_creat $08 open existing or create file
; esx_mode_creat_noexist $04 create new file, error if exists
; esx_mode_creat_trunc $0c create new file, delete existing
;
; DE=8-byte buffer with/for +3DOS header data (if specified in mode)
; (NB: filetype will be set to $ff if headerless file was opened)
; Exit (success):
; Fc=0 (flag carry zero)
; A=file handle
; Exit (failure):
; Fc=1
; A=error code


; ***************************************************************************
; * F_SEEK ($9f) *
; ***************************************************************************
; Seek to position in file.
; Entry:
; A=file handle
; BCDE=bytes to seek
; IXL [L from dot command]=seek mode:
; esx_seek_set $00 set the fileposition to BCDE
; esx_seek_fwd $01 add BCDE to the fileposition
; esx_seek_bwd $02 subtract BCDE from the fileposition
; Exit (success):
; Fc=0
; BCDE=current position
; Exit (failure):
; Fc=1
; A=error code
;
; NOTES:
; Attempts to seek past beginning/end of file leave BCDE=position=0/filesize
; respectively, with no error.


handle db 0


load_data:
    push hl
	push bc
	push de
	ld a,'*'
	ld b,FA_READ

	ESXDOS F_OPEN 
	jp c,failedtoload

	ld (handle),a

	pop de

	ld ixl,0
	ld bc,0

	ESXDOS F_SEEK

	ld a,(handle)

	pop bc 
	pop ix

	ESXDOS F_READ

	ld a,(handle)
	ESXDOS F_CLOSE
    ret
;

failedtoload:
	nextreg $69,0
	ld hl,failedtoloadtext : call printrstfailed
	push ix : pop hl : call printrstfailed
	di : halt 
;

printrstfailed;
	ld a,(hl) : or a : ret z : rst 16 : inc hl : jp printrstfailed
;

failedtoloadtext:
	db "Failed to load : ",0
;
	


; ***************************************************************************
; * F_WRITE ($9e) *
; ***************************************************************************
; Write bytes to file.
; Entry:
; A=file handle
; IX [HL from dot command]=address
; BC=bytes to write
; Exit (success):
; Fc=0
; BC=bytes actually written
; Exit (failure):
; Fc=1
; BC=bytes actually written


save_data:
    push hl
	push bc
	ld a,'*'
	ld b,FA_OVERWRITE|FA_WRITE

	ESXDOS F_OPEN 
	jp c,failedtosave

	ld (handle),a

	pop bc 
	pop ix

	ESXDOS F_WRITE

	ld a,(handle)
	ESXDOS F_CLOSE
    ret
;

failedtosave:
	; BREAKPOINT
	ret