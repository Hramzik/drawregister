;----------------------------------------------
; saves screen in an array
;----------------------------------------------
; entry:   n/a
; exit:    none
; destr:   bx, cx, si, di
;----------------------------------------------

savedscreen db 2*25*80 dup (0)

savescreen proc

    loadvideoes

    mov si, 0;                  source
    mov di, offset savedscreen; dest

    mov cx, 25*80

    @@saveword:
        mov bx, es:[si]
        mov [di], bx

        add si, 2
        add di, 2

    loop @@saveword

    ret
    endp
;----------------------------------------------
