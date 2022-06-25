.global _start
.section .reset, "ax"
_start:
	
	movia	sp, 0x1000
	movia	gp, 0xFF200000
	movi	r8, 1
	
	br		main
	
#======== Exception Section ========    
.section .exceptions, "ax"
ExceptionHandler:          # Address 0x00000020
    # "Internal Exception" (not an IRQ) => return
    rdctl    et, ipending  # Reg et (reserved for ISR) need not be preserved
    bne      et, r0, ExternalException
    eret                   # No IRQ? => return
ExternalException:
    subi    ea, ea, 4      # Rewind pc to restart interrupted instruction
	subi	sp, sp, 4
	stw		r2, (sp)
	
	# Assure IRQ# is IRQ#1 (Pushbutton PPI), none other.
    andi    r2, et, 0b10    # IRQ#1 => Pushbutton PPI
    beq     r2, r0, ISR_NotIRQ1
	
	ldwio   et, 0x5C(gp)    # Read  Pushbutton Edgecapture register
    stwio   et, 0x5C(gp)    # Reset Pushbutton Edgecapture register
	
	subi	et, et, 1
	beq		et, r0, Button0
	subi	et, et, 1
	beq		et, r0, Button1
	br		ISRdone
	
Button0:
	ldwio	et, (gp)
	
	movi	r2, 0x02
	blt		et, r2, ISRdone
	
	movia	r2, 2500000
	mul		r2, r2, et
	stwio   r2, 0x2008(gp)  # Lower 16-bits of divisor
    srli    r2, r2, 16
    stwio   r2, 0x200c(gp)  # Upper 16-bits of divisor
	
	movui   r2, 0b0111
	stwio   r2, 0x2004(gp)  # Write Control Register
	
	movi	r2, 2
	div		et, et, r2
	stwio	et, (gp)
	br 		ISRdone
	
Button1:
	ldwio	et, (gp)
	
	movi	r2, 0x20
	bgt		et, r2, ISRdone
	
	movia	r2, 2500000
	mul		r2, r2, et
	stwio   r2, 0x2008(gp)  # Lower 16-bits of divisor
    srli    r2, r2, 16
    stwio   r2, 0x200c(gp)  # Upper 16-bits of divisor
	
	movui   r2, 0b0111
	stwio   r2, 0x2004(gp)  # Write Control Register
	
	muli	et, et, 2
	stwio	et, (gp)
	br ISRdone

ISR_NotIRQ1:
	andi    r2, et, 0b01    # IRQ#0 => First Interval Timer
    beq     r2, r0, ISRdone
    
    # Reset Timer's IRQ1 assertion
    stwio   r0, 0x2000(gp)  # Reset the "TO" bit
	
	ldw		r2, Count(r0)
	ldbu	et, LED7(r2)
	ldwio	r2, 0x20(gp)
	slli	r2, r2, 8
	add		r2, r2, et
	stwio	r2, 0x20(gp)
	
	ldw     r2, Count(r0)	# \
    addi    r2, r2, 1       #  Count++;
    stw     r2, Count(r0)	# /
	
	ldw		r2, Count(r0)
	movi	et, 16
	bge		r2, et, resetCount
	
	br ISRdone
	
resetCount:
	stw		r0, Count(r0)


ISRdone:
	ldw		r2, (sp)
	addi	sp, sp, 4
	eret

.text
main:

	movi	r2, 8
	stwio	r2, (gp)
	
	# Configure Pushbutton Keyswitches for IRQ#1
    movi    r2, 0b11        # Enable both Pushbutton Keyswitches
    stwio   r2, 0x58(gp)    # Pushbutton PPI Interrupt Mask register
	
	# Configure First Timer to generate 100Hz IRQ#0
    movia   r2, 20000000     	# 
	#ldw		r2, Speed(r0)
    stwio   r2, 0x2008(gp)  # Lower 16-bits of divisor
    srli    r2, r2, 16
    stwio   r2, 0x200c(gp)  # Upper 16-bits of divisor
#   movi    r2, 0b111
#   stwio   r2, 0x2004(gp)  # START | CONT | ITO
    # 7-Segment LED initial value
#    ldbu    r2, LED7(r0)    # Load bits for "0"
    stwio   r0, 0x20(gp)    # Set display to "0"
#    stwio   r0, 0x30(gp)

    movi    r2, 0b11        # Enable IRQ#0 & IRQ#1
    wrctl   ienable, r2
    
    movi    r2, 0b01        # Set status.PIE bit
    wrctl   status, r2      # Enabling Processor Interrupts
	
	movui   r3, 0b0111
	stwio   r3, 0x2004(gp)  # Write Control Register
	
countr8:
	addi	r8, r8, 1
	br		countr8
	
.data
LED7:
    .byte    0x76, 0x79, 0x38, 0x38, 0x3F, 0x0, 0x7F, 0x3E  # 0 .. 7
    .byte    0x71, 0x71, 0x6D, 0x0, 0x0, 0x0, 0x0, 0x0  # 8 .. F
	
Count:
    .word   0
Speed:
	.word	0
.end
	