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
	rsb	r0, r0, r0, asl #4
	add	r0, r1, r0, asl #4
	ldr	r3, [r3, #0]
	mov	r0, r0, asl #1
	strh	r2, [r3, r0]	@ movhi
	bx	lr
.L3:
	.align	2
.L2:
	.word	.LANCHOR0
	.size	setPixel, .-setPixel
	.align	2
	.global	drawRect
	.type	drawRect, %function
drawRect:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5}
	cmp	r2, #0
	ldrh	ip, [sp, #8]
	ble	.L4
	ldr	r4, .L12
	rsb	r0, r0, r0, asl #4
	ldr	r4, [r4, #0]
	add	r1, r1, r0, asl #4
	add	r5, r4, r1, asl #1
	mov	r4, #0
.L6:
	cmp	r3, #0
	movgt	r0, r5
	movgt	r1, #0
	ble	.L8
.L7:
	add	r1, r1, #1
	cmp	r1, r3
	strh	ip, [r0], #2	@ movhi
	bne	.L7
.L8:
	add	r4, r4, #1
	cmp	r4, r2
	add	r5, r5, #480
	bne	.L6
.L4:
	ldmfd	sp!, {r4, r5}
	bx	lr
.L13:
	.align	2
.L12:
	.word	.LANCHOR0
	.size	drawRect, .-drawRect
	.align	2
	.global	waitForVblank
	.type	waitForVblank, %function
waitForVblank:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r2, #67108864
.L15:
	ldrh	r3, [r2, #6]
	cmp	r3, #160
	bhi	.L15
	mov	r2, #67108864
.L17:
	ldrh	r3, [r2, #6]
	cmp	r3, #159
	bls	.L17
	bx	lr
	.size	waitForVblank, .-waitForVblank
	.align	2
	.global	genericCollision
	.type	genericCollision, %function
genericCollision:
	@ Function supports interworking.
	@ args = 16, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7}
	ldr	ip, [sp, #20]
	ldr	r5, [sp, #24]
	ldr	r4, [sp, #16]
	add	r5, r5, ip
	ldr	r6, [sp, #28]
	cmp	r5, r1
	add	r6, r6, r4
	ble	.L26
	add	r7, r2, r1
	cmp	ip, r7
	bge	.L26
	cmp	r6, r0
	cmpge	r0, r4
	movlt	r7, #1
	blt	.L21
	mov	r0, #0
.L22:
	ldmfd	sp!, {r4, r5, r6, r7}
	bx	lr
.L26:
	mov	r7, #0
.L21:
	add	r3, r3, r0
	cmp	r4, r3
	ble	.L35
.L23:
	cmp	r6, r0
	ble	.L30
	cmp	r4, r3
	bge	.L30
	cmp	r5, r1
	cmpge	r1, ip
	movlt	r3, #1
	blt	.L24
	mov	r0, #3
	b	.L22
.L35:
	cmp	r6, r3
	blt	.L23
	cmp	r7, #0
	movne	r0, #2
	bne	.L22
	b	.L23
.L30:
	mov	r3, #0
.L24:
	add	r1, r2, r1
	cmp	ip, r1
	bgt	.L33
	cmp	r5, r1
	blt	.L33
	cmp	r3, #0
	movne	r0, #1
	mvneq	r0, #0
	b	.L22
.L33:
	mvn	r0, #0
	b	.L22
	.size	genericCollision, .-genericCollision
	.global	videoBuffer
	.data
	.align	2
	.set	.LANCHOR0,. + 0
	.type	videoBuffer, %object
	.size	videoBuffer, 4
videoBuffer:
	.word	100663296
	.ident	"GCC: (devkitARM release 31) 4.5.0"
