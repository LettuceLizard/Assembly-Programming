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
	pushq	$1000000
	popq	-112(%rbp)
	pushq	$100000000
	popq	-152(%rbp)
	pushq	$0
	popq	-8(%rbp)
L000:
	pushq	-112(%rbp)
	pushq	$0
	popq	%rdx
	popq	%rax
	cmpq	%rdx, %rax
	jle	L001
	pushq	-8(%rbp)
	pushq	-152(%rbp)
	pushq	-112(%rbp)
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
	pushq	$1
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	popq	-112(%rbp)
	jmp	L000
L001:
	pushq	-8(%rbp)
	pushq	-152(%rbp)
	pushq	$1000
	popq	%rbx
	popq	%rax
	idivq	%rbx
	pushq	%rax
	popq	%rbx
	popq	%rax
	idivq	%rbx
	pushq	%rax
	popq	%rsi
	lea	format(%rip), %rdi
	movq	$0, %rax
	call	printf
	addq	$80, %rsp
	popq	%rbp
	movq	$0, %rdi
	movq	$60, %rax
	syscall
