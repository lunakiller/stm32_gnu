.syntax unified
.cpu cortex-m3
.thumb

RCC_base = 0x40021000
APB2ENR_offset = 0x18
APB2ENR_mask = (1 << 4)
GPIOC_base = 0x40011000
CRH_offset = 0x04
MODER_mask = 0x200000
ODR_offset = 0x0C
LED_pin = 13
LED_mask = (1 << LED_pin)

.type main, %function
.global main
main:
	nop									@ do nothing
	ldr r0, =12345678					@ load random value and save it to
	mov r1, r0							@ register, can be observed by debugger

	ldr r2, =RCC_base					@ enable clock for APB2 bus
	ldr r3, [r2, #APB2ENR_offset]		
	orr r3, r3, #APB2ENR_mask
	str r3, [r2, #APB2ENR_offset]

	ldr r2, =GPIOC_base					@ set PC13 as output
	ldr r3, [r2, #CRH_offset]
	orr r3, r3, #MODER_mask
	str r3, [r2, #CRH_offset]

	ldr r3, [r2, #ODR_offset]			@ load output data register

	loop:
		eor r3, r3, LED_mask			@ toggle LED
		str r3, [r2, #ODR_offset] 
		ldr r4, =2000000
	delay:								@ wait
		subs r4, r4, #1
		bne delay

		b loop
