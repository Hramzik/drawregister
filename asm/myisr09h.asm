

;----------------------------------------------
; checks for SHOW/NOTSHOW scan codes and links/unlinks myisr08h to system timer
;            SHUTDOWN = unlink myisr09h
;----------------------------------------------
; entry:   n/a
; exit:    none
; destr:   
;----------------------------------------------

myisr08hloaded db 0

rainbowflags   db 0; (* * * * * vals names frame)
currentcolor   db 0; (frame, names, vals) more like current editing color

colorframe     db 04h;
colornames     db 04h;
colorvals      db 04h;

SHOW        equ  3Bh; f1
NOTSHOW     equ  3Ch; f2
SHUTDOWN    equ  3Dh; f3

FRAME       equ  3Eh; f4, switches current modified color
NAMES       equ  3Fh; f5
VALS        equ  40h; f6
PLUS        equ  4Eh; num plus
MINUS       equ  4Ah; num minus
RAND        equ  37h; num mult
RAINBOW     equ  52h; zero on numpad

new09h proc

    cli; sti нету, только при восстановлении флагов
    push ax
    movdscs

    in al, 60h

    cmp al, SHOW
    je @@loadmy08h

    cmp al, NOTSHOW
    je @@unloadmy08h

    cmp al, SHUTDOWN
    je @@unloadmy09h

    cmp al, RAINBOW
    je @@rainbow

    cmp al, FRAME
    je @@frame

    cmp al, NAMES
    je @@names

    cmp al, VALS
    je @@vals

    cmp al, PLUS
    je @@plus

    cmp al, MINUS
    je @@minus

    cmp al, RAND
    je @@rand


@@nextisr:

    mov ds, oldds
    pop ax
    db 0eah; jmp far, to old isr

old09h db 4 dup (0)


@@exit:

    in  al, 61h
    and al, 01111111b
    out 61h, al
    or  al, 10000000b
    out 61h, al


    mov al, 20h
    out 20h, al


    pop ax


    iret


@@loadmy08h:

    cmp byte ptr cs:myisr08hloaded, 0
    jne @@exit


    call loadnew08h
    mov byte ptr cs:myisr08hloaded, 1


    jmp @@exit

@@unloadmy09h:

    call loadold09h

@@unloadmy08h:

    cmp byte ptr cs:myisr08hloaded, 1
    jne @@exit


    call loadold08h
    call restorescreen
    mov byte ptr cs:myisr08hloaded, 0


    jmp @@exit

@@rainbow:

    call rainbowmanager; rainbow.asm
    jmp @@exit

@@frame:

    mov byte ptr currentcolor, 0
    jmp @@exit

@@names:

    mov byte ptr currentcolor, 1
    jmp @@exit

@@vals:

    mov byte ptr currentcolor, 2
    jmp @@exit

@@plus:

    call plusmanager; rainbow.asm
    jmp @@exit

@@minus:

    call minusmanager; rainbow.asm
    jmp @@exit

@@rand:

    call randmanager; rainbow.asm
    jmp @@exit


    endp
;----------------------------------------------
