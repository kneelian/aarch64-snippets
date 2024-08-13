#include <stdio.h>
.globl main
.section .text
main:
	stp x29, x30, [sp, #-16]!

	adr x0, floats

	ld1 {v9.4s}, [x0], 16
	ld1 {v10.4s},[x0], 16
	ld1 {v11.4s},[x0], 16
	ld1 {v12.4s},[x0], 16 // rows of A

	ld1 {v13.4s},[x0], 16
	ld1 {v14.4s},[x0], 16
	ld1 {v15.4s},[x0], 16
	ld1 {v16.4s},[x0]     // rows of B

	adr x0, scratch

	st1 {v13.4s},[x0]
	ld4 {v0.s, v1.s, v2.s, v3.s}[0], [x0], 16
	st1 {v14.4s},[x0]
	ld4 {v0.s, v1.s, v2.s, v3.s}[1], [x0], 16
	st1 {v15.4s},[x0]
	ld4 {v0.s, v1.s, v2.s, v3.s}[2], [x0], 16
	st1 {v16.4s},[x0]
	ld4 {v0.s, v1.s, v2.s, v3.s}[3], [x0]
	// now v0-v3 hold columns of B transposed

	fmul v17.4s, v9.4s, v0.4s
	fmul v18.4s, v9.4s, v1.4s
	fmul v19.4s, v9.4s, v2.4s
	fmul v20.4s, v9.4s, v3.4s
	fcvtzs v17.4s, v17.4s, #16
	fcvtzs v18.4s, v18.4s, #16
	fcvtzs v19.4s, v19.4s, #16
	fcvtzs v20.4s, v20.4s, #16
	addv s17, v17.4s
	addv s18, v18.4s
	addv s19, v19.4s
	addv s20, v20.4s
	scvtf s17, s17, #16
	scvtf s18, s18, #16
	scvtf s19, s19, #16
	scvtf s20, s20, #16
	mov v5.4s[0], v17.4s[0]
	mov v5.4s[1], v18.4s[0]
	mov v5.4s[2], v19.4s[0]
	mov v5.4s[3], v20.4s[0]

	fmul v17.4s, v10.4s, v0.4s
	fmul v18.4s, v10.4s, v1.4s
	fmul v19.4s, v10.4s, v2.4s
	fmul v20.4s, v10.4s, v3.4s
	fcvtzs v17.4s, v17.4s, #16
	fcvtzs v18.4s, v18.4s, #16
	fcvtzs v19.4s, v19.4s, #16
	fcvtzs v20.4s, v20.4s, #16
	addv s17, v17.4s
	addv s18, v18.4s
	addv s19, v19.4s
	addv s20, v20.4s
	scvtf s17, s17, #16
	scvtf s18, s18, #16
	scvtf s19, s19, #16
	scvtf s20, s20, #16
	mov v6.4s[0], v17.4s[0]
	mov v6.4s[1], v18.4s[0]
	mov v6.4s[2], v19.4s[0]
	mov v6.4s[3], v20.4s[0]

	fmul v17.4s, v11.4s, v0.4s
	fmul v18.4s, v11.4s, v1.4s
	fmul v19.4s, v11.4s, v2.4s
	fmul v20.4s, v11.4s, v3.4s
	fcvtzs v17.4s, v17.4s, #16
	fcvtzs v18.4s, v18.4s, #16
	fcvtzs v19.4s, v19.4s, #16
	fcvtzs v20.4s, v20.4s, #16
	addv s17, v17.4s
	addv s18, v18.4s
	addv s19, v19.4s
	addv s20, v20.4s
	scvtf s17, s17, #16
	scvtf s18, s18, #16
	scvtf s19, s19, #16
	scvtf s20, s20, #16
	mov v7.4s[0], v17.4s[0]
	mov v7.4s[1], v18.4s[0]
	mov v7.4s[2], v19.4s[0]
	mov v7.4s[3], v20.4s[0]

	fmul v17.4s, v12.4s, v0.4s
	fmul v18.4s, v12.4s, v1.4s
	fmul v19.4s, v12.4s, v2.4s
	fmul v20.4s, v12.4s, v3.4s
	fcvtzs v17.4s, v17.4s, #16
	fcvtzs v18.4s, v18.4s, #16
	fcvtzs v19.4s, v19.4s, #16
	fcvtzs v20.4s, v20.4s, #16
	addv s17, v17.4s
	addv s18, v18.4s
	addv s19, v19.4s
	addv s20, v20.4s
	scvtf s17, s17, #16
	scvtf s18, s18, #16
	scvtf s19, s19, #16
	scvtf s20, s20, #16
	mov v8.4s[0], v17.4s[0]
	mov v8.4s[1], v18.4s[0]
	mov v8.4s[2], v19.4s[0]
	mov v8.4s[3], v20.4s[0]

	mov v13.16b, v5.16b
	mov v14.16b, v6.16b
	mov v15.16b, v7.16b
	mov v16.16b, v8.16b

	adr x0, scratch
	st1 {v13.4s}, [x0]
	ld4 {v0.s, v1.s, v2.s, v3.s}[0], [x0]
	fcvt d0, s0
	fcvt d1, s1
	fcvt d2, s2
	fcvt d3, s3

	adr x0, format1
	bl printf

	adr x0, scratch
	st1 {v14.4s}, [x0]
	ld4 {v0.s, v1.s, v2.s, v3.s}[0], [x0]
	fcvt d0, s0
	fcvt d1, s1
	fcvt d2, s2
	fcvt d3, s3

	adr x0, format2
	bl printf

	adr x0, scratch
	st1 {v15.4s}, [x0]
	ld4 {v0.s, v1.s, v2.s, v3.s}[0], [x0]
	fcvt d0, s0
	fcvt d1, s1
	fcvt d2, s2
	fcvt d3, s3

	adr x0, format2
	bl printf

	adr x0, scratch
	st1 {v16.4s}, [x0]
	ld4 {v0.s, v1.s, v2.s, v3.s}[0], [x0]
	fcvt d0, s0
	fcvt d1, s1
	fcvt d2, s2
	fcvt d3, s3

	adr x0, format2
	bl printf


	ldp x29, x30, [sp], 16
	ret

.section .data
scratch: .skip 256

.section .rodata
format1: .asciz "vector: (%f, %f, %f, %f)\n"
format2: .asciz "        (%f, %f, %f, %f)\n"

floats: .float 5.0, 7.0, 9.0, 10.0, 2.0, 3.0, 3.0, 8.0
floats2:.float 8.0, 10.0,2.0, 3.0,  3.0, 3.0, 4.0, 8.0
floats3:.float 3.0, 10.0,12.0,18.0, 12.0,1.0, 4.0, 9.0
floats4:.float 9.0, 10.0,12.0,2.0,  3.0, 12.0,4.0, 10.0
