//******************************************************************************
//* File:  main.c
//* Date:  13.2.2021
//* Author:  Kristian Slehofer
//* Course:  B3B38VSY - Department of Measurement
//* Brief: Simple LED blink example demonstrating use of Assembly procedures
//*        inside C program. Toggles LED connected to PC13 on BluePill board.
//* ----------------------------------------------------------------------------
//* 
//******************************************************************************
#include "stm32f1xx.h"

void ASM_led_blink(void);
void C_led_blink(void);
void wait(int cycles);
void GPIO_init(void);


int main(void)
{
  GPIO_init();
  while (1)
  {
    ASM_led_blink();
    wait(1000000);
    C_led_blink();
    wait(1000000);
  }

}


void C_led_blink(void) {
  GPIOC->ODR ^= GPIO_ODR_ODR13;
  return;
}

void wait(int cycles) {
  for(int i = cycles; i > 0; i--) {
    __NOP();
  }
  return;
}

void GPIO_init(void) {
  RCC->APB2ENR |= RCC_APB2ENR_IOPCEN;     // enable clock gate C
  GPIOC->CRH |= GPIO_CRH_MODE13_1;        // set PC13 as output
  return;
}
