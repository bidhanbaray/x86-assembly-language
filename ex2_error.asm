scanf macro num
	mov ah, 01h
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

printf macro string
	mov ah,09h
	mov dx, offset string
	int 21h
	endm 

datas segment 
	cr equ 0dh
	lf equ 0ah
	string db 'Enter two byte number:$'
	seven db cr,lf,'Even$'
	sodd db cr,lf,'Odd$'
	snotp db cr,lf,'Not prime$'
	sisp db cr,lf,'Prime$'
	x db ? 
datas ends
	
codes segment 
	assume cs:codes, ds:datas
	
start: 
	mov bx,datas
	mov ds,bx
	
	printf string
	scanf x
	mov al,x
	mov ah,00
	mov bl,02
	mov bh,00
	div bx
	cmp dx,00 
	mov bx,ax
	je printeven
	printf sodd
	jmp secondpart

printeven: 
	printf seven
	printf snotp
	jmp skip
	

secondpart:
	mov cl,03
	mov ch,00 
again:
	mov al,x
	mov ah,00
	div cx
	cmp dx,00
	je notprime
	inc cx
	cmp cx,bx
	jle again
	printf sisp
	jmp skip
notprime: 
	printf snotp
skip: 
		mov ah,4ch ; exit to os
		int 21h
codes ends 
	end start
