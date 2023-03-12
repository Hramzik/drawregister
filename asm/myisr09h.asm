

;----------------------------------------------
; checks for SHOW/NOTSHOW scan codes and links/unlinks myisr08h to system timer
;            SHUTDOWN = unlink myisr09h
;----------------------------------------------
; entry:   n/a
; exit:    none
; destr:   
;----------------------------------------------

myisr08hloaded db 0

SHOW     equ 3Bh; f1
NOTSHOW  equ 3Ch; f2
SHUTDOWN equ 3Dh; f3

new09h proc
    push ax

    in al, 60h

    cmp al, SHOW
    je @@loadmy08h

    cmp al, NOTSHOW
    je @@unloadmy08h

    cmp al, SHUTDOWN
    je @@unloadmy09h


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


    iret


@@loadmy08h:

    pop ax
    cmp byte ptr cs:myisr08hloaded, 0
    jne @@exit


    call loadnew08h
    mov byte ptr cs:myisr08hloaded, 1


    jmp @@exit

@@unloadmy09h:

    call loadold09h

@@unloadmy08h:

    pop ax
    cmp byte ptr cs:myisr08hloaded, 1
    jne @@exit


    call loadold08h
    call restorescreen
    mov byte ptr cs:myisr08hloaded, 0


    jmp @@exit


    endp

;----------------------------------------------
