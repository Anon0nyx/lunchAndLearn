.386
.MODEL flat

.DATA
	foo DD 5 ; DB = 1 byte
			 ; DW = 2 bytes
			 ; DD = 4 bytes
			 ; DQ = 8 bytes
			 ; DT = 10 bytes

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
					 ; [ebp-C] (or 12) will hold the third, and so on
		push ebx ; This variable is modified within the function so we want to save it
		push ecx ; Same with this variable

		; Instructions to execute for function
		; Grab argument, do addition with it and store the result in the memory created in the stack
		mov ebx, [ebp+8h] ; Here we are moving the value passed into the stack into ebx 
						  ; i.e. the variable passed to the function
						  ; ebp becomes our reference to paramaters passed as it holds the
		                  ; original stack pointer address when we entered the function
		add ebx, 4h
		mov [ebp-4h], ebx ; Making use of the first blank space in the stack
		
		call kill
		
		;  Do some multiplication and store result in special stack memory
		mov ecx, 2h
		mov ebx, 3h
		imul ecx, ebx
		mov [ebp-8h], ecx ; Using the second blank stack slot to store local value
		
		; Grab the global value and store it in ecx
		mov ecx, foo
		mov ebx, 3h

		; Cleanup to reset registers to values held before entering function
		pop ecx ; Putting variables back for function exit
		pop ebx ; set ebx back
		mov esp, ebp ; use saved esp in ebp to put esp back
		pop ebp ; Now that esp is normal, the next value in queue will be ebp (Think about line 29)
		ret
	kill:
		mov esp, ebp
		ret

_main ENDP

END _main