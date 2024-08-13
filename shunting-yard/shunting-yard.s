#include <stdio.h>

.globl main
.section .text

main:
        mov x18, x30
        ldr x0, =source
        ldr x1, =stackp
        sub x1, x1, 1
	add x2, x1, 1
        ldr x3, =target

        bl shunt

        ldr x0, =printx
        ldr x1, =source
        ldr x2, =target
//	ldr x3, =stackp

        bl printf

        mov x30, x18
        ret

shunt:
/*
        x0 holds address of expression
        x1 holds address of operand stack
        x2 holds address of stack head
        x3 holds address of target string
*/
1:      ldrb w6, [x0], 1
        cbz  x6, 95f

        cmp  x6, '('
        b.eq 10f
        cmp  x6, '*'
        b.eq 10f
        cmp  x6, '/'
        b.eq 10f

        cmp  x6, '+'
        b.eq 20f
        cmp  x6, '-'
        b.eq 20f

        cmp  x6, ')'
        b.eq 30f

        b    40f

// mul, div, opening bracket
10:     strb w6, [x2], 1
        b    1b

// sub, add
20:	cmp  x1, x2
	b.eq 25f

	ldrb w5, [x2, #-1]!
	cmp  w5, '/'
	b.eq 22f
	cmp  w5, '*'
	b.eq 22f

	b    25f

22:	strb w6, [x2], 1
	strb w5, [x3], 1
	b    1b

25:	strb w6, [x2], 1
	b    1b

// closing bracket
30:     cmp  x1, x2
	b.le 1b

31:	ldrb w5, [x2, #-1]
	cmp  w5, '('
	b.eq 32f

	strb w5, [x3], 1
	sub  x2, x2, 1
	b    31b

32:	sub  x2, x2, 1
	b    1b

// default case
40:     strb w6, [x3], 1
        b    1b

// now that the expression's trawled
95:	sub  x0, x2, x1
96:	cmp  x2, x1
	b.le 99f
	sub  x2, x2, 1
	ldrb w6, [x2]
	strb w6, [x3], 1
	b    96b

99:	strb wzr, [x2, x0]
	ret

.section .data

target: .asciz "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
stackp: .asciz "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

.section .rodata

source: .asciz "A*C+D*(E+F)"
printx: .asciz "%s -> %s\n"
