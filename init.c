volatile unsigned char * const USART1_PTR = (unsigned char *)0x40011000;
volatile unsigned char * const USART2_PTR = (unsigned char *)0x40004400;
volatile unsigned char * const USART3_PTR = (unsigned char *)0x40004800;
volatile unsigned char * const UART4_PTR = (unsigned char *)0x40004c00;

void display(const char *string, volatile unsigned char * uart_addr){
  while(*string != '\0'){
    *(uart_addr+4) = *string;
    string++;
  }
}
 
int my_init(){
  display("Test 1/4\n", USART1_PTR);
  display("Test 2/4\n", USART2_PTR);
  display("Test 3/4\n", USART3_PTR);
  display("Test 4/4\n", UART4_PTR);
}
