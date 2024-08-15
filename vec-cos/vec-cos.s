#include <stdio.h>

.globl main
.section .text
main:
	stp x29, x30, [sp, #-16]!

	adr x0, magic1

	ld1r {v8.4s}, [x0], 4
	ld1r {v10.4s}, [x0], 4
	ld1r {v9.4s},[x0], 4
	ld1r {v11.4s},[x0], 4

	ld1 {v13.4s}, [x0] // the four numbers

	fmul v14.4s, v13.4s, v13.4s // square x^2
	fmul v15.4s, v14.4s, v14.4s // quart  x^4

	fmov v20.4s, #1.0
	fmov v21.4s, #1.0
	fmls v20.4s, v14.4s, v8.4s
	fmla v21.4s, v14.4s, v10.4s
	fmla v20.4s, v15.4s, v9.4s
	fmla v21.4s, v15.4s, v11.4s

	fdiv v22.4s, v20.4s, v21.4s

	adr x0, scratch

	st1  {v22.4s}, [x0]
	ld4  {v4.s, v5.s, v6.s, v7.s}[0], [x0]
	fcvt d4, s4
	fcvt d5, s5
	fcvt d6, s6
	fcvt d7, s7

	st1 {v13.4s}, [x0]
	ld4 {v0.s, v1.s, v2.s, v3.s}[0], [x0]
	fcvt d0, s0
	fcvt d1, s1
	fcvt d2, s2
	fcvt d3, s3

	adr x0, format
	bl printf

	ldp x29, x30, [sp], 16
	ret


.section .data
scratch: .skip 64

.section .rodata
format: .asciz "(%f, %f, %f, %f) --> (%.9f, %.9f, %.9f, %.9f)\n"
magic1: .float 0.45634920634920634920634920634920634920 // 115:252
magic2: .float 0.04365079365079365079365079365079365079 // 11:252
magic3: .float 0.02070105820105820105820105820105820106 // 313 : 15120
magic4: .float 0.00085978835978835978835978835978835979 // 13  : 15120

num1:   .float 4.14159265358979323846264338327950288419 // pi+1
num2:   .float 3.14159265358979323846264338327950288419
num3:   .float 0
num4:	.float 0.73908513321516064165531208767387340400 // dottie number
