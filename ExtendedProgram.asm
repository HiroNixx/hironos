[org 0x7e00]

jmp EnterProtectedMode

%include "print.asm"
%include "gdt.asm"



EnterProtectedMode:
    call EnableA20
    cli                     ; disable interrupts
    lgdt [gdt_descriptor]   ; load gdt descriptor
    mov eax, cr0
    or eax, 1               ; set bit to show protected 32 bit mode
    mov cr0, eax
    jmp codeseg:StartProtectedMode

EnableA20:                  ; some compatability layer shit
    in al, 0x92
    or al, 2
    out 0x92, al
    ret

[bits 32]

%include "cpuid.asm"
%include "SimplePaging.asm"

StartProtectedMode:
    mov ax, dataseg
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov [0xb8000], byte 'H'
    mov [0xb8002], byte 'e'
    mov [0xb8004], byte 'l'

    call DetectCPUID
    call DetectLongMode
   
    call SetUpIdentityPaging
    call EditGDT
    jmp codeseg:Start64Bit

[bits 64]

Start64Bit:
    mov edi, 0xb8000
    mov rax, 0x1f201f201f201f20
    mov ecx, 500
    rep stosq
    jmp $

times 2048-($-$$) db 0