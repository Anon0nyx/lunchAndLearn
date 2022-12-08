.386
.MODEL flat

.DATA 
	; y = mx + b 
	m DD 5
	x DD 20
	b DD 32
	
	; slope = y2 - y1 / x2 - x1 (slope formula)
	yone DD 53
	ytwo DD 3
	xone DD 10
	xtwo DD 3
	
	; 2 ( l + b ) (area of a rectangle)
	l DD 8
	base DD 3

.CODE
_main PROC

mov eax, m
imul eax, x
add eax, b
push eax

mov eax, yone ; store y-one value
sub eax, ytwo ; Subtract second
push eax ; Save this value
mov eax, xone ; Store x-one value
sub eax, xtwo ; subtract second
push eax ; Put our denominator in the stack
pop ebx ; Put our denominator in the denominator spot
pop eax ; Put our divisor in eax as this is what idiv uses by default
mov edx, 0
idiv ebx
push eax
push edx ; Store our quotient and remainder on the stack

mov eax, l
add eax, base
imul eax, 2h
push eax

_main ENDP

END _main