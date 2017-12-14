	.file	"pmm-secuencial-modificado_2.c"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"Tiempo(seg.):%11.9f\t / Tama\303\261o Vectores:%u\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB2:
	.section	.text.startup,"ax",@progbits
.LHOTB2:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB38:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	xorl	%edi, %edi
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	leaq	32(%rsp), %rsi
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	call	clock_gettime
	movl	N(%rip), %r15d
	testl	%r15d, %r15d
	je	.L3
	leal	-1(%r15), %esi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	addq	$1, %rsi
.L5:
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L4:
	movl	%ecx, B(%rdx,%rax,4)
	movl	%eax, C(%rdx,%rax,4)
	addq	$1, %rax
	cmpq	%rax, %rsi
	jne	.L4
	addl	$1, %ecx
	addq	$4000, %rdx
	cmpl	%r15d, %ecx
	jne	.L5
	xorl	%r13d, %r13d
	movl	$12000, %r12d
	movl	$8000, %ebp
	movl	$4000, %ebx
	movq	$0, (%rsp)
	movl	$0, 28(%rsp)
.L9:
	movq	(%rsp), %rax
	movq	$C, 8(%rsp)
	xorl	%r14d, %r14d
	addq	$B, %rax
	movq	%rax, 16(%rsp)
	.p2align 4,,10
	.p2align 3
.L10:
	movq	(%rsp), %rax
	movl	A+4(%rbx,%r14,4), %r10d
	xorl	%edi, %edi
	movl	A+8(%rbp,%r14,4), %r9d
	movl	A+12(%r12,%r14,4), %r8d
	movq	16(%rsp), %rdx
	movl	A(%rax,%r14,4), %r11d
	movq	8(%rsp), %rax
	.p2align 4,,10
	.p2align 3
.L7:
	movl	(%rdx), %ecx
	addl	$4, %edi
	addq	$16000, %rax
	imull	-16000(%rax), %ecx
	addl	%ecx, %r11d
	leaq	0(%r13,%rdx), %rcx
	addq	$16, %rdx
	movl	4(%rcx,%rbx), %esi
	imull	-11996(%rax), %esi
	addl	%esi, %r10d
	movl	8(%rcx,%rbp), %esi
	movl	12(%rcx,%r12), %ecx
	imull	-7992(%rax), %esi
	imull	-3988(%rax), %ecx
	addl	%esi, %r9d
	addl	%ecx, %r8d
	cmpl	%r15d, %edi
	jb	.L7
	movq	(%rsp), %rax
	addq	$16, 8(%rsp)
	movl	%r11d, A(%rax,%r14,4)
	movl	%r10d, A+4(%rbx,%r14,4)
	movl	%r9d, A+8(%rbp,%r14,4)
	movl	%r8d, A+12(%r12,%r14,4)
	addq	$4, %r14
	cmpl	%r14d, %r15d
	ja	.L10
	addl	$4, 28(%rsp)
	addq	$16000, (%rsp)
	addq	$16000, %rbx
	movl	28(%rsp), %eax
	addq	$16000, %rbp
	addq	$16000, %r12
	subq	$16000, %r13
	cmpl	%eax, %r15d
	ja	.L9
.L3:
	leaq	48(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	movq	56(%rsp), %rax
	subq	40(%rsp), %rax
	movl	$.LC1, %esi
	pxor	%xmm0, %xmm0
	movl	N(%rip), %edx
	movl	$1, %edi
	cvtsi2sdq	%rax, %xmm0
	movq	48(%rsp), %rax
	subq	32(%rsp), %rax
	movapd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	divsd	.LC0(%rip), %xmm1
	cvtsi2sdq	%rax, %xmm0
	movl	$1, %eax
	addsd	%xmm1, %xmm0
	call	__printf_chk
	xorl	%eax, %eax
	movq	72(%rsp), %rbx
	xorq	%fs:40, %rbx
	jne	.L18
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L18:
	.cfi_restore_state
	call	__stack_chk_fail
	.cfi_endproc
.LFE38:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE2:
	.section	.text.startup
.LHOTE2:
	.comm	C,4000000,32
	.comm	B,4000000,32
	.comm	A,4000000,32
	.globl	N
	.data
	.align 4
	.type	N, @object
	.size	N, 4
N:
	.long	1000
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	1104006501
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
