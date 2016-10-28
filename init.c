volatile unsigned int * const USART1_PTR = (unsigned int *)0x40011004;
volatile unsigned int * const USART2_PTR = (unsigned int *)0x40004404;
volatile unsigned int * const USART3_PTR = (unsigned int *)0x40004804;
volatile unsigned int * const UART4_PTR = (unsigned int *)0x40004c04;
volatile unsigned int * const UART5_PTR = (unsigned int *)0x40005004;
volatile unsigned int * const USART6_PTR = (unsigned int *)0x40011404;

void display(const char *string, volatile unsigned int * uart_addr)//write stuff to UART address
{
  while(*string != '\0'){
    *uart_addr = *string;
    string++;
  }
}

void hex_to_str(int val, volatile unsigned int * uart_addr)//write an integer in hex text to a UART
{
  unsigned int pos;
  char c;

  pos = 32;
  while(1)
  {
	pos -= 4;
	c = (val >> pos) & 0xF;
	if  (c>9) c += 0x37;
	else c += 0x30;
    *uart_addr = c;
	if (pos == 0) break;
  }
  *uart_addr = 0x20;
}
 
int my_init(){
  display("1\n", USART1_PTR);
  display("2\n", USART2_PTR);
  display("3\n", USART3_PTR);
  display("4\n", UART4_PTR);
  display("5\n", UART5_PTR);
  display("6\n", USART6_PTR);


  //dump all addrs to UART 1 as sanity check
  hex_to_str((int)USART1_PTR, USART1_PTR);
  hex_to_str((int)USART2_PTR, USART1_PTR);
  hex_to_str((int)USART3_PTR, USART1_PTR);
  hex_to_str((int)UART4_PTR, USART1_PTR);
  hex_to_str((int)UART5_PTR, USART1_PTR);
  hex_to_str((int)USART6_PTR, USART1_PTR);
  display("\n", USART1_PTR);
}
