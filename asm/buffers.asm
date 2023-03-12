;----------------------------------------------
; saves screen in an array
;----------------------------------------------
; entry:   n/a
; exit:    none
; destr:   ax, bx, cx, si, di, es (controlled)
;----------------------------------------------

savedflag   db 0
savedscreen db 2*25*80 dup (0)

savescreen proc

    cmp byte ptr savedflag, 1
    je @@checksave

    @@forcesave: ; принудительный save (вызывается в первый раз)

        loadvideoesbx

        mov si, 0;                  source
        mov di, offset savedscreen; dest

        mov cx, 25*80;  ascii AND color at a time

        @@saveword1:

            mov ax, es:[si]; ascii AND color
            mov [di], ax

            add si, 2
            add di, 2

        loop @@saveword1
        mov savedflag, 1; now saved
        jmp @@end


    @@checksave: ; осторожный save

        loadvideoesbx

        mov si, 0;                  source
        mov di, offset savedscreen; dest
        mov bx, offset drawbuffer;  drawbuffer

        mov cx, 25*80;  ascii AND color at a time

        @@saveword2:

            mov ax, es:[si]; ascii AND color
            cmp ax, ds:[bx]; what should be there
            je @@nextword; check if it should be there

            mov [di], ax; rewrite saved

            @@nextword:
                add si, 2
                add di, 2
                add bx, 2

        loop @@saveword2
        jmp @@end

    @@end:

        ret
        endp
;----------------------------------------------


;----------------------------------------------
; copies drawbuffer to vidmem
;----------------------------------------------
; entry:   n/a
; exit:    none
; destr:   ax, cx, si, di, es (controlled)
;----------------------------------------------

drawvidmem proc

    loadvideoesbp


    mov si, offset drawbuffer;  source
    mov di, 0;                  dest


    mov cx, 25*80;  ascii AND color at a time

    @@drawword:

        mov ax,      ds:[si]; ascii AND color
        mov es:[di], ax

        add si, 2
        add di, 2

    loop @@drawword


    ret
    endp
;----------------------------------------------

;----------------------------------------------
; copies savedscreen to drawbuffer
;----------------------------------------------
; entry:   n/a
; exit:    none
; destr:   ax, cx, si, di, es (controlled)
;----------------------------------------------

copysavedtodraw proc

    mov si, offset savedscreen; source
    mov di, offset drawbuffer;  dest


    mov cx, 25*80;  ascii AND color at a time

    @@copyword:

        mov ax,      ds:[si]; ascii AND color
        mov ds:[di], ax

        add si, 2
        add di, 2

    loop @@copyword


    ret
    endp
;----------------------------------------------


;----------------------------------------------
; copies savedscreen to vidmem
; !!!called by isr09h!!!
; !!!must be clean!!!
;----------------------------------------------
; entry:   n/a
; exit:    none
; destr:   none!!! because it is called by isr09h, where we don't save registers
;----------------------------------------------

restorescreen proc

    push ax cx si di bp es
    loadvideoesbp


    mov si, offset savedscreen;  source
    mov di, 0;                  dest


    mov cx, 25*80;  ascii AND color at a time

    @@drawword:

        mov ax,      cs:[si]; ascii AND color
        mov es:[di], ax

        add si, 2
        add di, 2

    loop @@drawword


    pop es bp di si cx ax

    ret
    endp
;----------------------------------------------