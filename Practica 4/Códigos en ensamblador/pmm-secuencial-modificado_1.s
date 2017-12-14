	.file	"pmm-secuencial-modificado_1.c"
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
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	xorl	%edi, %edi
	movq	%rsp, %rsi
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	call	clock_gettime
	movl	N(%rip), %r8d
	testl	%r8d, %r8d
	je	.L3
	leal	-1(%r8), %edi
	xorl	%ecx, %ecx
	xorl	%esi, %esi
	movq	%rdi, %rax
	addq	$1, %rdi
.L5:
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L4:
	movl	%esi, B(%rcx,%rdx,4)
	movl	%edx, C(%rcx,%rdx,4)
	movl	$0, A(%rcx,%rdx,4)
	addq	$1, %rdx
	cmpq	%rdx, %rdi
	jne	.L4
	addl	$1, %esi
	addq	$4000, %rcx
	cmpl	%esi, %r8d
	jne	.L5
	movl	%eax, %r8d
	xorl	%edx, %edx
	addq	$1, %r8
	imulq	$4000, %r8, %r10
	salq	$2, %r8
.L9:
	leaq	B(%rdx), %r9
	xorl	%esi, %esi
	.p2align 4,,10
	.p2align 3
.L10:
	movl	(%r9), %edi
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L7:
	movl	C(%rsi,%rax), %ecx
	imull	%edi, %ecx
	addl	%ecx, A(%rdx,%rax)
	addq	$4, %rax
	cmpq	%rax, %r8
	jne	.L7
	addq	$4000, %rsi
	addq	$4, %r9
	cmpq	%r10, %rsi
	jne	.L10
	addq	$4000, %rdx
	cmpq	%r10, %rdx
	jne	.L9
.L3:
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	movq	24(%rsp), %rax
	subq	8(%rsp), %rax
	movl	$1, %edi
	pxor	%xmm0, %xmm0
	movl	N(%rip), %edx
	movl	$.LC1, %esi
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
	movq	40(%rsp), %rdi
	xorq	%fs:40, %rdi
	jne	.L20
	addq	$56, %rsp
	.cfi_remember_state
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
