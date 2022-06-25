.text
.global _start
_start:
	movia	sp, 0x4000000	# Top of RAM
	
	movia	r18, List
	movi	r16, 0			# i
	movi	r17, 20			# for (i=0; i < 20; i++)

forLoop:
	bgt		r16, r17, stop
	
	mov		r4, r16
	mov		r12, r0			# How many times it had to call itself
	call	fib
	stw		r2, (r18)
	addi	r18, r18, 4
	addi	r16, r16, 1
	br		forLoop
	
stop:
	br		stop
	
# 0, 1, 1, 2, 3, 5
fib:	# input is in r4
	# Prologue
	subi	sp, sp, 12
	stw		ra, 8(sp)
	stw		r4, 4(sp)
	addi	r12, r12, 1			# How many times it got called
	
	mov		r2, r4				# Temporary storage of r4
	movi	r3, 1				# cmplei r3, r2, 1
	ble		r2, r3, fib_Done 	# bne	 r3, r0, fib_Done
	
	# Compute n-1 and n-2
	subi	r4, r4, 1			# n-1
	call	fib					# t = fib(n-1)
	stw		r2, (sp)			# t
	
	ldw		r4, 4(sp)			# Restore 'n'
	subi	r4, r4, 2			# n-2
	call	fib					# fib(n-2)
	
	ldw		r3, (sp)			# t
	add		r2, r2, r3			# fib(n-1) + fib(n-2)
	
fib_Done:
	# Epilog
	ldw		ra, 8(sp)
	addi	sp, sp, 12
	ret

.data
List: .space 400
.end