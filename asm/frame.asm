



style1 db 218, 196, 191, 179, 32, 179, 192, 196, 217
style2 db 197, 196, 197, 179, 32, 179, 197, 196, 197
style3 db 176, 176, 176, 176, 32, 176, 176, 176, 176
style4 db 177, 177, 177, 177, 32, 177, 177, 177, 177
style5 db 249, 249, 249, 249, 32, 249, 249, 249, 249
style6 db 35,  35,  35,  35,  32, 35,  35,  35,  35
style7 db 15,  15,  15,  15,  32, 15,  15,  15,  15
style8 db 4,   4,   4,   4,   32, 4,   4,   4,   4
style9 db 3,   3,   3,   3,   32, 3,   3,   3,   3
;style9 db 0,   0,   0,   0,   0, 0,   0,   0,   0


;----------------------------------------------
; draws a frame in entered style in drawbuffer
;----------------------------------------------
; entry:   dh, dl   - coords of top-left
;          ch, cl   - w, h
;          si       - color
;          di       - number of the style
; exit:    none
; destr:   ax, bx, cx, dx, di
;----------------------------------------------

drawstyled proc

    cmp di, 1
    je @@style1

    cmp di, 2
    je @@style2

    cmp di, 3
    je @@style3

    cmp di, 4
    je @@style4

    cmp di, 5
    je @@style5

    cmp di, 6
    je @@style6

    cmp di, 7
    je @@style7

    cmp di, 8
    je @@style8

    cmp di, 9
    je @@style9

    jmp @@style1; default style


    @@style1:
        mov bp, offset style1
        jmp @@draw

    @@style2:
        mov bp, offset style2
        jmp @@draw

    @@style3:
        mov bp, offset style3
        jmp @@draw

    @@style4:
        mov bp, offset style4
        jmp @@draw

    @@style5:
        mov bp, offset style5
        jmp @@draw

    @@style6:
        mov bp, offset style6
        jmp @@draw

    @@style7:
        mov bp, offset style7
        jmp @@draw

    @@style8:
        mov bp, offset style8
        jmp @@draw

    @@style9:
        mov bp, offset style9
        jmp @@draw

    @@draw:
        call drawaframe
        ret

    endp
;----------------------------------------------




;----------------------------------------------
; draws a frame using 9-simbol string in drawbuffer
;----------------------------------------------
; entry:   dh, dl   - coords of top-left
;          ch, cl   - w, h
;          si       - color
;         [bp], ... - simbols for the frame
; exit:    none
; destr:   ax, bx, cx, dx, di
;----------------------------------------------

drawaframe proc

    calculateoffsetbx
    add bx, offset drawbuffer


    mov al, ch; width
    xor ch, ch
    mov cl, cl; counter


    mov di, cx; save cx

    mov dh, ds:[bp];   left
    mov dl, ds:[bp+1]; mid
    mov ah, ds:[bp+2]; right
    mov al, al;     width
    call drawaline

    mov cx, di

    @@next:
        mov di, cx; save cx

        mov dh, ds:[bp+3]; left
        mov dl, ds:[bp+4]; mid
        mov ah, ds:[bp+5]; right
        mov al, al;     width
        call drawaline

        mov cx, di

    loop @@next

    mov dh, ds:[bp+6]; left
    mov dl, ds:[bp+7]; mid
    mov ah, ds:[bp+8]; right
    mov al, al;     width
    call drawaline


    ret
    endp

;----------------------------------------------

;----------------------------------------------
; draws a line in drawbuffer
;----------------------------------------------
; entry:   dh, dl - left, mid ascii
;          ah, al - right ascii, width
;          bx     - start offset
;          si     - color
; exit:    bx = <next line start>
; destr:   ah, bx, cx
;----------------------------------------------

drawaline proc
    push bp; save bp


    mov ds:[bx],   dh
    mov ds:[bx+1], si; color
    add bx, 2

    xor ch, ch
    mov cl, al
    sub cl, 2d; крайние
    @@next:
        mov ds:[bx],   dl

        push ax
        push si
        call getframecolor
        pop si
        pop ax
        mov ds:[bx+1], si; color

        add bx, 2

    loop @@next

    mov ds:[bx],   ah
    mov ds:[bx+1], si; color
    add bx, 2

    xor ah, ah
    sub bx, ax
    sub bx, ax
    add bx, 160d


    pop bp; restore bp
    ret
    endp

;----------------------------------------------

