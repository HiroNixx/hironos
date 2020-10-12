
; Pushes flags on to register and pop back and see whether it changed
DetectCPUID:
    pushfd
    pop eax

    mov ecx, eax

    xor eax, 1 << 21

    push eax
    popfd

    pushfd
    pop eax

    push ecx
    popfd

    xor eax,ecx
    jz NoCPUID
    ret


DetectLongMode:
    mov eax, 0x80000001
    cpuid
    test edx, 1 << 29
    jz NoLongMode
    ret

NoLongMode:
    hlt ; No long mode support

NoCPUID:
    hlt ; No CPUID support 