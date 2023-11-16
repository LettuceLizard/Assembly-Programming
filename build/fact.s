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
	pushq	$0
	call	fact
	addq	$8,%rsp
	pushq	%rax
	pushq	$1
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	popq	%rsi
	lea	format(%rip), %rdi
	movq	$0, %rax
	call	printf
	pushq	$1
	call	fact
	addq	$8,%rsp
	pushq	%rax
	pushq	$1
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	popq	%rsi
	lea	format(%rip), %rdi
	movq	$0, %rax
	call	printf
	pushq	$2
	call	fact
	addq	$8,%rsp
	pushq	%rax
	pushq	$2
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	popq	%rsi
	lea	format(%rip), %rdi
	movq	$0, %rax
	call	printf
	pushq	$3
	call	fact
	addq	$8,%rsp
	pushq	%rax
	pushq	$6
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	popq	%rsi
	lea	format(%rip), %rdi
	movq	$0, %rax
	call	printf
	pushq	$4
	call	fact
	addq	$8,%rsp
	pushq	%rax
	pushq	$24
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	popq	%rsi
	lea	format(%rip), %rdi
	movq	$0, %rax
	call	printf
	pushq	$5
	call	fact
	addq	$8,%rsp
	pushq	%rax
	pushq	$120
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	popq	%rsi
	lea	format(%rip), %rdi
	movq	$0, %rax
	call	printf
	pushq	$6
	call	fact
	addq	$8,%rsp
	pushq	%rax
	pushq	$720
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	popq	%rsi
	lea	format(%rip), %rdi
	movq	$0, %rax
	call	printf
	pushq	$7
	call	fact
	addq	$8,%rsp
	pushq	%rax
	pushq	$5040
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	popq	%rsi
	lea	format(%rip), %rdi
	movq	$0, %rax
	call	printf
	pushq	$8
	call	fact
	addq	$8,%rsp
	pushq	%rax
	pushq	$40320
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	popq	%rsi
	lea	format(%rip), %rdi
	movq	$0, %rax
	call	printf
	pushq	$9
	call	fact
	addq	$8,%rsp
	pushq	%rax
	pushq	$362880
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	popq	%rsi
	lea	format(%rip), %rdi
	movq	$0, %rax
	call	printf
	pushq	$10
	call	fact
	addq	$8,%rsp
	pushq	%rax
	pushq	$3628800
	popq	%rbx
	popq	%rax
	subq	%rbx, %rax
	pushq	%rax
	popq	%rsi
	lea	format(%rip), %rdi
	movq	$0, %rax
	call	printf
	pushq	$11
	call	fact
	addq	$8,%rsp
	pushq	%rax
	pushq	$39916800
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
