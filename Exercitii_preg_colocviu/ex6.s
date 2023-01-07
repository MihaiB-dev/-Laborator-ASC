;#void proc(long x) {
;#printf("\%ld ",x);
;#if (x != 0)
;#proc(x-1);
;#}
.data
x: .space 4

fs1: .asciz "%ld"
fsproc: .asciz "\%ld "
.text
proc: ;# 8(%ebp) = x
pushl %ebp
movl %esp, %ebp

pushl 8(%ebp)
pushl $fsproc
call printf
addl $8, %esp

movl 8(%ebp), %ecx
cmp $0, %ecx
je exit_proc
decl 8(%ebp)
pushl 8(%ebp) ;# push the current number
addl $4, %esp ;# take out the last number
pop %ebp
jmp proc ;# go again
exit_proc:
pop %ebp
ret
.global main
main:
pushl $x
push $fs1
call scanf
addl $8, %esp

pushl x
call proc
addl $4, %esp

pushl $0
call fflush
pop %ebx
exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80
