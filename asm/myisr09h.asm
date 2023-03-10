

;----------------------------------------------
; checks for f11/f12 and links/unlinks myisr2 to system timer
;            f = unlink myisr1
;----------------------------------------------
; entry:   n/a
; exit:    none
; destr:   
;----------------------------------------------

myisr08hloaded db 0

new09h proc
    push ax

    in al, 60h

    cmp al, 57h
    je @@loadmy08h

    cmp al, 58h
    je @@unloadmy08h

    cmp al, 3ch
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
    cmp byte ptr myisr08hloaded, 0
    jne @@exit


    call loadnew08h
    mov byte ptr myisr08hloaded, 1


    jmp @@exit

@@unloadmy08h:

    pop ax
    cmp byte ptr myisr08hloaded, 1
    jne @@exit


    call loadold08h
    mov byte ptr myisr08hloaded, 0


    jmp @@exit


@@unloadmy09h:

    pop ax
    call loadold09h

    jmp @@exit


    endp

;----------------------------------------------