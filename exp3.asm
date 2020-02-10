cin macro x
	push ax
	push bx
	
	mov ah,01h
	int 21h
	sub al,'0'
	mov bl,0ah
	mul bl
	mov x,al
	
	mov ah,01h
	int 21h
	sub al,'0'
	add x,al 
	pop bx
	pop ax
	
	endm

cout macro s
	mov ah,09h
	mov dx, offset s
	int 21h
	endm

data segment 
	cr equ 0dh
	lf equ 0ah 
	tab equ 09h
	string1 db 'Number of elements<XX>: $'
	string2 db cr,lf,'Enter Elements<XX>: $'
	string3 db cr,lf,'Elements in ascending order:',cr,lf,'$'
	
	N db ?
	array db 20 dup(0)
	temp db ?
	tempStr db 4 dup($)
data ends

code segment 
	assume cs:code, ds:data

start:
	mov bx, data
	mov ds, bx
	
	cout string1
	cin N
	
	mov ch,00
	mov cl,N
	mov bx,01
	
readnumbers: 
	cout string2 
	cin temp 
	mov al,temp
	mov array[bx],al
	inc bx
	loop readnumbers
	
;; Bubble Sort ;;
	
	mov ch,00
	mov cl,N
	
	cmp cx,01
	je done	; if there is only one number , no need to sort , job done
	
i: 
	 mov dl,0	; flag = FALSE
	 mov bx,01
	 
	j: 
		mov al,array[bx]
		mov ah,array[bx+1]
		cmp al,ah 
		jle jskip
		mov array[bx+1],al
		mov array[bx],ah 
		mov dl,01	; flag = TRUE
	jskip: 
		inc bx
		cmp bx,cx
		jl j
		dec cx 
		jz done 
		cmp dl,01 ;Flag = TRUE
		je i
done:
	mov ch,00h
	mov cl, N
	mov bx,01
	;mov si,offset temp
	cout string3
printloop:
	mov si,offset tempstr
	mov ah,00
	mov al,array[bx]
	call hex2asc 
	;cout tab,'$'
	cout tempstr  
	
	inc bx
	loop printloop
	
	mov ah,4ch
	mov al,00h
	int 21h
	
; Function to convert Hexadecimal number to ASCII string
; AX – input number
; SI – pointer to result storage area

hex2asc proc near 
	push ax 
	push bx
	push cx
	push dx
	push si
	
	mov cx,00
	mov bx,0ah
	
	loop1: 
		mov dx,00
		div bx 
		add dl,'0'
		push dx 
		inc cx
		cmp ax,0ah
		jge loop1
		add al,'0'
		mov [si],al ; si is the offset address of temp
	loop2:
		pop ax 
		inc si 
		mov [si],al
		loop loop2
		
		inc si 
		mov al,09 
		
		mov [si],al   
		inc si 
		mov al,'$'
		mov [si],al  
		
	pop si
	pop dx
	pop cx 
	pop bx
	pop ax
	ret 
hex2asc endp
code ends
	end start
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	