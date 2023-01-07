;# Sa se implementeze un program care sa calculeze functia f(x) = 2g(x), unde g(x) = x + 1.
.data
x: .space 4

fs1: .asciz "%ld"
print: .asciz "%ld\n"
.text
f: ;#8(%ebp) = x ; f(x) = 2g(x)
pushl %ebp
movl %esp, %ebp

push 8(%ebp)
call g ;# rezultatul va fi in eax
addl $4, %esp

movl $2, %edx
mull %edx

pop %ebp
ret

g: ;# 8(%ebp) = y ;# g(X) = x + 1
pushl %ebp
movl %esp, %ebp

addl $1, 8(%ebp)
movl 8(%ebp), %eax

pop %ebp
ret
.global main
main:
pushl $x
pushl $fs1
call scanf
addl $8, %esp

pushl x
call f ;# rez in eax
popl %ebx

pushl %eax
pushl $print
call printf
addl $8, %esp

push $0
call fflush
pop %ebx
exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80 
