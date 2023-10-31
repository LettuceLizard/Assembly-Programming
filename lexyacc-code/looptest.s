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
    cmpq    $0, %rcx
    decq    %rcx
    jle     exit
    jmp     loop
exit:
    ret
.global main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$80, %rsp
	pushq	$100
	popq	-72(%rbp)
L000:
	pushq	-72(%rbp)
	pushq	$0
	popq	%rdx
	popq	%rax
	cmpq	%rdx, %rax
	jl	L001
	pushq	-72(%rbp)
	lea	format(%rip), %rdi
	movq	%rax, %rsi
	movq	$0, %rax
	call	printf
	pushq	-72(%rbp)
	pushq	$1
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	popq	-72(%rbp)
	jmp	L000
L001:
	addq	$80, %rsp
	popq	%rbp
	movq	$0, %rdi
	movq	$60, %rax
	syscall
