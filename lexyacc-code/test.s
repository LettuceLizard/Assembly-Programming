    .data
format: .asciz "%d\n"
.text
fact:
    test
    test
.global main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$80, %rsp
	pushq	$732
	popq	-8(%rbp)
	pushq	$2684
	popq	-16(%rbp)
L000:
	pushq	-8(%rbp)
	pushq	-16(%rbp)
	popq	%rax
	popq	%rbx
	cmpq	%rbx, %rax
	je	L001
	pushq	-8(%rbp)
	pushq	-16(%rbp)
	popq	%rdx
	popq	%rax
	cmpq	%rdx, %rax
	jle	L002
	pushq	-8(%rbp)
	pushq	-16(%rbp)
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	popq	-8(%rbp)
	jmp	L003
L002:
	pushq	-16(%rbp)
	pushq	-8(%rbp)
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	popq	-16(%rbp)
L003:
	jmp	L000
L001:
	pushq	-8(%rbp)
	leaq	format(%rip), %rdi
	movq	%rax, %rsi
	xorq	%rax, %rax
	call	printf
	addq	$80, %rsp
	popq	%rbp
	call	exit
