section .text
; Function to find integer sum and integer average
; for a passed list of signed integers.
; Call:
; stats(lst, len, &sum, &ave);
; Arguments Passed:
; 1) rdi - address of array
; 2) rsi - length of passed array
; 3) rdx - address of variable for sum
; 4) rcx - address of variable for average
; Returns:
; sum of integers (via reference)
; average of integers (via reference)
global stats
stats:
	push r12
; Find and return sum.
	mov r11, 0 ; i=0
	mov r12d, 0 ; sum=0
sumLoop:
	mov eax, dword [rdi+r11*4] ; get lst[i]
	add r12d, eax ; update sum
	inc r11 ; i++
	cmp r11, rsi
	jb sumLoop
	mov dword [rdx], r12d ; return sum
; Find and return average.
	mov eax, r12d
	cdq
	idiv esi
	mov dword [rcx], eax ; return average
; Done, return to calling function.
	pop r12
	ret
