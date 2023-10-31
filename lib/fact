fact:
    movq    8(%rsp), %rcx
    movq    $1, %rax
    cmpq    $0, %rcx
    jle     exit
loop:
    mulq    %rcx
    cmpq    $0, %rcx
    decq    %rcx
    jle     exit
    jmp     loop
exit:
    ret
