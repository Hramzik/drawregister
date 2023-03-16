

;----------------------------------------------
; changes a color in stack to random if needed
;----------------------------------------------
; entry:   [sp] - color
;          rainbowflag - true/false
; exit:    none
; destr:   ax, bp
;----------------------------------------------
currentcolor db ?
seed         db ?

getcolor proc

    cmp byte ptr rainbowflag, 0
    je @@end

    mov al, currentcolor
    add al, 1
    mov currentcolor, al

    xor ah, ah
    mov bp, sp
    mov ss:[bp + 2], ax


    @@end:

        ret
        endp

;----------------------------------------------
