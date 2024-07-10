section .data
file1 db 'file1.txt', 0  ; The source file name
file2 db 'file2.txt', 0  ; The destination file name

section .bss
buffer resb 1024         ; Buffer to hold file content

section .text
global main              ; Declare the entry point

main:
    ; Open file1.txt for reading
    mov eax, 5           ; sys_open
    mov ebx, file1       ; Pointer to the file name
    mov ecx, 0           ; Read-only flag
    int 0x80             ; Kernel interrupt
    push eax             ; Save file descriptor for file1.txt on stack

    ; Read from file1.txt
    mov eax, 3           ; sys_read
    pop ebx              ; Retrieve file descriptor for file1.txt from stack
    mov ecx, buffer      ; Pointer to the buffer
    mov edx, 1024        ; Number of bytes to read
    int 0x80             ; Kernel interrupt
    push eax             ; Save number of bytes read on stack

    ; Open file2.txt for writing
    mov eax, 5           ; sys_open
    mov ebx, file2       ; Pointer to the file name
    mov ecx, 577         ; Flags for writing, creating, truncating
    mov edx, 0666        ; Permission flags
    int 0x80             ; Kernel interrupt
    push eax             ; Save file descriptor for file2.txt on stack

    ; Write to file2.txt
    mov eax, 4           ; sys_write
    pop ebx              ; File descriptor for file2.txt
    pop ecx              ; Retrieve number of bytes to write from stack
    mov edx, ecx         ; Number of bytes to write
    mov ecx, buffer      ; Pointer to the buffer
    int 0x80             ; Kernel interrupt

    ; Close file2.txt
    mov eax, 6           ; sys_close
    mov ebx, ecx         ; File descriptor for file2.txt
    int 0x80             ; Kernel interrupt

    ; Return from main
    mov eax, 1           ; Exit system call
    xor ebx, ebx         ; Return code 0
    int 0x80             ; Kernel interrupt
