;#Sa se implementeze procedura customEven care primeste ca argumente doua numere intregi, x si
;#y astfel incat x · y ≥ 0 si care sa returneze prin intermediul registrului %eax valoarea 1 daca suma
;#cifrelor numarului x · y este para, respectiv 0 daca suma cifrelor numarului x · y este impara.
.data
x: .space 4
y: .space 4

fs1: .asciz "%ld"
print: .asciz "%ld\n"
.text
customEven: ;#8(%ebp) = x, 12(%ebp) = y, -4(%ebp) = suma cifrelor
    pushl %ebp
    movl %esp, %ebp

    pushl %ebx
    subl $4, %esp

    movl 8(%ebp), %eax ;# %eax = x * y
    movl 12(%ebp), %ecx
    mull %ecx


    xorl %ecx, %ecx
 
    movl $0, -4(%ebp)
    for_cifre:
        cmp $0, %eax
        je exit_for_cifre

        movl $10, %ebx
        divl %ebx

        addl %edx, -4(%ebp)

        xor %edx, %edx
        incl %ecx
        jmp for_cifre 
    exit_for_cifre:

    ;#verificam daca suam cifrelor este impara
    movl -4(%ebp), %eax
    and $1, %eax

    addl $4, %esp
    pop %ebx
    popl %ebp
ret
.global main
main:
pushl $x
pushl $fs1
call scanf
addl $8, %esp

pushl $y
pushl $fs1
call scanf
addl $8, %esp

pushl y
pushl x
call customEven
addl $8, %esp

pushl %eax
pushl $print
call printf
addl $8, %esp
exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80