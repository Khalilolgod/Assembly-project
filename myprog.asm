%include "asm_io.inc"

segment .data
msg1: db "1- Fill out matrix A",0
msg2: db "2- Fill out matrix B",0
msg3: db "3- A = A * B",0
msg4: db "4- B = A * B",0
msg5: db "5- A = B * A",0
msg6: db "6- B = B * A",0
msg7: db "7- Swap (A,B)",0
msg8: db "8- A = B",0
msg9: db "9- B = A",0
msg10: db "10- Print A",0
msg11: db "11- Print B",0
msg0: db "0- Exit",0

invalid_input: db "invalid input",0

l1: db "getting A matrix axis (y*x)",0
l2: db "Enter y : ",0
l3: db "Enter x : ",0 
l4: db "getting input for matrix ",0
l5: db "matrix A not initialized",0
l6: db "matrix B not initialized",0
l7: db "invalid axis for multlipication ",0

; A: dd 1,2,3,4,5,6
; B: dd 2,4,6,8,10,12
sum: dd 2


A_y: dd 0
A_x: dd 0
B_y: dd 0
B_x: dd 0


segment .bss
A: resd 625
B: resd 625

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






	call menu




; ;	prints A 
; 	mov eax,[B_x]
; 	push eax
; 	mov eax,[B_y]
; 	push eax
; 	push B
; 	call print_matrix

	; ;prints Tmp 
	; mov eax,[Tmp_x]
	; push eax
	; mov eax,[Tmp_y]
	; push eax
	; push Tmp
	; call print_matrix



	popa
	leave
	ret

print_menu:
	push msg1
	call print
	push msg2 
	call print
	push msg3 
	call print
	push msg4 
	call print
	push msg5 
	call print
	push msg6 
	call print
	push msg7 
	call print
	push msg8 
	call print
	push msg9 
	call print
	push msg10 
	call print
	push msg11 
	call print
	push msg0 
	call print
	ret

menu:
	call print_nl
	call print_menu
read:
	call read_int
	cmp eax,0
	jl bad_input
	cmp eax,11
	jg bad_input
	cmp eax, 0
	je end_process
	cmp eax,1
	je getinput_A
	cmp eax,2
	je getinput_B
	cmp eax,3
	je a_mult_ab
	cmp eax,4
	je  b_mult_ab
	cmp eax,5
	je  a_mult_ba
	cmp eax,6
	je  b_mult_ba
	cmp eax,7
	je Swap
	cmp eax,8
	je A_equals_B
	cmp eax,9
	je B_equals_A
	cmp eax,10
	je print_A
	cmp eax,11
	je print_B
bad_input:
	push invalid_input
	call print
	jmp read

end_process:
	ret
getinput_A:
	push l1
	call print

	mov eax,l2
	call print_string

	call read_int
	mov [A_y],eax
	

	mov eax,l3
	call print_string

	call read_int
	mov [A_x],eax

	call print_nl
	push l4
	call print

	mov eax,[A_x]
	push eax
	mov eax,[A_y]
	push eax
	push A
	call get_matrix
	jmp menu

print_A:
	
	call checkA
	cmp eax,0
	je menu

	mov eax,[A_x]
	push eax
	mov eax,[A_y]
	push eax
	push A
	call print_matrix
	jmp menu

getinput_B:

	push l1
	call print

	mov eax,l2
	call print_string

	call read_int
	mov [B_y],eax
	

	mov eax,l3
	call print_string

	call read_int
	mov [B_x],eax

	call print_nl
	push l4
	call print

	mov eax,[B_x]
	push eax
	mov eax,[B_y]
	push eax
	push B
	call get_matrix
	jmp menu

print_B:

	call checkB
	cmp eax,0
	je menu

	mov eax,[B_x]
	push eax
	mov eax,[B_y]
	push eax
	push B
	call print_matrix
	jmp menu

A_equals_B:

	call checkB
	cmp eax,0
	je menu

	push B_x
	push B_y
	push A_x
	push A_y
	push B
	push A
	call copyTo
	jmp menu
B_equals_A:

	call checkA
	cmp eax,0
	je menu

	push A_x
	push A_y
	push B_x
	push B_y
	push A
	push B
	call copyTo
	jmp menu

a_mult_ab:
	; mult(A,B,Ax,Ay,Bx)
	;A*B

	call checkA
	cmp eax,0
	je menu

	call checkB
	cmp eax,0
	je menu

	call checkMultAB
	cmp eax,0
	je menu

	push dword [B_x]
	push dword [A_y]
	push dword [A_x]
	push B
	push A
	call multMat
	
	push Tmp_x
	push Tmp_y
	push A_x
	push A_y
	push Tmp
	push A
	call copyTo
	jmp menu

b_mult_ab:

	call checkA
	cmp eax,0
	je menu

	call checkB
	cmp eax,0
	je menu

	call checkMultAB
	cmp eax,0
	je menu

	push dword [B_x]
	push dword [A_y]
	push dword [A_x]
	push B
	push A
	call multMat
	
	push Tmp_x
	push Tmp_y
	push B_x
	push B_y
	push Tmp
	push B
	call copyTo
	jmp menu

a_mult_ba:

	call checkA
	cmp eax,0
	je menu

	call checkB
	cmp eax,0
	je menu

	call checkMultBA
	cmp eax,0
	je menu

	push dword [A_x]
	push dword [B_y]
	push dword [B_x]
	push A
	push B
	call multMat
	
	push Tmp_x
	push Tmp_y
	push A_x
	push A_y
	push Tmp
	push A
	call copyTo
	jmp menu

b_mult_ba:

	call checkA
	cmp eax,0
	je menu

	call checkB
	cmp eax,0
	je menu

	call checkMultBA
	cmp eax,0
	je menu

	push dword [A_x]
	push dword [B_y]
	push dword [B_x]
	push A
	push B
	call multMat
	
	push Tmp_x
	push Tmp_y
	push B_x
	push B_y
	push Tmp
	push B
	call copyTo
	jmp menu

checkA:
	cmp dword [A_x],0
	je printInitA
	cmp dword [A_y],0
	jne endCheckA
printInitA:
	push l5
	call print
	mov eax,0
	ret
endCheckA:
	mov eax,1
	ret
	
checkB:
	cmp dword [B_x],0
	je printInitB
	cmp dword [B_y],0
	jne endCheckB
printInitB:
	push l6
	call print
	mov eax,0
	ret
endCheckB:
	mov eax,1
	ret

checkMultAB:
	mov eax,[A_x]
	cmp eax,dword [B_y]
	jne ABerror
	mov eax,1
	ret
ABerror:
	call printAxisError
	mov eax,0
	ret

checkMultBA:
	mov eax,[B_x]
	cmp eax,dword [A_y]
	jne BAerror
	mov eax,1
	ret
BAerror:
	call printAxisError
	mov eax,0
	ret


printAxisError:
	push l7
	call print
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


Swap:
	
	call checkA
	cmp eax,0
	je menu

	call checkB
	cmp eax,0
	je menu

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

	jmp menu

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
	call print_nl

	mov ESP, EBP
	pop EBP
	ret 4
	