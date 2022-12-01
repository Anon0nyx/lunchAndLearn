.386
.MODEL flat

.CODE
_main PROC

	mov eax, 5h
	push eax ; -4 from ESP
	call foobar
	
	jmp kill
	
	foobar:
		; Function start
		push ebp ; -4 from ESP
		mov ebp, esp ; Saving our stack pointer for when we need to leave the function
		sub esp, 4 ; making room for one 4-byte local variable
		push ebx ; This variable is modified within the function so we want to save it
		push ecx ; Same with this variable
		
		mov ebx, [ebp+8]
		mov ecx, ebx
		mov [ebp-4], ecx ; Making use of that blank space in the stack
		
		; Cleanup
		pop ecx ; Putting variables back for function exit
		pop ebx ; set ebx back
		mov esp, ebp ; use saved esp in ebp to put esp back
		pop ebp ; Now that esp is normal, the next value in queue will be ebp 
		ret
	kill:
		retn

_main ENDP

END _main
	