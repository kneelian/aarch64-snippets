#include <stdio.h>
.globl render
.section .text

.macro PRINTCHAR p
	str \p, [addr], 4
.endm

xsize   .req x9
xsize_w .req w9
ysize   .req x10
ysize_w .req w10

min_imag .req s8
max_imag .req s9
min_real .req s10
max_real .req s26

imag .req s11
real .req s12

step_x .req s13
step_y .req s14

zi .req s15
zr .req s16

a .req s17
b .req s18

ftemp_1 .req s19
ftemp_2 .req s20
ftemp_3 .req s24
ftemp_4 .req s25

y .req x19
y_w .req w19
x .req x20
x_w .req w20
n .req x21
limit .req x22

addr_in .req x0
arg1 .req x1
arg2 .req x2
addr .req x3

itemp_1 .req x23
itemp_1w .req w23

render:
	stp xzr, lr, [sp, #-16]!
	stp d8,  d9, [sp, #-16]!
	stp d10, d11,[sp, #-16]!
	stp d12, d13,[sp, #-16]!
	stp d14, d15,[sp, #-16]!
	stp x19, x20,[sp, #-16]!
	stp x21, x22,[sp, #-16]!
	stp x23, x24,[sp, #-16]!

	mov xsize, arg1
	mov ysize, arg2

	mov addr, addr_in

	mov limit, #128

	adr x0, limits
	ld4 {v8.s, v9.s, v10.s, v11.s}[0], [x0]
	fmov max_real, s11
/*	fmov min_imag, #-0.25
	fmov max_imag, #0.25
	fmov min_real, #-1.75
	fmov max_real, #1.0*/

	fsub  step_x,   max_real, min_real
	scvtf ftemp_1,  xsize_w
	fdiv  step_x,   step_x, ftemp_1

	fsub  step_y,   max_imag, min_imag
	scvtf ftemp_1,  ysize_w
	fdiv  step_y,   step_y, ftemp_1

	mov y, #0
	1:
	cmp y, ysize
	b.eq   20f

	scvtf ftemp_1, y_w
	fmadd imag, step_y, ftemp_1, min_imag

		mov x, #0
		2:
		cmp x, xsize
		b.eq   15f

		scvtf ftemp_1, x_w
		fmadd real, step_x, ftemp_1, min_real

		fmov zr, real
		fmov zi, imag

			mov n, #0
			3:
			cmp n, limit
			b.eq 10f

			fmul a, zr, zr
			fmul b, zi, zi
			fadd ftemp_1, a, b
			fmov ftemp_2, #4.0
			fcmp ftemp_1, ftemp_2
			b.gt 10f

			fmul  zi, zi, zr
			fmov  ftemp_2, #2.0
			fmadd zi, zi, ftemp_2, imag

			fsub  zr, a, b
			fadd  zr, zr, real

			add n, n, #1
			b 3b
			10:

		add x, x, #1
		ucvtf ftemp_3, n
		ucvtf ftemp_4, limit
		fdiv ftemp_3, ftemp_3, ftemp_4
//		fmov ftemp_3, #1.0
		PRINTCHAR ftemp_3
		b   2b
		15:

	add y, y, #1
	b   1b
	20:

	ldp x23, x24,[sp], 16
	ldp x21, x22,[sp], 16
	ldp x19, x20,[sp], 16
	ldp d14, d15,[sp], 16
	ldp d12, d13,[sp], 16
	ldp d10, d11,[sp], 16
	ldp d8,  d9, [sp], 16
	ldp xzr, lr, [sp], 16
	ret

.section .rodata
limits: .float -1.0, 1.0, -2.0, 0.75 // -0.9, -0.62, -0.255, -0.075
