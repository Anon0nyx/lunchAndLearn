.386
.MODEL flat

.DATA
	foo DW 12

.CODE
_main PROC

	mov eax, 5h
	push eax ; -4 from ESP
	call foobar
	
	jmp kill
	
	foobar:
		; Function start
		push ebp ; -4 from ESP every time we push, +4 when pop
		mov ebp, esp ; Saving our stack pointer for when we need to leave the function
		sub esp, 10h ; making room for four 4-byte local variable, this variable will be referenced
		             ; by ebp because ebp holds the original stack, these 16-bytes are now before 
					 ; any stack that could be created during this function. If we want to access it we
					 ; do so by referencing [ebp-index], for example [ebp-8] will hold the second variable
					 ; [ebp-C] will hold the second, and so on
		push ebx ; This variable is modified within the function so we want to save it
		push ecx ; Same with this variable
		
		
		mov ebx, [ebp+8h] ; ebp becomes our reference to paramaters passed as it holds the
		                  ; original stack pointer address when we entered the function
						  ; Here we are moving the value passed into the stack into ebx
		mov ecx, ebx
		mov [ebp-4h], ecx ; Making use of the first blank space in the stack
		mov ecx, 2h
		mov ebx, 3h
		imul ecx, ebx
		mov [ebp-8h], ecx ; Using the second blank stack slot to store local value
		push [foo]
		pop [ebp-12]
		
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