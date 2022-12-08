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

	mov eax, foo

_main ENDP
END _main