#include "stdio.h"
#include "string.h"
#include "stm32f4xx.h"
void printMsg1(const int a)
{
	 char Msg[100];
	 char *ptr;
	 sprintf(Msg, "\n%d", a);
	 ptr = Msg ;
   while(*ptr != '\0'){
      ITM_SendChar(*ptr);
     //printf("shubham"); 
		 ++ptr;
   }
}