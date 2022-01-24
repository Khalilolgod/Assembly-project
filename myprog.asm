%include "asm_io.inc"

segment .data
l1: db "getting A matrix axis (y*x)",0
l2: db "Enter y : ",0
l3: db "Enter x : ",0 
l4: db "getting input for matrix ",0
A: dd 1,2,3,4,5,6
B: dd 2,4,6,8,10,12
sum: dd 2


A_y: dd 2
A_x: dd 3
B_y: dd 3
B_x: dd 2


segment .bss
; A: resd 625
; B: resd 625

; A_y: resd 1
; A_x: resd 1
; B_y: resd 1
; B_x: resd 1

Tmp: resd 20
Tmp_x: resd 1
Tmp_y: resd 1

segment .text

global asm_main

asm_main:
	enter 0,0
	pusha

	; push l1
	; call print
	; call print_nl

	; push l2
	; call print

	; call read_int
	; mov [A_y],eax
	

	; push l3
	; call print

	; call read_int
	; mov [A_x],eax

	; call print_nl
	; push l4
	; call print
	; call print_nl

	; mov eax,[A_x]
	; push eax
	; mov eax,[A_y]
	; push eax
	; push A
	; call get_matrix

; ;	copies B to A
; 	push B_x
; 	push B_y
; 	push A_x
; 	push A_y
; 	push B
; 	push A
; 	call copyTo



	; call swap

	; mult(A,B,Ax,Ay,Bx)
	;A*B

	push dword [B_x]
	push dword [A_y]
	push dword [A_x]
	push B
	push A
	call multMat




;	prints A 
	mov eax,[A_x]
	push eax
	mov eax,[A_y]
	push eax
	push A
	call print_matrix


;	prints A 
	mov eax,[B_x]
	push eax
	mov eax,[B_y]
	push eax
	push B
	call print_matrix

	;prints Tmp 
	mov eax,[Tmp_x]
	push eax
	mov eax,[Tmp_y]
	push eax
	push Tmp
	call print_matrix



	popa
	leave
	ret

multMat:
	push EBP
	mov EBP, ESP

	mov eax,[EBP+20]
	mov [Tmp_y],eax

	mov eax,[EBP+24]
	mov [Tmp_x],eax

	mov ecx,[Tmp_y]
multL1:
	mov esi,0

	mov eax,[Tmp_y]
	sub eax,ecx
	mov ebx,[Tmp_x]
	mul ebx
	lea eax, [4*eax]
	mov ebx,eax
	multL2:

		lea eax,[ebx + 4*esi]
		add eax,Tmp
		mov [sum],eax

		mov edi,0
		multL3:
			mov eax,[Tmp_x]
			mul edi
			mov edx,4
			mul edx
			lea edx,[4*esi+eax]
			add edx,[EBP+12]
			mov edx,[edx]
			push edx

			mov eax,[Tmp_y]
			sub eax,ecx
			mul dword [EBP+16]
			lea eax,[eax*4]
			lea eax,[4*edi+eax]
			add eax,[EBP+8]
			mov eax,[eax]

			pop edx
			mul edx			
			
			mov edx,[sum]
			mov edx,[edx]
			add eax,edx
			
			mov edx,[sum]
			mov [edx],eax


			inc edi
			cmp edi,[EBP+16]
			jl multL3


		inc esi 
		cmp esi,[Tmp_x]
		jl multL2
	dec ecx
	jnz multL1
	mov ESP, EBP
	pop EBP
	ret 20 


swap:
	
	push A_x
	push A_y
	push Tmp_x
	push Tmp_y
	push A
	push Tmp
	call copyTo

	
	push B_x
	push B_y
	push A_x
	push A_y
	push B
	push A
	call copyTo

	push Tmp_x
	push Tmp_y
	push B_x
	push B_y
	push Tmp
	push B
	call copyTo

	ret

copyTo:
	mov eax, [esp+24]
	mov eax, [eax]
	mov ebx,[esp+16]
	mov [ebx],eax

	mov eax, [esp+20]
	mov eax, [eax]
	mov ebx,[esp+12]
	mov [ebx],eax
	
	mov ecx,[esp+12]
	mov ecx,[ecx]
loop111:
	mov esi,0

	mov eax,[esp+12]
	mov eax,[eax]
	sub eax,ecx
	mov ebx,[esp+16]
	mov ebx,[ebx]
	mul ebx
	lea eax, [4*eax]
	mov ebx,eax
	loop222:
		lea eax,[ebx + 4*esi]
		mov edx,eax
		add edx,[esp+4]
		add eax,[esp+8]

		mov eax,[eax]
		mov [edx],eax

		inc esi
		mov eax,[esp+16]
		cmp esi,[eax]
	jl loop222
	
loop loop111
	ret 24

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
	