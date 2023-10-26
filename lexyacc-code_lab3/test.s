    .data
format: .asciz "%d\n"
.text
.global main
main:
	pushq	$732
	popq	%rax
	pushq	$2684
	popq	%rbx
L000:
	pushq	%rax
	pushq	%rbx
	pushq	%rax
	pushq	%rbx
	popq	%rbx
	popq	%rax
	cmpq	%rbx, %rax
	je	L001
	jz	L001
	pushq	%rax
	pushq	%rbx
	popq	%rbx
	popq	%rax
	cmpq	%rbx, %rax
	jl	L002
	jz	L002
	pushq	%rax
	pushq	%rbx
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	popq	%rax
	jmp	L003
L002:
	pushq	%rbx
	pushq	%rax
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	popq	%rbx
L003:
	jmp	L000
L001:
	pushq	%rax
	leaq	format(%rip), %rdi
	movq	%rax, %rsi
	xorq	%rax, %rax
	call	printf
	call	exit
