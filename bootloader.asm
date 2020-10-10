
[org 0x7c00]                ;Sets origin point

mov [BOOT_DISK], dl

mov bp, 0x7c00              
mov sp, bp


call ReadDisk

jmp PROGRAM_SPACE           ;Jumps to Program Space

%include "print.asm"
%include "DiskRead.asm"

times 510-($-$$) db 0

dw 0xaa55                   ;Magic Number