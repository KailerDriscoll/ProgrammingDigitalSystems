.text

.global sum_two
# 1.1) int sum_two(int, int) function
sum_two:
	add		r2, r4, r5
	ret
	
.global op_three
# 1.2) int op_three(int, int, int) function
op_three:
	subi	sp, sp,	8
	stw		ra, 4(sp)
	stw		r6,  (sp)
	call	op_two
	ldw		r6,  (sp)
	ldw		ra, 4(sp)
	addi	sp, sp, 8
	
	mov		r4, r2
	mov		r5, r6
	
	subi	sp, sp, 4
	stw		ra, 4(sp)
	call	op_two
	ldw		ra,  (sp)
	addi	sp, sp, 4
	ret

.global fibonacci
# 1.3) int fibonacci(int) recursive function
# 0, 1, 1, 2, 3, 5
fibonacci:	# input is in r4
	# Prologue
	subi	sp, sp, 12
	stw		ra, 8(sp)
	stw		r4, 4(sp)
	
	mov		r2, r4				# Temporary storage of r4
	movi	r3, 1				# cmplei r3, r2, 1
	ble		r2, r3, fib_Done 	# bne	 r3, r0, fib_Done
	
	# Compute n-1 and n-2
	subi	r4, r4, 1			# n-1
	call	fibonacci			# t = fib(n-1)
	stw		r2, (sp)			# t
	
	ldw		r4, 4(sp)			# Restore 'n'
	subi	r4, r4, 2			# n-2
	call	fibonacci			# fib(n-2)
	
	ldw		r3, (sp)			# t
	add		r2, r2, r3			# fib(n-1) + fib(n-2)
	
fib_Done:
	# Epilog
	ldw		ra, 8(sp)
	addi	sp, sp, 12
	ret
	