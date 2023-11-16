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
	pushq	$20
	popq	-8(%rbp)
	pushq	-8(%rbp)
	pushq	$5
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	popq	-8(%rbp)
	pushq	-8(%rbp)
	pushq	$3
	popq	%rbx
	popq	%rax
	imulq	%rbx
	pushq	%rax
	popq	-8(%rbp)
	pushq	-8(%rbp)
	pushq	$5
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
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
