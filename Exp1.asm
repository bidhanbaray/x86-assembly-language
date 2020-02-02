readnum macro num
	mov ah,01h
	int 21h
	sub al,'0'
	mov bl,0ah
	mul bl
	mov num,al
	mov ah,01h
	int 21h
	sub al,'0'
	add num,al
	endm
	
printstring macro string 
	mov ah,09h
	mov dx, offset string
	int 21h
	endm

sdata segment 
	cr equ 0dh
	lf equ 0ah
	intro db 'How many numbers you want to add? <XX> : $'
	string1 db cr,lf,'Enter two digit number <xx>: $'
	string2 db cr,lf,'Summation : $'
	ntable db 100 dup(0)
	num db ?
	temp db ?
	result db 20 dup('$')
sdata ends

scode segment 
	assume cs:scode,ds:sdata
	
start:
	mov ax,sdata
	mov ds,ax
	
	printstring intro
	readnum num
	
	mov si,offset ntable
	mov ch,00
	mov cl,num
	
nextread:
	printstring string1
	readnum temp 
	mov al,temp
	mov [si],al
	inc si
	loop nextread 
	
	mov si,offset ntable 
	mov ah,00 
	mov al,[si]
	mov cl,01
	
nextcheck:
	inc si
	cmp cl,num
	je nomore 
	mov bh,00
	mov bl,[si] 
	add ax,bx
	inc cl
	jmp nextcheck
	
nomore: 
	mov si,offset result 
	call hex2asc
	printstring string2 
	printstring result 
	
	mov ah,4ch
	mov al,00h
	int 21h
	
hex2asc proc near 
	push ax 
	push bx
	push cx
	push dx
	push si 
	mov cx,00h
	mov bx,0ah
	
rpt1: 
	mov dx,00 
	div bx 
	add dl,'0'
	push dx 
	inc cx 
	cmp ax,0ah
	jge rpt1 
	add al,'0'
	mov [si], al
	
rpt2:
	pop ax 
	inc si 
	mov [si],al
	loop rpt2 
	
	inc si 
	mov al,'$'
	mov [si], al
	
	pop si 
	pop dx
	pop cx
	pop bx 
	pop ax 
	ret 
hex2asc endp 
scode ends 
	end start 
	
	
	
	