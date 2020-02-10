data segment 
    cr equ 0dh
    lf equ 0ah
    string1 db 'Enter nummer[1]: $'
    string2 db cr,lf,'Enter number[2]: $'
    string3 db cr,lf,'Summation: $'
    num db ?
data ends

code segment 
    assume cs:code, ds:data
    
start:  
    mov ax, data
    mov ds,ax
;print 1st string
    mov ah,09h
    mov dx, offset string1
    int 21h
;read first number 
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
    mov dh,00
    mov dl,num   
;print 2nd string
    mov ah,09h
    mov dx, offset string2
    int 21h
;read the second number and summing it
    mov ah,01h
    int 21h
    sub al,'0'
    mov bl,0ah
    mul bl
    add num,al
    mov ah,01h 
    int 21h
    sub al,'0'
    add num,al
;print 3rd string
    mov ah,09h
    mov dx, offset string3
    int 21h   
;print that number  
    mov cx,00
print:
    mov ah,00
    mov al,num
    mov dx,00h
    mov bl,0ah
    div bl 
    mov num,al
    mov dl,ah 
    add dl,'0'
    mov dh,0
    push dx
    inc cx
    cmp num,0
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
    
    
