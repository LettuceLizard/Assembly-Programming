    .data
format: .asciz "%d\n"
.text
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
	leaq	format(%rip), %rdi
	movq	%rax, %rsi
	xorq	%rax, %rax
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
	call	exit
