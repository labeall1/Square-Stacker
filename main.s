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
	.file	"main.c"
	.text
	.align	2
	.global	start
	.type	start, %function
start:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L9
	ldr	r0, [r3]
	mvn	r0, r0
	ands	r0, r0, #8
	bxne	lr
	ldr	r3, .L9+4
	ldr	r3, [r3]
	tst	r3, #8
	bxne	lr
	stmfd	sp!, {r4, lr}
	ldr	r3, .L9+8
	mov	lr, pc
	bx	r3
	mov	r2, #1
	ldr	r3, .L9+12
	ldmfd	sp!, {r4, lr}
	str	r2, [r3]
	bx	lr
.L10:
	.align	2
.L9:
	.word	oldButtons
	.word	buttons
	.word	fillScreen
	.word	state
	.size	start, .-start
	.align	2
	.global	initialize
	.type	initialize, %function
initialize:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, #0
	mov	r0, #67108864
	ldr	ip, .L12
	ldr	r1, .L12+4
	ldr	r2, .L12+8
	strh	ip, [r0]	@ movhi
	str	r3, [r1]
	str	r3, [r2]
	bx	lr
.L13:
	.align	2
.L12:
	.word	1027
	.word	state
	.word	score
	.size	initialize, .-initialize
	.align	2
	.global	initializeGame
	.type	initializeGame, %function
initializeGame:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, lr}
	mov	r1, #10
	mov	r7, #145
	mov	lr, #120
	mov	r3, #26
	mov	r6, #70
	mov	r5, #16
	mov	r4, #1
	mov	ip, #0
	mov	r0, #122
	ldr	r2, .L16
	stmia	r2, {r7, lr}
	str	r3, [r2, #16]
	ldr	lr, .L16+4
	ldr	r3, .L16+8
	str	r1, [r2, #20]
	ldr	r2, .L16+12
	str	r6, [r3, #4]
	str	r5, [r3, #16]
	str	r4, [lr]
	str	r1, [r3]
	str	r1, [r3, #20]
	stmia	r2, {r0, ip}
	ldmfd	sp!, {r4, r5, r6, r7, lr}
	bx	lr
.L17:
	.align	2
.L16:
	.word	player
	.word	stack
	.word	square
	.word	caught_square
	.size	initializeGame, .-initializeGame
	.align	2
	.global	drawPlayer
	.type	drawPlayer, %function
drawPlayer:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, lr}
	mov	r4, r0
	mov	ip, #0
	ldr	r3, [r0, #16]
	add	r0, r3, r3, lsr #31
	ldr	lr, [r4, #8]
	ldr	r1, [r4, #12]
	mov	r0, r0, asr #1
	sub	sp, sp, #12
	rsb	r0, r0, #0
	ldr	r2, [r4, #20]
	add	r1, r0, r1
	str	ip, [sp]
	add	r0, r0, lr
	ldr	r5, .L20
	mov	lr, pc
	bx	r5
	mov	ip, #31
	ldr	r3, [r4, #16]
	add	r0, r3, r3, lsr ip
	ldr	r1, [r4, #4]
	ldr	lr, [r4]
	mov	r0, r0, asr #1
	rsb	r0, r0, #0
	ldr	r2, [r4, #20]
	add	r1, r0, r1
	str	ip, [sp]
	add	r0, r0, lr
	mov	lr, pc
	bx	r5
	add	sp, sp, #12
	@ sp needed
	ldmfd	sp!, {r4, r5, lr}
	bx	lr
.L21:
	.align	2
.L20:
	.word	drawRect
	.size	drawPlayer, .-drawPlayer
	.align	2
	.global	drawFallingSquares
	.type	drawFallingSquares, %function
drawFallingSquares:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	ip, #0
	stmfd	sp!, {r4, r5, lr}
	mov	r4, r0
	sub	sp, sp, #12
	ldr	r3, [r0, #16]
	ldr	r2, [r0, #20]
	add	r0, r0, #8
	ldmia	r0, {r0, r1}
	ldr	r5, .L24
	str	ip, [sp]
	mov	lr, pc
	bx	r5
	mov	ip, #31744
	ldr	r0, [r4]
	add	r0, r0, #1
	ldr	r3, [r4, #16]
	ldr	r2, [r4, #20]
	ldr	r1, [r4, #4]
	str	r0, [r4]
	str	ip, [sp]
	mov	lr, pc
	bx	r5
	add	sp, sp, #12
	@ sp needed
	ldmfd	sp!, {r4, r5, lr}
	bx	lr
.L25:
	.align	2
.L24:
	.word	drawRect
	.size	drawFallingSquares, .-drawFallingSquares
	.align	2
	.global	checkSideCollision
	.type	checkSideCollision, %function
checkSideCollision:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	ip, [r0]
	ldr	r2, [r0, #20]
	ldr	r1, .L30
	add	r3, ip, r2
	cmp	r3, #145
	str	r3, [r1]
	ble	.L29
	stmfd	sp!, {r4, r5, lr}
	mov	lr, #0
	sub	sp, sp, #12
	mov	r4, r0
	ldr	r1, [r0, #4]
	ldr	r3, [r0, #16]
	ldr	r5, .L30+4
	mov	r0, ip
	str	lr, [sp]
	mov	lr, pc
	bx	r5
	mov	r2, #10
	ldr	r3, .L30+8
	str	r2, [r4]
	mov	lr, pc
	bx	r3
	ldr	r3, .L30+12
	smull	r2, r3, r0, r3
	mov	r2, r0, asr #31
	add	r3, r3, r0
	rsb	r3, r2, r3, asr #7
	add	r2, r3, r3, lsl #3
	add	r3, r3, r2, lsl #2
	add	r3, r3, r3, lsl #2
	rsb	r3, r3, r0
	ldr	r2, [r4]
	add	r3, r3, #5
	str	r3, [r4, #4]
	str	r3, [r4, #12]
	str	r2, [r4, #8]
	add	sp, sp, #12
	@ sp needed
	ldmfd	sp!, {r4, r5, lr}
	bx	lr
.L29:
	b	drawFallingSquares
.L31:
	.align	2
.L30:
	.word	bottom_row
	.word	drawRect
	.word	rand
	.word	-1323314247
	.size	checkSideCollision, .-checkSideCollision
	.align	2
	.global	deleteSquares
	.type	deleteSquares, %function
deleteSquares:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	ip, #0
	stmfd	sp!, {r4, lr}
	sub	sp, sp, #8
	ldr	r3, [r0, #16]
	ldr	r2, [r0, #20]
	ldr	r4, .L34
	ldmia	r0, {r0, r1}
	str	ip, [sp]
	mov	lr, pc
	bx	r4
	add	sp, sp, #8
	@ sp needed
	ldmfd	sp!, {r4, lr}
	bx	lr
.L35:
	.align	2
.L34:
	.word	drawRect
	.size	deleteSquares, .-deleteSquares
	.align	2
	.global	drawCaughtSquares
	.type	drawCaughtSquares, %function
drawCaughtSquares:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, lr}
	mov	r5, r1
	mov	r1, r2
	mov	r4, r0
	mov	ip, #0
	ldr	r6, .L38
	ldr	r3, [r6]
	ldr	r2, [r5, #20]
	sub	r3, r3, #1
	mul	r2, r3, r2
	ldr	r0, [r1, #16]
	ldr	r3, [r5, #16]
	rsb	r0, r3, r0
	ldr	r1, [r1, #28]
	ldr	lr, .L38+4
	add	r0, r0, r0, lsr #31
	mov	r0, r0, asr #1
	sub	sp, sp, #12
	str	r0, [lr]
	add	r1, r1, r0
	rsb	lr, r2, #132
	str	r1, [r4, #4]
	ldr	r0, [r4, #8]
	ldr	r1, [r4, #12]
	str	lr, [r4]
	ldr	r7, .L38+8
	str	ip, [sp]
	mov	lr, pc
	bx	r7
	mov	ip, #992
	ldr	r2, [r6]
	add	r3, r5, #16
	ldmia	r3, {r3, lr}
	sub	r2, r2, #1
	ldmia	r4, {r0, r1}
	mul	r2, lr, r2
	str	ip, [sp]
	mov	lr, pc
	bx	r7
	add	sp, sp, #12
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, lr}
	bx	lr
.L39:
	.align	2
.L38:
	.word	stack
	.word	difference
	.word	drawRect
	.size	drawCaughtSquares, .-drawCaughtSquares
	.align	2
	.global	goToStart
	.type	goToStart, %function
goToStart:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r0, #0
	sub	sp, sp, #52
	ldr	r3, .L42
	mov	lr, pc
	bx	r3
	ldr	lr, .L42+4
	mov	r4, #10
	mov	fp, #145
	mov	r10, #120
	mov	r9, #26
	ldmia	lr!, {r0, r1, r2, r3}
	add	ip, sp, #4
	mov	r8, #70
	mov	r7, #16
	mov	r6, #1
	stmia	ip!, {r0, r1, r2, r3}
	mov	r5, #0
	ldmia	lr, {r0, r1}
	mov	lr, #122
	str	r0, [ip], #4
	ldr	r3, .L42+8
	strb	r1, [ip]
	str	r4, [r3, #20]
	str	fp, [r3]
	str	r10, [r3, #4]
	str	r9, [r3, #16]
	ldr	r1, .L42+12
	ldr	r3, .L42+16
	ldr	ip, .L42+20
	mov	r0, r4
	str	r4, [r3]
	str	r4, [r3, #20]
	str	r8, [r3, #4]
	str	r7, [r3, #16]
	str	r6, [r1]
	add	r2, sp, #4
	mov	r3, #31744
	mov	r1, #20
	ldr	r4, .L42+24
	str	r5, [ip, #4]
	str	lr, [ip]
	mov	lr, pc
	bx	r4
	ldr	r3, .L42+28
	str	r5, [r3]
	add	sp, sp, #52
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx	lr
.L43:
	.align	2
.L42:
	.word	fillScreen
	.word	.LC0
	.word	player
	.word	stack
	.word	square
	.word	caught_square
	.word	drawString
	.word	state
	.size	goToStart, .-goToStart
	.align	2
	.global	win
	.type	win, %function
win:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	ldr	r4, .L56
	ldr	r3, [r4]
	tst	r3, #8
	beq	.L45
	ldr	r3, .L56+4
	ldr	r3, [r3]
	tst	r3, #8
	beq	.L54
.L45:
	ldr	r3, [r4]
	mvn	r3, r3
	ands	r3, r3, #2
	bne	.L44
	ldr	r2, .L56+4
	ldr	r2, [r2]
	tst	r2, #2
	beq	.L55
.L44:
	ldmfd	sp!, {r4, lr}
	bx	lr
.L55:
	ldr	r2, .L56+8
	ldmfd	sp!, {r4, lr}
	str	r3, [r2]
	b	goToStart
.L54:
	bl	goToStart
	b	.L45
.L57:
	.align	2
.L56:
	.word	oldButtons
	.word	buttons
	.word	score
	.size	win, .-win
	.align	2
	.type	lose.part.1, %function
lose.part.1:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L60
	ldr	r3, [r3]
	tst	r3, #8
	bxne	lr
	b	goToStart
.L61:
	.align	2
.L60:
	.word	buttons
	.size	lose.part.1, .-lose.part.1
	.align	2
	.global	lose
	.type	lose, %function
lose:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L64
	ldr	r3, [r3]
	tst	r3, #8
	bxeq	lr
	b	lose.part.1
.L65:
	.align	2
.L64:
	.word	oldButtons
	.size	lose, .-lose
	.align	2
	.global	pause
	.type	pause, %function
pause:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	ldr	r4, .L78
	ldr	r0, [r4]
	mvn	r0, r0
	ands	r0, r0, #8
	bne	.L67
	ldr	r3, .L78+4
	ldr	r3, [r3]
	tst	r3, #8
	beq	.L76
.L67:
	ldr	r3, [r4]
	tst	r3, #2
	beq	.L66
	ldr	r3, .L78+4
	ldr	r3, [r3]
	tst	r3, #2
	beq	.L77
.L66:
	ldmfd	sp!, {r4, lr}
	bx	lr
.L77:
	ldmfd	sp!, {r4, lr}
	b	goToStart
.L76:
	ldr	r3, .L78+8
	mov	lr, pc
	bx	r3
	mov	r2, #1
	ldr	r3, .L78+12
	str	r2, [r3]
	b	.L67
.L79:
	.align	2
.L78:
	.word	oldButtons
	.word	buttons
	.word	fillScreen
	.word	state
	.size	pause, .-pause
	.align	2
	.global	goToGame
	.type	goToGame, %function
goToGame:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	ldr	r3, .L82
	mov	r0, #0
	mov	lr, pc
	bx	r3
	mov	r2, #1
	ldr	r3, .L82+4
	ldmfd	sp!, {r4, lr}
	str	r2, [r3]
	bx	lr
.L83:
	.align	2
.L82:
	.word	fillScreen
	.word	state
	.size	goToGame, .-goToGame
	.align	2
	.global	goToPause
	.type	goToPause, %function
goToPause:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	mov	r0, #0
	sub	sp, sp, #48
	ldr	r3, .L86
	mov	lr, pc
	bx	r3
	ldr	r3, .L86+4
	ldmia	r3, {r0, r1}
	add	r2, sp, #4
	str	r0, [sp, #4]
	strh	r1, [sp, #8]	@ movhi
	mov	r3, #31
	mov	r1, #100
	mov	r0, #80
	ldr	r4, .L86+8
	mov	lr, pc
	bx	r4
	mov	r2, #4
	ldr	r3, .L86+12
	str	r2, [r3]
	add	sp, sp, #48
	@ sp needed
	ldmfd	sp!, {r4, lr}
	bx	lr
.L87:
	.align	2
.L86:
	.word	fillScreen
	.word	.LC1
	.word	drawString
	.word	state
	.size	goToPause, .-goToPause
	.align	2
	.global	goToWin
	.type	goToWin, %function
goToWin:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	mov	r0, #0
	sub	sp, sp, #48
	ldr	r3, .L90
	mov	lr, pc
	bx	r3
	ldr	r3, .L90+4
	add	r0, sp, #4
	ldr	r2, [r3]
	ldr	r1, .L90+8
	ldr	r3, .L90+12
	mov	lr, pc
	bx	r3
	ldr	r4, .L90+16
	add	r2, sp, #4
	mov	r3, #992
	mov	r1, #20
	mov	r0, #10
	mov	lr, pc
	bx	r4
	ldr	lr, .L90+20
	ldmia	lr!, {r0, r1, r2, r3}
	add	ip, sp, #4
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr, {r0, r1}
	stmia	ip, {r0, r1}
	mov	r1, #20
	add	r2, sp, #4
	mov	r0, r1
	mov	r3, #992
	mov	lr, pc
	bx	r4
	ldr	lr, .L90+24
	ldmia	lr!, {r0, r1, r2, r3}
	add	ip, sp, #4
	stmia	ip!, {r0, r1, r2, r3}
	ldr	r3, [lr]
	strh	r3, [ip], #2	@ movhi
	mov	lr, r3, lsr #16
	add	r2, sp, #4
	mov	r3, #992
	mov	r1, #20
	mov	r0, #30
	strb	lr, [ip]
	mov	lr, pc
	bx	r4
	mov	r2, #3
	ldr	r3, .L90+28
	str	r2, [r3]
	add	sp, sp, #48
	@ sp needed
	ldmfd	sp!, {r4, lr}
	bx	lr
.L91:
	.align	2
.L90:
	.word	fillScreen
	.word	score
	.word	.LC2
	.word	sprintf
	.word	drawString
	.word	.LC3
	.word	.LC4
	.word	state
	.size	goToWin, .-goToWin
	.align	2
	.global	update
	.type	update, %function
update:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r3, #67108864
	stmfd	sp!, {r4, r5, r6, lr}
	ldr	lr, [r0]
	ldr	ip, [r0, #4]
	ldr	r6, [r1]
	ldr	r5, [r1, #4]
	str	lr, [r0, #8]
	ldmia	r2, {r4, lr}
	str	ip, [r0, #12]
	str	r6, [r1, #8]
	str	r5, [r1, #12]
	str	r4, [r2, #8]
	str	lr, [r2, #12]
	ldr	r3, [r3, #304]
	tst	r3, #32
	bne	.L94
	ldr	r3, [r0, #16]
	add	r3, r3, r3, lsr #31
	sub	r3, ip, r3, asr #1
	cmp	r3, #5
	bgt	.L105
.L94:
	mov	r3, #67108864
	ldr	r3, [r3, #304]
	tst	r3, #16
	bne	.L97
	ldr	r3, [r0, #16]
	ldr	r1, [r0, #4]
	add	r3, r3, r3, lsr #31
	add	r3, r1, r3, asr #1
	cmp	r3, #214
	ble	.L106
.L97:
	ldr	r3, .L107
	ldr	r3, [r3]
	tst	r3, #1
	beq	.L92
	ldr	r3, .L107+4
	ldr	r3, [r3]
	tst	r3, #1
	bne	.L92
	ldr	r3, .L107+8
	ldr	r1, .L107+12
	ldr	r3, [r3]
	ldr	r2, [r1]
	sub	r3, r3, #1
	add	r3, r3, r3, lsl #2
	add	r3, r2, r3, lsl #1
	ldmfd	sp!, {r4, r5, r6, lr}
	str	r3, [r1]
	b	goToWin
.L92:
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L106:
	ldr	r3, .L107+8
	ldr	r3, [r3]
	cmp	r3, #0
	ldrgt	r3, [r2, #4]
	add	r1, r1, #5
	addgt	r3, r3, #5
	str	r1, [r0, #4]
	strgt	r3, [r2, #4]
	b	.L97
.L105:
	ldr	r3, .L107+8
	ldr	r3, [r3]
	cmp	r3, #0
	sub	ip, ip, #5
	subgt	lr, lr, #5
	str	ip, [r0, #4]
	strgt	lr, [r2, #4]
	b	.L94
.L108:
	.align	2
.L107:
	.word	oldButtons
	.word	buttons
	.word	stack
	.word	score
	.size	update, .-update
	.align	2
	.global	goToLose
	.type	goToLose, %function
goToLose:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	mov	r0, #0
	sub	sp, sp, #48
	ldr	r3, .L111
	mov	lr, pc
	bx	r3
	ldr	r3, .L111+4
	add	r0, sp, #4
	ldr	r2, [r3]
	ldr	r1, .L111+8
	ldr	r3, .L111+12
	mov	lr, pc
	bx	r3
	ldr	r4, .L111+16
	add	r2, sp, #4
	mov	r3, #992
	mov	r1, #20
	mov	r0, #10
	mov	lr, pc
	bx	r4
	ldr	r2, .L111+20
	ldmia	r2, {r0, r1, r2}
	add	r3, sp, #4
	stmia	r3!, {r0, r1}
	mov	r1, #20
	strh	r2, [r3]	@ movhi
	mov	r0, r1
	add	r2, sp, #4
	mov	r3, #992
	mov	lr, pc
	bx	r4
	ldr	lr, .L111+24
	ldmia	lr!, {r0, r1, r2, r3}
	add	ip, sp, #4
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr, {r0, r1, r2}
	stmia	ip!, {r0, r1}
	mov	r3, #992
	strh	r2, [ip]	@ movhi
	mov	r1, #20
	add	r2, sp, #4
	mov	r0, #30
	mov	lr, pc
	bx	r4
	mov	r2, #2
	ldr	r3, .L111+28
	str	r2, [r3]
	add	sp, sp, #48
	@ sp needed
	ldmfd	sp!, {r4, lr}
	bx	lr
.L112:
	.align	2
.L111:
	.word	fillScreen
	.word	score
	.word	.LC2
	.word	sprintf
	.word	drawString
	.word	.LC5
	.word	.LC6
	.word	state
	.size	goToLose, .-goToLose
	.align	2
	.global	checkStackCollision
	.type	checkStackCollision, %function
checkStackCollision:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L122
	ldr	r3, [r3]
	ldr	r2, [r0, #20]
	sub	r3, r3, #1
	mul	r3, r2, r3
	stmfd	sp!, {r4, r5, r6, lr}
	ldmia	r0, {r4, lr}
	ldr	ip, [r0, #16]
	rsb	r3, r3, #132
	add	r2, r2, r4
	cmp	r3, r2
	add	r3, lr, ip
	str	lr, [r0, #28]
	str	r3, [r0, #24]
	bge	.L113
	ldr	r2, [r1, #24]
	mov	r5, r1
	sub	r1, r2, #1
	cmp	r3, r1
	mov	r4, r0
	blt	.L116
	sub	r2, r2, #2
	cmp	lr, r2
	blt	.L120
.L116:
	ldr	r3, [r5, #28]
	add	r2, r3, #1
	cmp	r2, lr
	blt	.L113
	ldr	r2, [r4, #24]
	add	r3, r3, #2
	cmp	r2, r3
	bgt	.L121
.L113:
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L121:
	bl	goToLose
	mov	r2, #0
	ldr	r3, .L122+4
	ldmfd	sp!, {r4, r5, r6, lr}
	str	r2, [r3]
	bx	lr
.L120:
	bl	goToLose
	mov	r2, #0
	ldr	r3, .L122+4
	ldr	lr, [r4, #28]
	str	r2, [r3]
	b	.L116
.L123:
	.align	2
.L122:
	.word	stack
	.word	score
	.size	checkStackCollision, .-checkStackCollision
	.align	2
	.global	checkPaddleCollision
	.type	checkPaddleCollision, %function
checkPaddleCollision:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov	r4, r1
	ldr	lr, [r0, #16]
	ldr	r2, [r0, #4]
	ldr	r1, [r1, #4]
	ldr	r3, [r4, #16]
	add	lr, lr, lr, lsr #31
	sub	r7, r2, lr, asr #1
	cmp	r1, r7
	add	lr, r2, lr, asr #1
	add	r9, r1, r3
	movle	r6, #0
	movgt	r6, #1
	cmp	r9, lr
	movge	r6, #0
	ldr	r5, .L128
	ldr	ip, [r5]
	ldr	r2, [r4, #20]
	sub	ip, ip, #1
	mul	ip, r2, ip
	ldr	r8, [r4]
	rsb	ip, ip, #132
	add	r10, r8, r2
	cmp	ip, r10
	movne	ip, #0
	andeq	ip, r6, #1
	cmp	ip, #0
	ldr	ip, .L128+4
	str	r1, [r4, #28]
	str	r9, [r4, #24]
	sub	sp, sp, #8
	str	r10, [ip]
	str	r7, [r0, #28]
	str	lr, [r0, #24]
	bne	.L127
	mov	r1, r0
	mov	r0, r4
	bl	checkStackCollision
	mov	r0, r4
	add	sp, sp, #8
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	b	checkSideCollision
.L127:
	mov	ip, #0
	mov	r0, r8
	str	ip, [sp]
	ldr	r6, .L128+8
	mov	lr, pc
	bx	r6
	mov	r2, #10
	ldr	r3, [r5]
	add	r3, r3, #1
	str	r3, [r5]
	str	r2, [r4]
	ldr	r3, .L128+12
	mov	lr, pc
	bx	r3
	ldr	r3, .L128+16
	smull	r2, r3, r0, r3
	mov	r2, r0, asr #31
	add	r3, r3, r0
	rsb	r3, r2, r3, asr #7
	add	r2, r3, r3, lsl #3
	add	r3, r3, r2, lsl #2
	add	r3, r3, r3, lsl #2
	rsb	r3, r3, r0
	mov	r0, r4
	ldr	r2, [r4]
	add	r3, r3, #5
	str	r3, [r4, #4]
	str	r3, [r4, #12]
	str	r2, [r4, #8]
	add	sp, sp, #8
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	b	drawFallingSquares
.L129:
	.align	2
.L128:
	.word	stack
	.word	bottom_row
	.word	drawRect
	.word	rand
	.word	-1323314247
	.size	checkPaddleCollision, .-checkPaddleCollision
	.align	2
	.global	draw
	.type	draw, %function
draw:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	bl	drawPlayer
	mov	r4, #3
	ldr	r5, .L135
.L131:
	mov	lr, pc
	bx	r5
	ldr	r1, .L135+4
	ldr	r0, .L135+8
	bl	checkPaddleCollision
	subs	r4, r4, #1
	bne	.L131
	ldr	r3, .L135+12
	ldr	r3, [r3]
	cmp	r3, #1
	ble	.L130
	ldr	r2, .L135+8
	ldr	r1, .L135+4
	ldr	r0, .L135+16
	ldmfd	sp!, {r4, r5, r6, lr}
	b	drawCaughtSquares
.L130:
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L136:
	.align	2
.L135:
	.word	waitForVblank
	.word	square
	.word	player
	.word	stack
	.word	caught_square
	.size	draw, .-draw
	.align	2
	.global	game
	.type	game, %function
game:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	ldr	r2, .L149
	ldr	r1, .L149+4
	ldr	r0, .L149+8
	ldr	r4, .L149+12
	bl	update
	ldr	r3, .L149+16
	mov	lr, pc
	bx	r3
	bl	draw
	ldr	r3, [r4]
	tst	r3, #8
	beq	.L138
	ldr	r3, .L149+20
	ldr	r3, [r3]
	tst	r3, #8
	beq	.L148
.L138:
	ldr	r3, [r4]
	tst	r3, #1
	beq	.L137
	ldr	r3, .L149+20
	ldr	r3, [r3]
	tst	r3, #1
	ldmeqfd	sp!, {r4, lr}
	beq	goToWin
.L137:
	ldmfd	sp!, {r4, lr}
	bx	lr
.L148:
	bl	goToPause
	b	.L138
.L150:
	.align	2
.L149:
	.word	caught_square
	.word	square
	.word	player
	.word	oldButtons
	.word	waitForVblank
	.word	buttons
	.size	game, .-game
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ Volatile: function does not return.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r5, #67108864
	mov	r3, #0
	ldr	r2, .L161
	ldr	r0, .L161+4
	ldr	r10, .L161+8
	stmfd	sp!, {r4, r7, fp, lr}
	strh	r2, [r5]	@ movhi
	ldr	r2, .L161+12
	str	r3, [r0]
	str	r3, [r10]
	mov	lr, pc
	bx	r2
	ldr	fp, .L161+16
	ldr	r4, .L161+20
	ldr	r9, .L161+24
	ldr	r8, .L161+28
	ldr	r7, .L161+32
	ldr	r6, .L161+36
.L152:
	ldr	r3, [fp]
	str	r3, [r4]
	ldr	r3, [r10]
	ldr	r2, [r5, #304]
	str	r2, [fp]
	cmp	r3, #4
	ldrls	pc, [pc, r3, asl #2]
	b	.L152
.L155:
	.word	.L154
	.word	.L156
	.word	.L157
	.word	.L158
	.word	.L159
.L159:
	mov	lr, pc
	bx	r6
	b	.L152
.L158:
	mov	lr, pc
	bx	r7
	b	.L152
.L157:
	ldr	r3, [r4]
	tst	r3, #8
	beq	.L152
	ldr	r3, .L161+40
	mov	lr, pc
	bx	r3
	b	.L152
.L156:
	mov	lr, pc
	bx	r8
	b	.L152
.L154:
	mov	lr, pc
	bx	r9
	b	.L152
.L162:
	.align	2
.L161:
	.word	1027
	.word	score
	.word	state
	.word	goToStart
	.word	buttons
	.word	oldButtons
	.word	start
	.word	game
	.word	win
	.word	pause
	.word	lose.part.1
	.size	main, .-main
	.comm	oldButtons,4,4
	.comm	buttons,4,4
	.comm	caught_square,16,4
	.comm	square,36,4
	.comm	player,36,4
	.comm	state,4,4
	.comm	score,4,4
	.comm	stack,4,4
	.comm	difference,4,4
	.comm	bottom_row,4,4
	.comm	speed,4,4
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"PRESS ENTER TO START\000"
	.space	3
.LC1:
	.ascii	"PAUSE\000"
	.space	2
.LC2:
	.ascii	"Score: %d\000"
	.space	2
.LC3:
	.ascii	"PRESS START TO CONTINUE\000"
.LC4:
	.ascii	"PRESS B TO RESTART\000"
	.space	1
.LC5:
	.ascii	"GAME OVER\000"
	.space	2
.LC6:
	.ascii	"PRESS START TO PLAY AGAIN\000"
	.ident	"GCC: (devkitARM release 45) 5.3.0"
