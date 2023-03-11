

VIDMEM equ 0b800h

;----------------------------------
; loads ES with video seg addr
;----------------------------------
; entry:    none
; exit:     ES = 0b800h
; destroys: bp; самая важная часть!
;----------------------------------
loadvideoes macro

    nop
    mov bp, VIDMEM
    mov ES, bp
    nop

    endm
;----------------------------------

;----------------------------------
; loads ES with video seg addr
;----------------------------------
; entry:    none
; exit:     ES = 0b800h
; destroys: bx; самая важная часть!
;----------------------------------
loadvideoesbx macro

    nop
    mov bx, VIDMEM
    mov ES, bx
    nop

    endm
;----------------------------------

;----------------------------------------------
; exit to dos
;----------------------------------------------
; entry: n/a
; exit:  n/a
; destr: n/a
;----------------------------------------------
myexit macro

    nop
    mov ax, 4c00h
    int 21h
    nop

    endm
;----------------------------------------------

;----------------------------------------------
; exit to dos, stay residented
;----------------------------------------------
; entry: n/a
; exit:  n/a
; destr: n/a
;----------------------------------------------
myexitresident macro

    nop
    mov ax, 3100h
    int 21h
    nop

    endm
;----------------------------------------------

;----------------------------------------------
; loads dx with needed memory to stay residented up to main:
;----------------------------------------------
; entry: n/a
; exit:  n/a
; destr: n/a
;----------------------------------------------
loaddxresident macro

    nop
    mov dx, offset main
    shr dx, 4
    add dx, 1
    nop

    endm
;----------------------------------------------


;----------------------------------------------
; loads bp with calculated offset in vidmem
;----------------------------------------------
; entry: dh:dl - coords
; exit:  none
; destr: ax, bp
;----------------------------------------------

calculateoffsetbp macro

    mov ax, 80d; calculating offset
    mul dl
    add al, dh
    mov bp, 2d;
    mul bp


    mov bp, ax; bp = needed

    endm
;----------------------------------------------

