;=============================================================================
;                 ‡ ¤ ­ЁҐ # 18. ” ©« 18int09.asm
;  Џа®бвҐ©и п аҐ§Ё¤Ґ­в­ п Їа®Ја ¬¬ , ЇҐаҐеў влў ой п ЇаҐалў ­ЁҐ 09
;               Copyright (c) 2002 Andreev Andrey
;=============================================================================

;-----------------------------------------------(c) Andreev Andrey, 2002--;
; Occupy interrupt 09h (keypressed)                                       ;
;-------------------------------------------------------------------------;
.model tiny

.code
org 100h

start:          jmp main
;--Resident part - new int09h and call last ISR---------------------------;
new09           proc
                push es ax

                in al, 60h
                cmp al, 01h
                jne exit

                mov ax, 0b800h
                mov es, ax
                mov es:0000h, 4e41h     ; red 'A' -> screen

exit:           

                pop ax es
                db 0eah ; jmp far       ; call last ISR
OldISR          dd 0bad0badh

                endp

;--Not resident part------------------------------------------------------;
main:           .386

                mov ax, 0
                mov ds, ax
                mov si, 09h*4
                mov ax, cs
                mov es, ax
                mov di, offset OldISR
                movsd

                mov ax, 0               ; ЇҐаҐеў в ЇаҐалў ­Ёп 09h
                mov ds, ax
                mov bx, 09h*4

                mov ax, offset new09  ; IntrTable [09h] = &new09
                mov [bx], ax
                mov ax, es
                mov [bx+2], es

                mov dx, offset main     ; ®бв ў«Ґ­ЁҐ Їа®ЈЁ аҐ§Ё¤Ґ­в®¬
                shl dx, 4
                inc dx
                mov ax, 3100h
                int 21h
end start
;--The end.---------------------------------------------------------------;