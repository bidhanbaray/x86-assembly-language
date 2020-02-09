datain macro num
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
printstring macro str
    mov ah,09h
    mov dx,offset str
    int 21h
endm

data segment 
    cr equ 0dh
    lf equ 0ah
    str1 db 'Total numbers<XX> : $'
    str2 db cr,lf,'Enter number<XX>: $'
    str3 db cr,lf,'Largest number: $'
    n db ?
    array db 100 dup(0)
    temp db ? 
data ends
code segment 
    assume cs:code,ds:data
start: 
    mov ax,data
    mov ds,ax
    
    printstring str1
    datain n 
    
    mov ch,00
    mov cl,n
    mov si,offset array  
    
    inputnumber:
        printstring str2
        datain temp
        mov al,temp
        mov [si],al
        inc si
        loop inputnumber
    mov ch,00
    mov cl,n
    mov si,offset array 
    mov al,[si] 
    mov temp,al
    
    compareloop:
         inc si 
         dec cx
         cmp cx,00
         jle done
         mov al,temp
         cmp [si],al
         jle compareloop 
         mov al,[si] 
         mov temp,al
         jmp compareloop
done:    
    printstring str3
    print:
        mov ah,00
        mov al,temp 
        mov bl,0ah
        div bl 
        mov temp,al
        mov dl,ah 
        add dl,'0'
        mov dh,0
        push dx
        inc cx
        cmp temp,0
        jg print
        printfromstack:
        pop dx 
        mov ah,02    ;prints what is in the dl
        int 21h 
        loop printfromstack  
    
    
; termination code    
    mov ah,4Ch 
    mov al,00
    int 21h
code ends 
    end start
         