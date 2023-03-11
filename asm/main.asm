.286
.model tiny
.code
org 100h
locals @@

start:
    jmp main

include macro.asm
include loadisr.asm
include myisr09h.asm
include myisr08h.asm
include show.asm
include frame.asm
include draw.asm

main:

    call loadnew08h
    ;call loadnew09h
    ;call new08h

    loaddxresident
    myexitresident

end start