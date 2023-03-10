

;----------------------------------------------
; shows register on the screen, calls old08h
;----------------------------------------------
; entry:   n/a
; exit:    none
; destr:   none
;----------------------------------------------

COLOR equ 04h

new08h proc

    pusha
    push es


    mov dh, 2
    mov dl, 2
    mov ch, COLOR
    mov cl, 9
    mov si, ax
    call showh


@@exit:

    pop es
    popa


    db 0eah; jmp far, call old isr

old08h db 4 dup (0)

    endp

;----------------------------------------------