

name1  db "ax$"
name2  db "bx$"
name3  db "cx$"
name4  db "dx$"
name5  db "si$"
name6  db "di$"
name7  db "bp$"
name8  db "sp$"
name9  db "ds$"
name10 db "es$"
name11 db "ss$"
name12 db "cs$"
name13 db "ip$$"


drawbuffer db 2*25*80 dup (0)

;----------------------------------------------
; shows all regs in drawbuffer
;----------------------------------------------
; entry:   dh:dl - coords of first simbol
;          ch    - color
;          cl    - style
;          in stack:
; ip cs ss es ds sp bp di si dx cx bx ax
; exit:    none
; destr:   
;----------------------------------------------

draw proc

    push dx
    push cx

    mov di, cx; save cx

    mov cl, ch
    xor ch, ch
    mov si, cx; si = color

    mov cx, di; restore cx
    xor ch, ch
    mov di, cx; di = style

    mov ch, 11;  width
    mov cl, 13; height

    call drawstyled

    pop cx
    pop dx

    add dh, 2; new x
    add dl, 1; new y


    mov bx, offset name1
    pop si; save return adress
    @@next:

        call drawname

        mov bp, si; save return adress
        pop si
        push bx cx dx
        add dh, 3
        call showh
        pop dx cx bx
        mov si, bp; save return adress

        add dl, 1; \n

        cmp byte ptr [bx], '$'
        jne @@next

    push si; save return adress

    ret
    endp

;----------------------------------------------

;----------------------------------------------
; draws reg's name on the screen
;----------------------------------------------
; entry:   dh:dl - coords of first simbol
;          ch    - color
;      ds:[bx]   - name, ended by $
; exit:    cs:[bx] = "first after $"
; destr:   ax, bp
;----------------------------------------------

drawname proc

    push cx
    calculateoffsetbp
    add bp, offset drawbuffer

    mov cl, ch
    xor ch, ch

    @@next:

        cmp byte ptr [bx], '$'
        je @@end

        mov     ax,     [bx]
        mov ds:[bp],     ax; letter

        ;push bp; save bp
        ;push cx
        ;call getcolor
        ;pop cx
        ;pop bp; restore bp

        mov ds:[bp + 1], cl; color

        add bx, 1
        add bp, 2

    jmp @@next


    @@end:

        add bx, 1
        pop cx
        ret
        endp

;----------------------------------------------

