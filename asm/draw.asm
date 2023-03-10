

name1 db "ax$"
name1 db "bx$"
name1 db "cx$"
name1 db "dx$"
name1 db "si$"
name1 db "di$"
name1 db "bp$"
name1 db "sp$"
name1 db "ds$"
name1 db "es$"
name1 db "ss$"
name1 db "cs$"
name1 db "ip$$"

;----------------------------------------------
; shows all regs on screen
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

    mov di, cx; style
    xor cl, cl
    mov si, cx; color
    mov cx, di
    xor ch, ch
    mov di, cx; style

    mov ch, 9;  width
    mov cl, 15; height

    sub dh, 1; x
    sub dl, 1; y

    call drawaframe

    pop cx
    pop dx

    add dh, 1
    add dl, 1


    mov bx, offset name1
    pop si; save return adress
    @@next:

        call drawname

        mov bp, si; save return adress
        pop si
        push bx cx dx
        call showh
        pop dx cx bx
        mov si, bp; save return adress

        add dl, 1; \n

        cmp [bx], '$'
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
;      cs:[bx]   - name, ended by $
; exit:    cs:[bx] = "first after $"
; destr:   ax, bp
;----------------------------------------------

drawname proc

    loadvideoes
    calculateoffsetbp


    @@next:

        cmp [bx], '$'
        je @@end

        mov     ax,     [bx]
        mov es:[bp],     ax; letter
        mov es:[bp + 1], ch

        add bx, 1
        add bp, 2

    jmp @@next


    @@end:

        add bx, 1
        ret
        endp

;----------------------------------------------

