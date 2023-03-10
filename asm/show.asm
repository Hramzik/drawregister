

;----------------------------------------------
; shows value from si in hex
;----------------------------------------------
; entry:   si    - will be shown
;          dh:dl - coords of first simbol
;          ch    - color
; exit:    none
; destr:   ax, bx, cx, dx, di, es
;----------------------------------------------

showh proc

    loadvideoes

    mov ax, 80d; calculating offset
    mul dl
    add al, dh
    mov di, 2d;
    mul di


    mov dx, si; dx = will be shown


    mov bx, ax; bx = needed
    mov al, ch; color
    mov cx, 4d; 4 symbols

@@next:
    mov di, dx
    shr di, 12
    mov ES:[bx],   di; value
    mov ES:[bx+1], al; color
    call tohexascii;   to hex

    add bx, 2
    shl dx, 4
    loop @@next

    ret
    endp

;----------------------------------------------

;----------------------------------------------
; shows value from stack in bin
;----------------------------------------------
; entry:   [sp]  - will be popped and shown
;          dh:dl - coords of first simbol
;          ch    - color
; exit:    none
; destr:   ax, bx, cx, di, sp, es
;----------------------------------------------

showb proc

    loadvideoes

    mov ax, 80d; calculating offset
    mul dl
    add al, dh
    mov di, 2d;
    mul di

    mov bx, ax; bx = needed
    pop dx; dx = will be shown
    mov al, ch; color
    mov cx, 16d; 16 symbols

@@next:
    mov di, dx
    shr di, 15
    mov ES:[bx],   di; value
    mov ES:[bx+1], al; color
    call tohexascii;   to hex

    add bx, 2
    shl dx, 1
    loop @@next

    ret
    endp

;----------------------------------------------

;----------------------------------------------
; shows value from stack in dec
;----------------------------------------------
; entry:   [sp]  - will be popped and shown
;          dh:dl - coords of first simbol
;          ch    - color
; exit:    none
; destr:   ax, bx, cx, di, sp, es
;----------------------------------------------

showd proc

    loadvideoes

    mov ax, 80d; calculating offset
    mul dl
    add al, dh
    mov di, 2d;
    mul di

    add ax, 8d; пишем с конца!!!

    mov si, ax; si = needed
    pop di; di = will be shown
    mov bh, ch; color
    mov cx, 5d; 5 symbols

@@next:
    xor dx, dx
    mov ax, di
    mov di, 10d
    div di

    mov ES:[si],   dx; value
    mov ES:[si+1], bh; color
    call tohexascii;   to hex

    sub si, 2
    xor ah, ah
    mov di, ax; devided di
    loop @@next

    ret
    endp

;----------------------------------------------

;----------------------------------------------
; changes value 1-16 in vidmem to ascii code for hex representation
;----------------------------------------------
; entry:   bx - adress in vidmem
; exit:    none
; assumes: ES = vidmem addr
; destr:   n/a
;----------------------------------------------

tohexascii proc

    cmp ES:[bx], byte ptr 9d; 0-9???
    jbe @@digittohex

    @@lettertohex:
        add ES:[bx], byte ptr 55d; A-F
        jmp @@end

    @@digittohex:
        add ES:[bx], byte ptr 48d; 0-9
        jmp @@end

    @@end:
    ret
    endp

;----------------------------------------------