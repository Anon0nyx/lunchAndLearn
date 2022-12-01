.386
.MODEL flat

.CODE
_main PROC

mov ebx, 3h
mov eax, 2h
add eax, ebx
cmp eax, 5h
jne endProc
je callFunc

endProc:
	ret

callFunc:
	push eax
	call firstFunction
	add esp, 4h
	jmp endProc

firstFunction:
	mov ecx, 9h
	jmp foobar

	foobar:
		pop eax
		mov eax, 3h
		mov ebx, 2h
		add eax, ebx
		mov edx, eax
	loop foobar
	ret

_main ENDP

END _main