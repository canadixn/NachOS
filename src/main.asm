; Booting our program on a standard 1.44 MB Floppy Disk where one sector has 512 bytes 
; The code will be located at memory address 0x7C00: The standard location where BIOS loads bootloaders from bootable storage devices
org 0x7C00 ; BIOS always puts our operating system at address 0x7C00 --> Give our assembler this information. (See line 4: https://github.com/joeangel/linux-0.0.1/blob/master/boot/boot.s)
bits 16 ; directive; code should be assembled for a 16-bit  mode (real mode, present on all x86 processes, see https://wiki.osdev.org/Real_Mode#:~:text=Real%20Mode%20is%20a%20simplistic,begin%20execution%20in%20Real%20Mode.)


main: ; holy skibidi
    hlt ; halts the processor (from executing)

.halt: 
    jmp .halt

times 510-($-$$) db 0 ; Padding to 510 bytes; reserving two for the boot signature

dw 0AA55h ; Boot signature. dw defines a word (16-bit value). 0xAA55 (magic number), boot signature required for the BIOS to recognize this sector as bootable. THIS SIGNALS TO THE BIOS THAT THIS IS A VALID BOOTLOADER!

