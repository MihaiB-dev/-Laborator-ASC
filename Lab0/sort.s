;# sa se ordoneze crescator sirul
.data
n: .space 4
a: .space 4
sir: .space 800
cit_un_numar: .asciz "%ld"
print: .asciz "%ld "
endline: .asciz "\n"
.text

.global main
main:
;#
pushl $n
pushl $cit_un_numar
call scanf
popl %ebx
popl %ebx

lea sir, %esi
xorl %ecx, %ecx
for_citire:
    cmp n, %ecx
    je exit_for_citire

    pusha
    pushl $a
    pushl $cit_un_numar
    call scanf
    popl %ebx
    popl %ebx
    popa

    movl a, %eax
    movl %eax, (%esi, %ecx, 4)
    incl %ecx
    jmp for_citire
exit_for_citire:


xorl %ecx, %ecx
lea sir, %esi
loop:
      ;# ecx este 0, 1, 2, 3, 4

    cmp n, %ecx
    je end_loop

    movl %ecx, %ebx
    loop_j:
        incl %ebx

        cmp n, %ebx ;#daca ebx este 5
        je exit_j

        movl (%esi, %ecx, 4), %eax
        movl (%esi, %ebx, 4), %edx

        
        cmp %eax, %edx
        jge loop_j

        movl %edx, (%esi, %ecx, 4)
        movl %eax, (%esi, %ebx, 4)   ;# swap

        jmp loop_j 
    exit_j:

incl %ecx
jmp loop
end_loop:

lea sir, %esi
xorl %ecx, %ecx
for_print:
    cmp n, %ecx
    je exit

    movl (%esi, %ecx,4), %ebx

    pusha
    pushl %ebx
    pushl $print
    call printf
    popl %eax
    popl %eax
    popa

    incl %ecx
jmp for_print

exit:
pushl $endline
call printf
popl %ebx
movl $1, %eax
xorl %ebx, %ebx
int $0x80
