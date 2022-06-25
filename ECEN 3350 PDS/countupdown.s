.section .reset, "ax"
.global _start
_start:
	
	movia	sp, 0x100
	movia	gp, 0xff200000
	movi	r9, 0			# Count
	movi	r3, 0			# Direction
	jmpi	main
	
#======== Exception Section =========
.section .exceptions, "ax"
ExceptionHandler:
	rdctl	et, ipending
	bne		et, r0, ExternalException
	eret								# Return if Internal Exception
	
ExternalException:
	subi	ea, ea, 4		# Rewind pc
	
	#ISR Prologue OR just use et
	
	andi	et, et, 0b10	# Look for pushbutton IRQ
	beq		et, r0, ISR_Done
	
	#Reset buttons immediately
	ldwio	et, 0x5C(gp)
	stwio	et, 0x5C(gp)
	
	#Check which button was pressed
	subi	et, et, 1
	beq		et, r0, PushButton0 # Button 0 pressed
	#Button 1 pressed
	movi	r3, 0
	br ISR_Done
PushButton0:
	movi	r3, 1
ISR_Done:
	# ISR epilogue
	eret
	
main:
	# Enable PushButtons
	movi	r2, 0b11
	stwio	r2, 0x58(gp)
	# Enable IRQ#1
	movi	r2, 0b10
	wrctl	ienable, r2
	# Enable PIE bit
	movi	r2, 0b01
	wrctl	status, r2
	
loop:
	ldbu	r8, LED(r9)
	slli	r2, r2, 8
	add		r2, r2, r8
	stwio	r2, 0x20(gp)
	bne		r3, r0, right
	addi	r9, r9, 1
	br		continue
right:
	subi	r9, r9, 1
	br 		continue
continue:
	andi	r9, r9, 0xF #Keep r9 < 16
	
	subi	sp, sp, 8
	stw		ra, 4(sp)
	stw		r2, (sp)
	call	delay1ms
	ldw		r2, (sp)
	ldw		ra, 4(sp)
	addi	sp, sp, 8
	
	br		loop
	
	
	
delay1ms:
	movia	r2, 1000000
delay:
	subi	r2, r2, 1
	bgt		r2, r0, delay
	ret
.data
LED:
	.byte    0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07  # 0 .. 7
    .byte    0x7F, 0x67, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71  # 8 .. F
.align 4
.end