;# sa se gaseasca toti divizorii unui numar citit de la tastatura si sa se afiseze
.data
x: .space 4
fs1: .asciz "%ld\n"

.text
.global main
main:
pushl $x
pushl $fs1
call scanf
popl %ebx
popl %ebx

movl $2, %ecx
for:

    cmp %ecx, x
    je exit

    xorl %edx, %edx
    movl x, %eax
    divl %ecx

    cmp $0, %edx
    jne continue

    ;#print the correct number
    pusha
    pushl %ecx
    pushl $fs1
    call printf
    popl %ebx
    popl %ebx
    popa

    continue:
    incl %ecx
    jmp for



exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80
