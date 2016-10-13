	.cpu arm7tdmi
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.arm
	.syntax divided
	.file	"myLib.c"
	.text
	.align	2
	.global	setPixel
	.type	setPixel, %function
setPixel:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L2
	rsb	r0, r0, r0, lsl #4
	add	r1, r1, r0, lsl #4
	ldr	r3, [r3]
	mov	r1, r1, asl #1
	strh	r2, [r3, r1]	@ movhi
	bx	lr
.L3:
	.align	2
.L2:
	.word	.LANCHOR0
	.size	setPixel, .-setPixel
	.align	2
	.global	DMANow
	.type	DMANow, %function
DMANow:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	add	r0, r0, r0, lsl #1
	mov	r0, r0, asl #2
	add	r0, r0, #67108864
	orr	r3, r3, #-2147483648
	str	r1, [r0, #176]
	str	r2, [r0, #180]
	str	r3, [r0, #184]
	bx	lr
	.size	DMANow, .-DMANow
	.align	2
	.global	drawRect
	.type	drawRect, %function
drawRect:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	sub	sp, sp, #12
	ldrh	ip, [sp, #16]
	cmp	r2, #0
	strh	ip, [sp, #6]	@ movhi
	ble	.L5
	mov	lr, #67108864
	ldr	ip, .L12
	add	r2, r0, r2
	ldr	ip, [ip]
	rsb	r0, r0, r0, lsl #4
	rsb	r2, r2, r2, lsl #4
	add	r2, r1, r2, lsl #4
	add	r1, r1, r0, lsl #4
	orr	r3, r3, #-2130706432
	add	r2, ip, r2, lsl #1
	add	r1, ip, r1, lsl #1
	add	r0, sp, #6
.L7:
	str	r0, [lr, #212]
	str	r1, [lr, #216]
	add	r1, r1, #480
	cmp	r1, r2
	str	r3, [lr, #220]
	bne	.L7
.L5:
	add	sp, sp, #12
	@ sp needed
	ldr	lr, [sp], #4
	bx	lr
.L13:
	.align	2
.L12:
	.word	.LANCHOR0
	.size	drawRect, .-drawRect
	.align	2
	.global	fillScreen
	.type	fillScreen, %function
fillScreen:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, #67108864
	sub	sp, sp, #8
	ldr	r1, .L16
	add	r2, sp, #8
	strh	r0, [r2, #-2]!	@ movhi
	ldr	r0, [r1]
	ldr	r1, .L16+4
	str	r2, [r3, #212]
	str	r0, [r3, #216]
	str	r1, [r3, #220]
	add	sp, sp, #8
	@ sp needed
	bx	lr
.L17:
	.align	2
.L16:
	.word	.LANCHOR0
	.word	-2130668032
	.size	fillScreen, .-fillScreen
	.align	2
	.global	waitForVblank
	.type	waitForVblank, %function
waitForVblank:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r2, #67108864
.L19:
	ldrh	r3, [r2, #6]
	cmp	r3, #160
	bhi	.L19
	mov	r2, #67108864
.L21:
	ldrh	r3, [r2, #6]
	cmp	r3, #159
	bls	.L21
	bx	lr
	.size	waitForVblank, .-waitForVblank
	.global	videoBuffer
	.data
	.align	2
	.set	.LANCHOR0,. + 0
	.type	videoBuffer, %object
	.size	videoBuffer, 4
videoBuffer:
	.word	100663296
	.ident	"GCC: (devkitARM release 45) 5.3.0"
