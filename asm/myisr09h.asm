

;----------------------------------------------
; checks for SHOW/NOTSHOW scan codes and links/unlinks myisr08h to system timer
;            SHUTDOWN = unlink myisr09h
;----------------------------------------------
; entry:   n/a
; exit:    none
; destr:   
;----------------------------------------------

myisr08hloaded db 0
rainbowflag    db 1
reacttorainow  db 1

SHOW        equ  3Bh; f1
NOTSHOW     equ  3Ch; f2
SHUTDOWN    equ  3Dh; f3
RAINBOW     equ  3Eh; f4
RAINBOW_upd equ 0BEh; f4 up, f4 works in toggle mode

new09h proc
    push ax

    in al, 60h

    cmp al, SHOW
    je @@loadmy08h

    cmp al, NOTSHOW
    je @@unloadmy08h

    cmp al, SHUTDOWN
    je @@unloadmy09h

    cmp al, RAINBOW
    je @@rainbow

    cmp al, RAINBOW_upd
    je @@rainbow_upd


@@nextisr:

    pop ax
    db 0eah; jmp far, call old isr

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

    cmp byte ptr reacttorainow, 0
    je @@exit


    not rainbowflag
    shl byte ptr rainbowflag, 7
    shr byte ptr rainbowflag, 7

    mov reacttorainow, 0


    jmp @@exit

@@rainbow_upd:

    mov reacttorainow, 1
    je @@exit

    endp

;----------------------------------------------
