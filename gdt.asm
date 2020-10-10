gdt_nulldesc:
    dd 0
    dd 0
gdt_codedesc:
    dw 0xFFFF               ;Sets limit
    dw 0x0000               ;Sets base - low
    db 0x00                 ;Sets base - medium
    db 10011010b            ;Pr,Privl,S,Ex,DC,RW,Ac
    db 11001111b            ;Gr,Sz,0,0,Limit
    db 0x00                 ;Sets base - high
gdt_datadesc:
    dw 0xFFFF               
    dw 0x0000              
    db 0x00
    db 10010010b            
    db 11001111b           
    db 0x00

gdt_end:

gdt_descriptor:
    gdt_size:
        dw gdt_end - gdt_nulldesc - 1
        dd gdt_nulldesc

codeseg equ gdt_codedesc - gdt_nulldesc
dataseg equ gdt_datadesc - gdt_nulldesc