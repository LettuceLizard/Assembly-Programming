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
	pushq	$5
	call	fact
	leaq	format(%rip), %rdi
	movq	%rax, %rsi
	xorq	%rax, %rax
	call	printf
	pushq	$0
	call	fact
	pushq	$1
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	leaq	format(%rip), %rdi
	movq	%rax, %rsi
	xorq	%rax, %rax
	call	printf
	pushq	$1
	call	fact
	pushq	$1
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	leaq	format(%rip), %rdi
	movq	%rax, %rsi
	xorq	%rax, %rax
	call	printf
	pushq	$2
	call	fact
	pushq	$2
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	leaq	format(%rip), %rdi
	movq	%rax, %rsi
	xorq	%rax, %rax
	call	printf
	pushq	$3
	call	fact
	pushq	$6
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	leaq	format(%rip), %rdi
	movq	%rax, %rsi
	xorq	%rax, %rax
	call	printf
	pushq	$4
	call	fact
	pushq	$24
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	leaq	format(%rip), %rdi
	movq	%rax, %rsi
	xorq	%rax, %rax
	call	printf
	pushq	$5
	call	fact
	pushq	$120
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	leaq	format(%rip), %rdi
	movq	%rax, %rsi
	xorq	%rax, %rax
	call	printf
	pushq	$6
	call	fact
	pushq	$720
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	leaq	format(%rip), %rdi
	movq	%rax, %rsi
	xorq	%rax, %rax
	call	printf
	pushq	$7
	call	fact
	pushq	$5040
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	leaq	format(%rip), %rdi
	movq	%rax, %rsi
	xorq	%rax, %rax
	call	printf
	pushq	$8
	call	fact
	pushq	$40320
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	leaq	format(%rip), %rdi
	movq	%rax, %rsi
	xorq	%rax, %rax
	call	printf
	pushq	$9
	call	fact
	pushq	$362880
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	leaq	format(%rip), %rdi
	movq	%rax, %rsi
	xorq	%rax, %rax
	call	printf
	pushq	$10
	call	fact
	pushq	$3628800
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	leaq	format(%rip), %rdi
	movq	%rax, %rsi
	xorq	%rax, %rax
	call	printf
	pushq	$11
	call	fact
	pushq	$39916800
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	leaq	format(%rip), %rdi
	movq	%rax, %rsi
	xorq	%rax, %rax
	call	printf
	addq	$80, %rsp
	popq	%rbp
	call	exit
