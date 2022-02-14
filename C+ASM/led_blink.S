.syntax unified
.cpu cortex-m3
.thumb

GPIOC_base = 0x40011000
ODR_offset = 0x0C
LED_pin = 13
LED_mask = (1 << LED_pin)

.type main, %function
.global ASM_led_blink
ASM_led_blink:
	ldr r0, =GPIOC_base
	ldr r1, [r0, #ODR_offset]
	eor r1, r1, LED_mask
	str r1, [r0, #ODR_offset] 
	bx lr

