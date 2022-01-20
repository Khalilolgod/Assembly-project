%include "asm_io.inc"

segment .data
l1: db "getting A matrix axis (y*x)",0
l2: db "Enter y : ",0
l3: db "Enter x : ",0 
l4: db "getting input for matrix ",0
array1: dd 1,2,3,4,5,6,7,8

segment .bss
A: resd 625
B: resd 625

A_y: resd 1
A_x: resd 1
B_y: resd 1
B_x: resd 1

segment .text

global asm_main

asm_main:
	enter 0,0
	pusha

	push l1
	call print
	call print_nl

	push l2
	call print

	call read_int
	mov [A_y],eax
	

	push l3
	call print

	call read_int
	mov [A_x],eax

	call print_nl
	push l4
	call print
	call print_nl

	mov eax,[A_x]
	push eax
	mov eax,[A_y]
	push eax
	push A
	call get_matrix

	mov eax,[A_x]
	push eax
	mov eax,[A_y]
	push eax
	push A
	call print_matrix




	popa
	leave
	ret


get_matrix:
	push EBP
	mov EBP, ESP

	mov ecx, [esp+12]
loop11:
	mov esi,0

	mov eax,[esp+12]
	sub eax,ecx
	mov ebx,[esp+16]
	mul ebx
	lea eax, [4*eax]
	mov ebx,eax
	loop22:

		call read_int
		mov edx,eax
		lea eax,[ebx + 4*esi]
		add eax,[esp+8]
		mov [eax],edx


		inc esi
		cmp esi,[esp+16]
	jl loop22
	call print_nl
	
loop loop11

	mov ESP, EBP
	pop EBP
	ret 12


print_matrix:
	push EBP
	mov EBP, ESP

	mov ecx, [esp+12]
loop1:
	mov esi,0

	mov eax,[esp+12]
	sub eax,ecx
	mov ebx,[esp+16]
	mul ebx
	lea eax, [4*eax]
	mov ebx,eax
	loop2:
		
		lea eax,[ebx + 4*esi]
		add eax,[esp+8]
		mov eax,[eax]

		call print_int
		mov eax,32;space
		call print_char
		inc esi
		cmp esi,[esp+16]
	jl loop2
	call print_nl
	
loop loop1

	mov ESP, EBP
	pop EBP
	ret 12

print:
	push EBP
	mov EBP, ESP

	mov eax,[esp+8]
	call print_string

	mov ESP, EBP
	pop EBP
	ret 4
	