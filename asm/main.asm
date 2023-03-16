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
include buffers.asm
include rainbow.asm

main:

    ;call loadnew08h
    ;int 08h
    ;call new08h
    call loadnew09h
    ;call new08h

    loaddxresident
    myexitresident

end start