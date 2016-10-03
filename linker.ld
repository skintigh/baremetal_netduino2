ENTRY(_Reset)
SECTIONS
{
 . = 0x0;
 .text : {
  startup.o (INTERRUPT_VECTOR)
  *(.text)
 }
 .data : { *(.data) }
 .bss : { *(.bss COMMON) }
 . = ALIGN(8);
 stack_top = 0x20010000;
}
