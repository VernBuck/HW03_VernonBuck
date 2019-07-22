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
	.file	"update.c"
	.text
	.align	2
	.global	checkEdgeCollision
	.type	checkEdgeCollision, %function
checkEdgeCollision:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r0, #0]
	cmp	r3, #0
	movlt	r0, #0
	bxlt	lr
	ldr	r2, [r0, #8]
	cmp	r2, #0
	movlt	r0, #3
	bxlt	lr
	ldr	ip, [r0, #28]
	ldr	r1, [r0, #20]
	add	r2, r2, ip
	add	r2, r2, r1
	cmp	r2, #240
	bgt	.L5
	ldr	r1, [r0, #24]
	ldr	r2, [r0, #16]
	add	r3, r3, r1
	add	r3, r3, r2
	cmp	r3, #161
	mvnlt	r0, #0
	movge	r0, #2
	bx	lr
.L5:
	mov	r0, #1
	bx	lr
	.size	checkEdgeCollision, .-checkEdgeCollision
	.align	2
	.global	updatePlayer
	.type	updatePlayer, %function
updatePlayer:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r2, [r0, #0]
	ldr	r3, [r0, #8]
	str	r2, [r0, #4]
	str	r3, [r0, #12]
	mov	r2, #67108864
	ldr	r2, [r2, #304]
	tst	r2, #16
	bne	.L9
	ldr	r2, [r0, #28]
	rsb	r2, r2, #240
	cmp	r3, r2
	addlt	r3, r3, #1
	strlt	r3, [r0, #8]
.L9:
	mov	r3, #67108864
	ldr	r3, [r3, #304]
	tst	r3, #32
	bxne	lr
	ldr	r3, [r0, #8]
	cmp	r3, #0
	subgt	r3, r3, #1
	strgt	r3, [r0, #8]
	bx	lr
	.size	updatePlayer, .-updatePlayer
	.align	2
	.global	collisionCheckObstaclePlayer
	.type	collisionCheckObstaclePlayer, %function
collisionCheckObstaclePlayer:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r1, #8]
	ldr	ip, [r1, #28]
	ldr	r2, [r0, #8]
	add	ip, r3, ip
	cmp	r2, ip
	bxgt	lr
	ldr	ip, [r0, #28]
	add	r2, r2, ip
	cmp	r3, r2
	bxgt	lr
	ldr	ip, [r0, #24]
	ldr	r2, [r0, #0]
	ldr	r3, [r1, #0]
	add	r2, ip, r2
	cmp	r2, r3
	ldrge	r3, [r0, #16]
	rsbge	r3, r3, #0
	strge	r3, [r0, #16]
	bx	lr
	.size	collisionCheckObstaclePlayer, .-collisionCheckObstaclePlayer
	.align	2
	.global	checkAllCollisions
	.type	checkAllCollisions, %function
checkAllCollisions:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	ldr	r9, .L22
	sub	sp, sp, #20
	mov	r8, r0
	mov	r6, r0
	mov	r7, #0
	mov	sl, #1
.L14:
	mov	r4, r8
	mov	r5, #0
.L17:
	cmp	r7, r5
	beq	.L15
	ldr	r3, [r4, #32]
	cmp	r3, #0
	beq	.L20
.L15:
	add	r5, r5, #1
	cmp	r5, #2
	add	r4, r4, #40
	bne	.L17
	add	r7, r7, #1
	cmp	r7, #2
	add	r6, r6, #40
	bne	.L14
	add	sp, sp, #20
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L20:
	ldr	r3, [r4, #0]
	ldr	r0, [r4, #16]
	add	r0, r0, r3
	add	fp, r6, #16
	ldmia	fp, {fp, lr}	@ phole ldm
	ldr	r1, [r6, #8]
	ldr	r2, [r6, #28]
	ldr	r3, [r6, #24]
	str	r0, [sp, #0]
	ldr	ip, [r4, #20]
	ldr	r0, [r4, #8]
	add	r0, ip, r0
	str	r0, [sp, #4]
	ldr	r0, [r4, #28]
	str	r0, [sp, #8]
	ldr	r0, [r6, #0]
	ldr	ip, [r4, #24]
	add	r0, fp, r0
	add	r1, lr, r1
	str	ip, [sp, #12]
	mov	lr, pc
	bx	r9
	cmp	r0, #0
	cmpne	r0, #2
	beq	.L21
	cmp	r0, #1
	cmpne	r0, #3
	bne	.L15
	ldr	r3, [r6, #20]
	rsb	r3, r3, #0
	str	r3, [r6, #20]
	ldr	r3, [r4, #20]
	rsb	r3, r3, #0
	str	sl, [r6, #32]
	str	r3, [r4, #20]
	str	sl, [r4, #32]
	b	.L15
.L21:
	ldr	r3, [r6, #16]
	rsb	r3, r3, #0
	str	r3, [r6, #16]
	ldr	r3, [r4, #16]
	rsb	r3, r3, #0
	str	sl, [r6, #32]
	str	r3, [r4, #16]
	str	sl, [r4, #32]
	b	.L15
.L23:
	.align	2
.L22:
	.word	genericCollision
	.size	checkAllCollisions, .-checkAllCollisions
	.align	2
	.global	updateBox
	.type	updateBox, %function
updateBox:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	ldr	r3, [r0, #8]
	ldr	r2, [r0, #0]
	add	r5, r0, #16
	ldmia	r5, {r5, r6}	@ phole ldm
	add	ip, r5, r2
	add	r1, r6, r3
	str	r3, [r0, #12]
	str	r2, [r0, #4]
	str	ip, [r0, #0]
	str	r1, [r0, #8]
	mov	r4, r0
	bl	checkEdgeCollision
	cmp	r0, #2
	movne	r3, #0
	moveq	r3, #1
	cmp	r0, #2
	cmpne	r0, #0
	bne	.L25
	cmp	r3, #0
	rsb	r5, r5, #0
	movne	r3, #31	@ movhi
	str	r5, [r4, #16]
	strneh	r3, [r4, #36]	@ movhi
.L26:
	mov	r3, #0
	str	r3, [r4, #32]
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L25:
	cmp	r0, #1
	cmpne	r0, #3
	rsbeq	r6, r6, #0
	streq	r6, [r4, #20]
	b	.L26
	.size	updateBox, .-updateBox
	.ident	"GCC: (devkitARM release 31) 4.5.0"
