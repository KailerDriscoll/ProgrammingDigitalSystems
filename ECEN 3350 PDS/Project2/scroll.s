.include    "address_map_nios2.s" 

.text        

.global     _start 
_start:                         
	
	movia	r2, 0xff200020  # Base address for LEDs
	movia	sp, 0x1000		# Inialize stack pointer

main:
	movi	r5, 3
	flash1:
	movia	r4, 0x49494949	# Horizotal LEDs
	stwio	r4, (r2)
	subi	sp, sp, 4		# \
	stw		r2, (sp)		#  \
	call	delay1ms		#   Delay
	ldw		r2, (sp)		#  /
	addi	sp, sp, 4		# /
	
	
	movia	r4, 0x36363636	# Vertical LEDs
	stwio	r4, (r2)
	subi	sp, sp, 4		# \
	stw		r2, (sp)		#  \
	call	delay1ms		#   Delay
	ldw		r2, (sp)		#  /
	addi	sp, sp, 4		# /
	
	subi	r5, r5, 1
	bne		r5, r0, flash1
	
	
	movi	r5, 3
	flash:
	movia	r4, 0x7F7F7F7F	# All LEDs
	stwio	r4, (r2)
	subi	sp, sp, 4		# \
	stw		r2, (sp)		#  \
	call	delay1ms		#   Delay
	ldw		r2, (sp)		#  /
	addi	sp, sp, 4		# /
	
	movia	r4, 0x0			# No LEDs
	stwio	r4, (r2)
	subi	sp, sp, 4		# \
	stw		r2, (sp)		#  \
	call	delay1ms		#   Delay
	ldw		r2, (sp)		#  /
	addi	sp, sp, 4		# /
	
	subi	r5, r5, 1
	bne		r5, r0, flash
	
	
	
	# Hello Buffs
	movi	r15, 0x76		# H
	movi	r16, 0x79		# E
	movi	r17, 0x38		# L
	movi	r18, 0x3F		# O
	movi	r19, 0x7F		# B
	movi	r20, 0x3E		# U
	movi	r21, 0x71		# F
	movi	r22, 0x6D		# S
	movia	r7, 0xFFFFFFFF	# mask
	
	mov		r4, r15			# H
	stwio	r4, (r2)
	subi	sp, sp, 4		# \
	stw		r2, (sp)		#  \
	call	delay1ms		#   Delay
	ldw		r2, (sp)		#  /
	addi	sp, sp, 4		# /
	slli	r4, r4, 8
	add		r4, r4, r16		# HE
	stwio	r4, (r2)
	subi	sp, sp, 4		# \
	stw		r2, (sp)		#  \
	call	delay1ms		#   Delay
	ldw		r2, (sp)		#  /
	addi	sp, sp, 4		# /
	slli	r4, r4, 8
	add		r4, r4, r17		# HEL
	stwio	r4, (r2)
	subi	sp, sp, 4		# \
	stw		r2, (sp)		#  \
	call	delay1ms		#   Delay
	ldw		r2, (sp)		#  /
	addi	sp, sp, 4		# /
	slli	r4, r4, 8
	add		r4, r4, r17		# HELL
	stwio	r4, (r2)
	subi	sp, sp, 4		# \
	stw		r2, (sp)		#  \
	call	delay1ms		#   Delay
	ldw		r2, (sp)		#  /
	addi	sp, sp, 4		# /
	slli	r4, r4, 8
	add		r4, r4, r18		# HELLO
	and		r4, r4, r7
	stwio	r4, (r2)
	subi	sp, sp, 4		# \
	stw		r2, (sp)		#  \
	call	delay1ms		#   Delay
	ldw		r2, (sp)		#  /
	addi	sp, sp, 4		# /
	slli	r4, r4, 8		# HELLO_
	and		r4, r4, r7
	stwio	r4, (r2)
	subi	sp, sp, 4		# \
	stw		r2, (sp)		#  \
	call	delay1ms		#   Delay
	ldw		r2, (sp)		#  /
	addi	sp, sp, 4		# /
	slli	r4, r4, 8
	add		r4, r4, r19		# HELLO B
	and		r4, r4, r7
	stwio	r4, (r2)
	subi	sp, sp, 4		# \
	stw		r2, (sp)		#  \
	call	delay1ms		#   Delay
	ldw		r2, (sp)		#  /
	addi	sp, sp, 4		# /
	slli	r4, r4, 8
	add		r4, r4, r20		# HELLO BU
	and		r4, r4, r7
	stwio	r4, (r2)
	subi	sp, sp, 4		# \
	stw		r2, (sp)		#  \
	call	delay1ms		#   Delay
	ldw		r2, (sp)		#  /
	addi	sp, sp, 4		# /
	slli	r4, r4, 8
	add		r4, r4, r21		# HELLO BUF
	and		r4, r4, r7
	stwio	r4, (r2)
	subi	sp, sp, 4		# \
	stw		r2, (sp)		#  \
	call	delay1ms		#   Delay
	ldw		r2, (sp)		#  /
	addi	sp, sp, 4		# /
	slli	r4, r4, 8
	add		r4, r4, r21		# HELLO BUFF
	and		r4, r4, r7
	stwio	r4, (r2)
	subi	sp, sp, 4		# \
	stw		r2, (sp)		#  \
	call	delay1ms		#   Delay
	ldw		r2, (sp)		#  /
	addi	sp, sp, 4		# /
	slli	r4, r4, 8
	add		r4, r4, r22		# HELLO BUFFS
	and		r4, r4, r7
	stwio	r4, (r2)
	subi	sp, sp, 4		# \
	stw		r2, (sp)		#  \
	call	delay1ms		#   Delay
	ldw		r2, (sp)		#  /
	addi	sp, sp, 4		# /
	
	# ---___
	movi	r23, 0x40		# -
	movi	r5, 3
	loop3:
	slli	r4, r4, 8
	add		r4, r4, r23			# -
	and		r4, r4, r7
	stwio	r4, (r2)
	subi	sp, sp, 4		# \
	stw		r2, (sp)		#  \
	call	delay1ms		#   Delay
	ldw		r2, (sp)		#  /
	addi	sp, sp, 4		# /
	subi	r5, r5, 1
	bne		r5, r0, loop3
	
	movi	r5, 4
	loop4:
	slli	r4, r4, 8
	stwio	r4, (r2)
	subi	sp, sp, 4		# \
	stw		r2, (sp)		#  \
	call	delay1ms		#   Delay
	ldw		r2, (sp)		#  /
	addi	sp, sp, 4		# /
	subi	r5, r5, 1
	bne		r5, r0, loop4
	
	
	br	main				# Infinite Loop
	
delay1ms:
	movia	r2, 10000000			#1M in CPUlator, 10M on DE10
	delay:
		subi	r2, r2, 1
		bne		r2, r0, delay
	ret
	
	
.end         


