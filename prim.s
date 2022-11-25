.data
n: .space 4
cit: .asciz "%ld"
gre: .asciz "Numarul nu este prim\n"
cor: .asciz "Numarul este prim\n"
.text
.global main
main:

pushl $n
pushl $cit
call scanf
popl %ebx
popl %ebx

movl $2, %ecx
for:
    cmp n, %ecx
    je corect

    movl n, %eax
    xorl %edx,%edx
    div %ecx
    cmp $0, %edx
    je gresit

    incl %ecx
    jmp for

corect:
pushl $cor
call printf
popl %ebx
jmp exit

gresit:
pushl $gre
call printf
popl %ebx
exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80
