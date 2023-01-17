.data
x: .space 4
contor: .long 0

fs1: .asciz "%ld"
print: .asciz "%ld\n"
.text
f: ;# 8(%ebp) = x curent, %eax = rezultatul
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %ecx
    cmp $1, %ecx ;# if x == 1 stop
    je exit_f

    movl 8(%ebp), %eax ;# x/2
    xorl %edx, %edx
    movl $2, %ecx
    divl %ecx

    cmp $0, %edx ;# if x %2 == 0
    je par

    movl 8(%ebp), %eax ;# 3x + 1
    movl $3, %edx
    mull %edx
    addl $1, %eax

    movl $contor, %edx
    incl 0(%edx)

    pushl %eax
    call f
    addl $4, %esp

    jmp exit_f
    par:
    movl $contor, %edx
    incl 0(%edx)

    pushl %eax ;# x/2
    call f
    addl $4, %esp
    exit_f:
    
    pop %ebp
ret
.global main
main:
pushl $x
pushl $fs1
call scanf
addl $8, %esp

pushl x
call f ;# se apeleaza functia
addl $4, %esp



movl contor, %eax ;#print
pushl %eax
pushl $print
call printf
addl $8, %esp
exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80