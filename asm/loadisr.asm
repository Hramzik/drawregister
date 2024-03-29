

;----------------------------------------------
; loads new isr09h, while saving the old one
;----------------------------------------------
; entry:   n/a
; exit:    none
; destr:   ax, bx, si, di, dx, es
;----------------------------------------------

;old09h db 4 dup (0)

loadnew09h proc

    mov ax, 0
    mov ds, ax
    mov si, 09h*4
    mov ax, cs
    mov es, ax
    mov di, offset old09h
    cld
    movsw
    movsw; load old isr09 address to old09h

    mov ax, 0
    mov ds, ax
    mov bx, 09h*4
    mov ax, offset new09h
    mov ds:[bx], ax;   load new isr09 address to 0:[09h*4]
    mov ds:[bx+2], cs; load new isr09 segment


    ret
    endp
;----------------------------------------------

;----------------------------------------------
; loads old isr09h
;----------------------------------------------
; entry:   n/a
; exit:    none
; destr:   none
;----------------------------------------------

loadold09h proc

    push ax si di ds es

    mov ax, cs
    mov ds, ax
    mov si, offset old09h

    mov ax, 0
    mov es, ax
    mov di, 09h*4

    cld
    movsw
    movsw; load old isr09 address to 0:[09h*4]

    pop es ds di si ax


    ret
    endp
;----------------------------------------------


;----------------------------------------------
; loads new isr08h, while saving the old one
;----------------------------------------------
; entry:   n/a
; exit:    none
; destr:   none
;----------------------------------------------

;old08h db 4 dup (0)

loadnew08h proc

    push ax bx si di ds es


    mov ax, 0
    mov ds, ax
    mov si, 08h*4
    mov ax, cs
    mov es, ax
    mov di, offset old08h

    cld
    movsw
    movsw; load old isr08 address to old08h

    mov ax, 0
    mov ds, ax
    mov bx, 08h*4
    mov ax, offset new08h
    mov ds:[bx],   ax; load new isr08 address to 0:[08h*4]
    mov ax, cs
    mov ds:[bx+2], cs; load new isr08 segment


    pop es ds di si bx ax


    ret
    endp
;----------------------------------------------

;----------------------------------------------
; loads old isr08h
;----------------------------------------------
; entry:   n/a
; exit:    none
; destr:   none
;----------------------------------------------

loadold08h proc

    push ax si di ds es


    mov ax, cs
    mov ds, ax
    mov si, offset old08h

    mov ax, 0
    mov es, ax
    mov di, 08h*4

    cld
    movsw
    movsw; load old isr08 address to 0:[08h*4]

    pop es ds di si ax


    ret
    endp
;----------------------------------------------
