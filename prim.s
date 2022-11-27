;# sa se verific e daca numarul este prim
.data
n: .space 4
cit: .asciz "%ld"
gre: .asciz "Numarul nu este prim\n"
cor: .asciz "Numarul este prim\n"
.text
.global main
main:

;# citim numarul de la tastatura
pushl $n
pushl $cit
call scanf
popl %ebx
popl %ebx

movl $2, %ecx ;
for: ;# for(ecx = 2, ecx < n, ecx ++)
    cmp n, %ecx
    je corect #daca nu iese din loop e corect

    movl n, %eax
    xorl %edx,%edx
    div %ecx
    
    cmp $0, %edx
    je gresit 
    ;#daca %eax/%ecx are restul 0 atunci NU e prim
    
    incl %ecx
    jmp for

corect:
pushl $cor ;# "Numarul este prim\n"
call printf
popl %ebx
jmp exit

gresit:
pushl $gre ;# "Numarul nu este prim\n"
call printf
popl %ebx

exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80
