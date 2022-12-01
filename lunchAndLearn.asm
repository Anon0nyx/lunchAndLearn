.386
.MODEL flat

.CODE
_main PROC

mov eax, 4h
mov ebx, 4h
add eax, ebx
mov ecx, eax
mov ebx, ecx
push ebx

mov ebx, 3h
mov eax, 2h
add eax, ebx
mov ecx, eax
looping:
	add ecx, 1
	dec eax
	cmp eax, 0
	jne looping

pop eax

_main ENDP

END _main