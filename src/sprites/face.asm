face_x dw (320/2)-(16/2)
face_y db (256/2)-(16/2)
face_attr2 db 0
face_attr3 db %10000000

face_slot db 0

filename db 'savegame.sav',0



; Xl, Xh, Y
gamedata:
	db 0,0,0

GAMEDATA_LENGTH equ $-gamedata


face_loadstate_init:
    ld hl,gamedata
    ld a,(hl)
    ld c,a
    inc hl
    ld a,(hl)
    ld b,a
    ld (face_x),bc
    inc hl
    ld a,(hl)
    ld (face_y),a

    ret



face_draw:
    ld a,(face_slot)
    nextreg $34,a
    
    ld hl,(face_x)
    ld a,l
    nextreg $35,a

    ld a,(face_y)
    nextreg $36,a
    
    ld a,(face_attr2)
    ld hl,(face_x)
    or h
    nextreg $37,a

    ld a,(face_attr3)
    nextreg $38,a


    ret





face_update:
    ld a,(keypressed_Q)
    cp TRUE
    call z,face_move_up

    ld a,(keypressed_A)
    cp TRUE
    call z,face_move_down

    ld a,(keypressed_O)
    cp TRUE
    call z,face_move_left

    ld a,(keypressed_P)
    cp TRUE
    call z,face_move_right

    ld a,(keypressed_S)
    cp TRUE
    call z,face_saveposition
    ld a,(keypressed_W)
    cp TRUE
    call z,face_loadposition


    ret





face_move_up:
    ld a,(face_y)
    cp 0
    ret z
    dec a
    ld (face_y),a
    ret

face_move_down:
    ld a,(face_y)
    cp 256-16
    ret z
    inc a
    ld (face_y),a

    ret




face_move_left:
    ld hl,(face_x)
    ld a,h
    or l
    ret z

    dec hl
    ld (face_x),hl
    ret

face_move_right:
    ld hl,(face_x)
    ld a,h
    cp 0
    jp z,f_mov_r
    ld a,l
    cp low 320-16
    ret nc
f_mov_r:
    inc hl
    ld (face_x),hl
    ret






face_saveposition:
    ld ix,gamedata
    ld hl,(face_x)
    ld (ix),l
    ld (ix+1),h
    ld a,(face_y)
    ld (ix+2),a

    SAVE_DATA filename,gamedata,GAMEDATA_LENGTH
    ret

face_loadposition:
    LOAD_DATA filename,gamedata,GAMEDATA_LENGTH,0
    call face_loadstate_init
    ret