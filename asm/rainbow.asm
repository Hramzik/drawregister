

;----------------------------------------------
; changes a color in stack to random if needed
;----------------------------------------------
; entry:   [sp] - color
;          rainbowflag - true/false
; exit:    none
; destr:   ax, bp
;----------------------------------------------
currentcolor db ?
seed  db ?

getcolor proc

    cmp byte ptr rainbowflag, 0
    je @@end

    mov al, currentcolor
    xor al, seed
    shl al, 2
    add al, 69
    xor byte ptr seed, al
    shl byte ptr seed, 3
    sub byte ptr seed, 42
    xor byte ptr seed, al
    mov currentcolor, al

    xor ah, ah
    mov bp, sp
    mov ss:[bp + 2], ax


    @@end:

        ret
        endp

;----------------------------------------------
