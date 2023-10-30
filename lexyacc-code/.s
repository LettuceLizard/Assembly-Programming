    .data
format: .asciz "%d\n"
.text
fact:
    movq    8(%rsp), %rcx     
    movq    $1, %rax
    cmpq    $0, %rcx
    jle     exit
loop:
    mulq    %rcx
    dec     %rcx
    cmpq    $0, %rcx
    jg      loop
exit:
    ret
.global main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$80, %rsp
	addq	$80, %rsp
	popq	%rbp
	call	exit
