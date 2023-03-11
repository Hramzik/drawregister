
;----------------------------------------------
; loads stack with needed info for draw proc
;----------------------------------------------
; entry: none
; exit:  in stack: 13 registers
; destr: bx, bp, sp (controlled)
;----------------------------------------------

oldbp  dw 0
oldbx  dw 0

predrawloadstack macro
    nop

    mov oldbp, bp
    mov oldbx, bx
    mov bp, sp

    mov bx, ss:[bp + (2 + 8) * 2]
    push bx; old ip (not correct, but where i will jump)

    mov bx, ss:[bp + (2 + 8 + 1) * 2]
    push bx; old cs
    push ss es
    mov bx, oldds
    push bx; old ds

    add bp, (2 + 8 + 3) * 2
    push bp; old sp

    mov bp, oldbp
    push bp; old bp
    mov bx, oldbx
    push di si dx cx bx ax; old bx

    nop
    endm
;----------------------------------------------


;----------------------------------------------
; loads registers with needed info for draw proc
;----------------------------------------------
; entry: none
; exit:  dh = 1 (top-left x)
;        dl = 1 (lop-left y)
;        ch = COLOR
;        cl = 8 (style)
; destr: cx (controlled), dx (controlled)
;----------------------------------------------

COLOR equ 04h

predrawloadreg macro
    nop

    mov dh, 1
    mov dl, 1
    mov ch, COLOR
    mov cl, 9; style

    nop
    endm
;----------------------------------------------


;----------------------------------------------
; shows register on the screen, calls old08h
;----------------------------------------------
; entry:   n/a
; exit:    none
; destr:   none
;----------------------------------------------

new08h proc

    pusha
    push es
    push ds

    movdscs
    predrawloadstack
    predrawloadreg
    call draw


@@exit:

    pop ds
    pop es
    popa


    db 0eah; jmp far, call old isr

old08h db 4 dup (0)

    endp

;----------------------------------------------



