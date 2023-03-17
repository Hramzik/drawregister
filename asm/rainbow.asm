

;----------------------------------------------
; changes a color in stack to random if needed
;----------------------------------------------
; entry:   [sp] - color
;          rainbowflags [7] - true/false
; exit:    none
; destr:   ax, bp
;----------------------------------------------
seedcolor db ?; used by this rainbow functions to generate random colors
seed      db ?; used by this rainbow functions to generate random colors

getframecolor proc

    mov al, rainbowflags; get rainbowflags
    shl al, 7
    shr al, 7
    cmp byte ptr al, 0
    je @@end

    mov al, seedcolor
    add al, 1
    mov seedcolor, al

    xor ah, ah
    mov bp, sp
    mov ss:[bp + 2], ax


    @@end:

        ret
        endp

;----------------------------------------------


;----------------------------------------------
; changes a color in stack to random if needed
;----------------------------------------------
; entry:   [sp] - color
;          rainbowflags [6] - true/false
; exit:    none
; destr:   ax, bp
;----------------------------------------------

getnamescolor proc

    mov al, rainbowflags; get rainbowflags
    shl al, 6
    shr al, 6
    shr al, 1
    shl al, 1
    cmp byte ptr al, 0
    je @@end

    mov al, seedcolor
    add al, 1
    mov seedcolor, al

    xor ah, ah
    mov bp, sp
    mov ss:[bp + 2], ax


    @@end:

        ret
        endp

;----------------------------------------------


;----------------------------------------------
; changes a color in stack to random if needed
;----------------------------------------------
; entry:   [sp] - color
;          rainbowflags [5] - true/false
; exit:    none
; destr:   ax, bp
;----------------------------------------------

getvalscolor proc

    mov al, rainbowflags; get rainbowflags
    shl al, 5
    shr al, 5
    shr al, 2
    shl al, 2
    cmp byte ptr al, 0
    je @@end

    mov al, seedcolor
    add al, 1
    mov seedcolor, al

    xor ah, ah
    mov bp, sp
    mov ss:[bp + 2], ax


    @@end:

        ret
        endp

;----------------------------------------------


;----------------------------------------------
; changes bits of rainbowflags according to currentcolor
;----------------------------------------------
; entry:   currentcolor = 0/1/2
; destr:   al (normal for myisr09h)
;----------------------------------------------

rainbowmanager proc

    cmp byte ptr currentcolor, 0
    je @@frame

    cmp byte ptr currentcolor, 1
    je @@names

    cmp byte ptr currentcolor, 2
    je @@vals


    @@frame:

        mov al,      rainbowflags
        and byte ptr rainbowflags, 11111110b

        not al
        and al, 000000001b

        or rainbowflags, al

        jmp @@end

    @@names:

        mov al,      rainbowflags
        and byte ptr rainbowflags, 11111101b

        not al
        and al, 00000010b

        or rainbowflags, al

        jmp @@end

    @@vals:

        mov al,      rainbowflags
        and byte ptr rainbowflags, 11111011b

        not al
        and al, 00000100b

        or rainbowflags, al

        jmp @@end


    @@end:

        ret
        endp
;----------------------------------------------


;----------------------------------------------
; adds one to colorframe/colornames/colorvals
;----------------------------------------------
; entry:   currentcolor = 0/1/2
; destr:   none
;----------------------------------------------

plusmanager proc

    cmp byte ptr currentcolor, 0
    je @@frame

    cmp byte ptr currentcolor, 1
    je @@names

    cmp byte ptr currentcolor, 2
    je @@vals


    @@frame:
        add colorframe, 1
        jmp @@end
    @@names:
        add colornames, 1
        jmp @@end
    @@vals:
        add colorvals,  1
        jmp @@end

    @@end:

        ret
        endp
;----------------------------------------------


;----------------------------------------------
; subs one to colorframe/colornames/colorvals
;----------------------------------------------
; entry:   currentcolor = 0/1/2
; destr:   none
;----------------------------------------------

minusmanager proc

    cmp byte ptr currentcolor, 0
    je @@frame

    cmp byte ptr currentcolor, 1
    je @@names

    cmp byte ptr currentcolor, 2
    je @@vals


    @@frame:
        sub colorframe, 1
        jmp @@end
    @@names:
        sub colornames, 1
        jmp @@end
    @@vals:
        sub colorvals,  1
        jmp @@end

    @@end:

        ret
        endp
;----------------------------------------------


;----------------------------------------------
; rands colorframe/colornames/colorvals
;----------------------------------------------
; entry:   currentcolor = 0/1/2
; destr:   al
;----------------------------------------------

randmanager proc

    cmp byte ptr currentcolor, 0
    je @@frame

    cmp byte ptr currentcolor, 1
    je @@names

    cmp byte ptr currentcolor, 2
    je @@vals


    @@frame:
        shl colorframe, 1
        jmp @@end
    @@names:
        shl colornames, 1
        jmp @@end
    @@vals:
        shl colorvals, 1
        jmp @@end

    @@end:

        ret
        endp
;----------------------------------------------