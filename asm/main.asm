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

    call loadnew09h

    loaddxresident
    myexitresident

end start