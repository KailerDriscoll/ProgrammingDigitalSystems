.text        

.global     _start 
_start:                         
	
	movia	r2, 0xff200020  # Base address for LEDs
	movia	sp, 0x1000		# Inialize stack pointer
	movia	r6, 0xFF200050	# Button Address
    
    movi	r15, 0x79		# E
	movi	r16, 0x49		# Horizontals
	movi	r17, 0x4F		# 3
    movia	r7, 0xFFFFFFFF	# mask
    movi	r14, 0			# State Machine
	movi	r13, 0			# Direction
    

main:
	movi	r5, 0
	bne		r14, r5, main1
	call	SM0
	mov		r9, r14
	call	delay1ms
main1:
	movi	r5, 1
	bne		r14, r5, main2
	call	SM1
	mov		r9, r14
	call	delay1ms
main2:
	movi	r5, 2
	bne		r14, r5, main3
	call	SM2
	mov		r9, r14
	call	delay1ms
main3:
	movi	r5, 3
	bne		r14, r5, main4
	call	SM3
	mov		r9, r14
	call	delay1ms
main4:
	movi	r5, 4
	bne		r14, r5, main5
	call	SM4
	mov		r9, r14
	call	delay1ms
main5:
	movi	r5, 5
	bne		r14, r5, main6
	call	SM5
	mov		r9, r14
	call	delay1ms
main6:
	movi	r5, 6
	bne		r14, r5, main7
	call	SM6
	mov		r9, r14
	call	delay1ms
main7:
	movi	r5, 7
	bne		r14, r5, main
	call	SM7
	mov		r9, r14
	call	delay1ms
	
	br		main


SM0:
	#movi	r4, 0
	stwio	r0, (r2)
	addi	r14, r14, 1
	beq		r13, r0, SM0l
	br		SM0r
SM0l:
	movi	r14, 1
	ret
SM0r:
	movi	r14, 7
	ret
	
SM1:
	beq		r13, r0, SM1l
	br		SM1r
SM1l:
	mov		r4, r16
	stwio	r4, (r2)
	addi	r14, r14, 1
	movi	r14, 2
	ret
SM1r:
	srli	r4, r4, 8
	stwio	r4, (r2)
	movi	r14, 0
	ret
	
SM2:
	beq		r13, r0, SM2l
	br		SM2r
SM2l:
	slli	r4, r4, 8
	add		r4, r4, r16
	stwio	r4, (r2)
	movi	r14, 3
	ret
SM2r:
	srli	r4, r4, 8
	stwio	r4, (r2)
	movi	r14, 1
	ret
	
SM3:
	beq		r13, r0, SM3l
	br		SM3r
SM3l:
	slli	r4, r4, 8
	add		r4, r4, r16
	stwio	r4, (r2)
	movi	r14, 4
	ret
SM3r:
	srli	r4, r4, 8
	stwio	r4, (r2)
	movi	r14, 2
	ret
	
SM4:
	beq		r13, r0, SM4l
	br		SM4r
SM4l:
	slli	r4, r4, 8
	add		r4, r4, r16
	stwio	r4, (r2)
	movi	r14, 5
	ret
SM4r:
	add		r4, r4, r16
	stwio	r4, (r2)
	movi	r14, 3
	ret
	
SM5:
	beq		r13, r0, SM5l
	br		SM5r
SM5l:
	slli	r4, r4, 8
	and		r4, r4, r7
	stwio	r4, (r2)
	movi	r14, 6
	ret
SM5r:
	slli	r10, r16, 8
	add		r4, r4, r10
	stwio	r4, (r2)
	movi	r14, 4
	ret
	
SM6:
	beq		r13, r0, SM6l
	br		SM6r
SM6l:
	slli	r4, r4, 8
	and		r4, r4, r7
	stwio	r4, (r2)
	movi	r14, 7
	ret
SM6r:
	srli	r10, r4, 8
	add		r4, r4, r10
	stwio	r4, (r2)
	movi	r14, 5
	ret
	
SM7:
	beq		r13, r0, SM7l
	br		SM7r
	
SM7l:
	slli	r4, r4, 8
	and		r4, r4, r7
	stwio	r4, (r2)
	movi	r14, 0
	ret
SM7r:
	mov		r4, r16
	slli	r4, r4, 24
	stwio	r4, (r2)
	movi	r14, 6
	ret
	
	
	
    delay1ms:
		movia	r12, 500000			#1M in CPUlator, 10M on DE10
	delay:
		ldwio	r8, (r6)
		bne		r8, r0, button
		subi	r12, r12, 1
		bne		r12, r0, delay
	ret
	
	button:
		subi	r8, r8, 1
		beq		r8, r0, right
		movi	r13, 0
		br delay
	right:
		movi	r13, 1
		subi	r14, r9, 1
		br delay
    
   .end





