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
	pushq	$1000001
	popq	-112(%rbp)
	pushq	$100000000
	popq	-152(%rbp)
	pushq	$0
	popq	-8(%rbp)
	pushq	$0
	popq	-160(%rbp)
L000:
	pushq	-112(%rbp)
	pushq	$0
	popq	%rdx
	popq	%rax
	cmpq	%rdx, %rax
	jle	L001
	pushq	-160(%rbp)
	pushq	$0
	popq	%rax
	popq	%rbx
	cmpq	%rbx, %rax
	jne	L002
	pushq	-112(%rbp)
	popq	-32(%rbp)
	pushq	$1
	popq	-160(%rbp)
	jmp	L003
L002:
	pushq	-112(%rbp)
	popq	%rax
	neg	%rax
	pushq	%rax
	popq	-32(%rbp)
	pushq	$0
	popq	-160(%rbp)
L003:
	pushq	-8(%rbp)
	pushq	-152(%rbp)
	pushq	-32(%rbp)
	popq	%rbx
	popq	%rax
	idivq	%rbx
	pushq	%rax
	popq	%rbx
	popq	%rax
	addq	%rbx, %rax
	pushq	%rax
	popq	-8(%rbp)
	pushq	-112(%rbp)
	pushq	$2
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	popq	-112(%rbp)
	jmp	L000
L001:
	pushq	-8(%rbp)
	pushq	-152(%rbp)
	pushq	$100000
	popq	%rbx
	popq	%rax
	idivq	%rbx
	pushq	%rax
	popq	%rbx
	popq	%rax
	idivq	%rbx
	pushq	%rax
	pushq	$4
	popq	%rbx
	popq	%rax
	imulq	%rbx
	pushq	%rax
	lea	format(%rip), %rdi
	movq	%rax, %rsi
	movq	$0, %rax
	call	printf
	addq	$80, %rsp
	popq	%rbp
	movq	$0, %rdi
	movq	$60, %rax
	syscall
