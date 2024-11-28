; Booting our program on a standard 1.44 MB Floppy Disk where one sector has 512 bytes 
; The code will be located at memory address 0x7C00: The standard location where BIOS loads bootloaders from bootable storage devices
org 0x7C00 ; BIOS always puts our operating system at address 0x7C00 --> Give our assembler this information. (See line 4: https://github.com/joeangel/linux-0.0.1/blob/master/boot/boot.s)
bits 16 ; directive; code should be assembled for a 16-bit  mode (real mode, present on all x86 processes, see https://wiki.osdev.org/Real_Mode#:~:text=Real%20Mode%20is%20a%20simplistic,begin%20execution%20in%20Real%20Mode.)

; y'know how C++ has endl like cout << "lol" << ****endl****; ?? Well, why not just use a NASM's define directive to name a symbol ENDL
; 0x0D is the carriage return and 0x0A is the line feed; both use the power of friendship to make "\n", which is slang for new line in computer lingo
; this is just for convenience anyhoo
%define ENDL 0x0D, 0x0A 

; so the program kinda starts here so we want to instruct the little guy to jump to our main label
start:
    jmp main


puts:
    push si ; source index register (used for string operations, memory tasks, etc) pushes onto the stack
    push ax ; accumulator register (bro does arithmetic operations ☠️☠️) pushes onto the stack
    push bx ; base register (storing addresses for data access) pushes onto the stack

; some magic to display a string of characters onto the stream
.loop:
    lodsb               
    or al, al ; is al zero? 0x00 = 0x00 ? if it is zero, zero flag is set, which will check if we've reached the null terminator           
    jz .done ; reached the null terminator? jump to .done label :)

    mov ah, 0x0E  ; another magic code for teletype output, sets up ah register to specify what want to display on the screen    
    mov bh, 0    
    int 0x10 ; we were taught in school not to interrupt yet here we are interrupting the video services

    jmp .loop ; and so shall we loop to the next character of our string

.done:
    pop bx ; pop it! back you go onto the bx register
    pop ax ; pop it! back you go onto the ax register
    pop si ; pop it! back you go onto the si register    
    ret ; oki return
    
main:
    mov ax, 0          
    mov ds, ax
    mov es, ax
    
    mov ss, ax
    mov sp, 0x7C00      

    mov si, msg_skibidi
    call puts

    hlt

.halt:
    jmp .halt



msg_skibidi: db 'spit on that thang', ENDL, 0 ; yup, it's all over the screen


times 510-($-$$) db 0
dw 0AA55h