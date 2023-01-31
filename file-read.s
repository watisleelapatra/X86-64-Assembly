section .data
; -----
; Define standard constants.
LF 	equ 10 ; line feed
NULL 	equ 0 ; end of string
TRUE 	equ 1
FALSE 	equ 0
EXIT_SUCCESS equ 0 ; success code
STDIN 	equ 0 ; standard input
STDOUT 	equ 1 ; standard output
STDERR 	equ 2 ; standard error
SYS_read equ 0 ; read
SYS_write equ 1 ; write
SYS_open equ 2 ; file open
SYS_close equ 3 ; file clos
SYS_fork equ 57 ; fork
SYS_exit equ 60 ; terminate
SYS_creat equ 85 ; file open/create
SYS_time equ 201 ; get time
O_CREAT equ 0x40
O_TRUNC equ 0x200
O_APPEND equ 0x400
O_RDONLY equ 000000q ; read only
O_WRONLY equ 000001q ; write only
O_RDWR 	equ 000002q ; read and write
S_IRUSR equ 00400q
S_IWUSR equ 00200q
S_IXUSR equ 00100q
; -----
; Variables/constants for main.
BUFF_SIZE 	equ 255
newLine 	db LF, NULL
header 		db LF, "File Read Example."
		db LF, LF, NULL
fileName 	db "url.txt", NULL
fileDescrip 	dq 0
errMsgOpen 	db "Error opening the file.", LF, NULL
errMsgRead 	db "Error reading from the file.", LF, NULL
; -------------------------------------------------------
section .bss
readBuffer 	resb BUFF_SIZE
; -------------------------------------------------------
section .text
global _start
_start:
; -----
; Display header line...
	mov rdi, header
	call printString
; Attempt to open file - Use system service for file open
; System Service - Open
; rax = SYS_open
; rdi = address of file name string
; rsi = attributes (i.e., read only, etc.)
; Returns:
; if error -> eax < 0
; if success -> eax = file descriptor number
; The file descriptor points to the File Control
; Block (FCB). The FCB is maintained by the OS.
; The file descriptor is used for all subsequent file
; operations (read, write, close).
openInputFile:
	mov rax, SYS_open ; file open
	mov rdi, fileName ; file name string
	mov rsi, O_RDONLY ; read only access
	syscall ; call the kernel
	cmp rax, 0 ; check for success
	jl errorOnOpen
	mov qword [fileDescrip], rax ; save descriptor
; -----
; Read from file.
; For this example, we know that the file has only 1 line.
; System Service - Read
; rax = SYS_read
; rdi = file descriptor
; rsi = address of where to place data
; rdx = count of characters to read
; Returns:
; if error -> rax < 0
; if success -> rax = count of characters actually read
	mov rax, SYS_read
	mov rdi, qword [fileDescrip]
	mov rsi, readBuffer
	mov rdx, BUFF_SIZE
	syscall
	cmp rax, 0
	jl errorOnRead
; -----
; Print the buffer.
; add the NULL for the print string
	mov rsi, readBuffer
	mov byte [rsi+rax], NULL
	mov rdi, readBuffer
	call printString
	printNewLine
; -----
; Close the file.
; System Service - close
; rax = SYS_close
; rdi = file descriptor
	mov rax, SYS_close
	mov rdi, qword [fileDescrip]
	syscall
	jmp exampleDone
; -----
; Error on open.
; note, eax contains an error code which is not used
; for this example.
errorOnOpen:
	mov rdi, errMsgOpen
	call printString
	jmp exampleDone
; Error on read.
; note, eax contains an error code which is not used
; for this example.
errorOnRead:
	mov rdi, errMsgRead
	call printString
	jmp exampleDone
; -----
; Example program done.
exampleDone:
	mov rax, SYS_exit
	mov rdi, EXIT_SUCCESS
	syscall
; **********************************************************
; Generic procedure to display a string to the screen.
; String must be NULL terminated.
; Algorithm:
; Count characters in string (excluding NULL)
; Use syscall to output characters
; Arguments:
; 1) address, string
; Returns:
; nothing
global printString
printString:
	push rbp
	mov rbp, rsp
	push rbx
; -----
; Count characters in string.
	mov rbx, rdi
	mov rdx, 0
strCountLoop:
	cmp byte [rbx], NULL
	je strCountDone
	inc rdx
	inc rbx
	jmp strCountLoop
strCountDone:
	cmp rdx, 0
	je prtDone
; -----
; Call OS to output string.
	mov eax, SYS_write ; code for write()
	mov rsi, rdi ; addr of characters
	mov rdi, STDOUT ; file descriptor
; count set above
	syscall ; system call
; -----
; String printed, return to calling routine.
	prtDone:
	pop rbx
	pop rbp
	ret

