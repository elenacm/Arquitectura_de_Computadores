	.file	"pmm-secuencial.c"
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
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	xorl	%edi, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$48, %rsp
	.cfi_def_cfa_offset 80
	movq	%rsp, %rsi
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	call	clock_gettime
	movl	N(%rip), %r8d
	testl	%r8d, %r8d
	je	.L3
	leal	-1(%r8), %esi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	movq	%rsi, %rdi
	addq	$1, %rsi
.L5:
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L4:
	movl	%ecx, B(%rdx,%rax,4)
	movl	%eax, C(%rdx,%rax,4)
	addq	$1, %rax
	cmpq	%rsi, %rax
	jne	.L4
	addl	$1, %ecx
	addq	$4000, %rdx
	cmpl	%r8d, %ecx
	jne	.L5
	movl	%edi, %eax
	movl	$B, %r10d
	leaq	1(%rax), %rdx
	imulq	$4004, %rdx, %rcx
	leaq	A(,%rdx,4), %r9
	imulq	$4000, %rdx, %rdx
	leaq	A(%rcx), %r12
	movq	%rax, %rcx
	imulq	$-4000, %rax, %rax
	negq	%rcx
	leaq	C(%rdx), %rbp
	leaq	-4(,%rcx,4), %rbx
	leaq	-4000(%rax), %r11
.L9:
	leaq	(%rbx,%r9), %r8
	movq	%rbp, %rdi
	.p2align 4,,10
	.p2align 3
.L10:
	movl	(%r8), %esi
	leaq	(%r11,%rdi), %rax
	movq	%r10, %rcx
	.p2align 4,,10
	.p2align 3
.L7:
	movl	(%rcx), %edx
	addq	$4000, %rax
	addq	$4, %rcx
	imull	-4000(%rax), %edx
	addl	%edx, %esi
	cmpq	%rax, %rdi
	jne	.L7
	movl	%esi, (%r8)
	addq	$4, %r8
	addq	$4, %rdi
	cmpq	%r9, %r8
	jne	.L10
	addq	$4000, %r9
	addq	$4000, %r10
	cmpq	%r12, %r9
	jne	.L9
.L3:
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	movq	24(%rsp), %rax
	subq	8(%rsp), %rax
	movl	$.LC1, %esi
	pxor	%xmm0, %xmm0
	movl	N(%rip), %edx
	movl	$1, %edi
	cvtsi2sdq	%rax, %xmm0
	movq	16(%rsp), %rax
	subq	(%rsp), %rax
	movapd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	divsd	.LC0(%rip), %xmm1
	cvtsi2sdq	%rax, %xmm0
	movl	$1, %eax
	addsd	%xmm1, %xmm0
	call	__printf_chk
	xorl	%eax, %eax
	movq	40(%rsp), %rbx
	xorq	%fs:40, %rbx
	jne	.L20
	addq	$48, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L20:
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
