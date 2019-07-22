	.cpu arm7tdmi
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.align	2
	.global	init
	.type	init, %function
init:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, lr}
	ldr	r4, .L6
	mov	r2, #30
	mov	r3, #1024
	add	r3, r3, #3
	str	r2, [r4, #40]
	mov	r2, #67108864
	strh	r3, [r2, #0]	@ movhi
	ldr	r5, .L6+4
	mov	lr, pc
	bx	r5
	ldr	r3, .L6+8
	smull	r2, r3, r0, r3
	mov	r2, r0, asr #31
	add	r3, r3, r0
	rsb	r3, r2, r3, asr #6
	rsb	r3, r3, r3, asl #4
	sub	r0, r0, r3, asl #3
	add	r0, r0, #10
	str	r0, [r4, #48]
	mov	lr, pc
	bx	r5
	tst	r0, #1
	moveq	r3, #1
	mvnne	r3, #0
	streq	r3, [r4, #56]
	strne	r3, [r4, #56]
	mov	lr, pc
	bx	r5
	tst	r0, #1
	moveq	r3, #1
	mvnne	r3, #0
	streq	r3, [r4, #60]
	strne	r3, [r4, #60]
	ldr	r3, .L6+12
	mov	r1, #5
	mov	r2, #0
	str	r2, [r3, #16]
	str	r2, [r3, #20]
	str	r1, [r4, #68]
	mov	r2, #30
	str	r1, [r4, #64]
	mov	r1, #150
	str	r1, [r3, #0]
	str	r2, [r3, #28]
	mov	r1, #120
	mov	r2, #8
	str	r1, [r3, #8]
	str	r2, [r3, #24]
	mov	r3, #992	@ movhi
	strh	r3, [r4, #76]	@ movhi
	ldmfd	sp!, {r3, r4, r5, lr}
	bx	lr
.L7:
	.align	2
.L6:
	.word	boxes
	.word	rand
	.word	-2004318071
	.word	player
	.size	init, .-init
	.align	2
	.global	update
	.type	update, %function
update:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, lr}
	ldr	r5, .L9
	ldr	r4, .L9+4
	mov	r0, r5
	ldr	r3, .L9+8
	mov	lr, pc
	bx	r3
	mov	r0, r4
	ldr	r3, .L9+12
	mov	lr, pc
	bx	r3
	mov	r0, r4
	mov	r1, r5
	ldr	r3, .L9+16
	mov	lr, pc
	bx	r3
	sub	r0, r4, #40
	ldr	r3, .L9+20
	mov	lr, pc
	bx	r3
	ldmfd	sp!, {r3, r4, r5, lr}
	bx	lr
.L10:
	.align	2
.L9:
	.word	player
	.word	boxes+40
	.word	updatePlayer
	.word	updateBox
	.word	collisionCheckObstaclePlayer
	.word	checkAllCollisions
	.size	update, .-update
	.align	2
	.global	draw
	.type	draw, %function
draw:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, lr}
	ldr	r5, .L12
	ldr	r4, .L12+4
	mov	r0, r5
	mov	lr, pc
	bx	r4
	add	r0, r5, #40
	mov	lr, pc
	bx	r4
	ldr	r0, .L12+8
	ldr	r3, .L12+12
	mov	lr, pc
	bx	r3
	ldmfd	sp!, {r3, r4, r5, lr}
	bx	lr
.L13:
	.align	2
.L12:
	.word	boxes
	.word	drawBox
	.word	player
	.word	drawPlayer
	.size	draw, .-draw
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, r6, r7, lr}
	bl	init
	ldr	r7, .L17
	ldr	r4, .L17+4
	ldr	r6, .L17+8
	mov	r5, #67108864
.L15:
	ldr	r2, [r4, #0]
	ldr	r3, [r5, #304]
	str	r2, [r7, #0]
	str	r3, [r4, #0]
	bl	update
	mov	lr, pc
	bx	r6
	bl	draw
	b	.L15
.L18:
	.align	2
.L17:
	.word	oldButtons
	.word	buttons
	.word	waitForVblank
	.size	main, .-main
	.comm	player,40,4
	.comm	boxes,80,4
	.comm	oldButtons,4,4
	.comm	buttons,4,4
	.ident	"GCC: (devkitARM release 31) 4.5.0"
