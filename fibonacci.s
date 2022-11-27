#Se dă un şir cu n elemente, numere naturale care se salveaza intr-un vector. Să se afişeze elementele şirului care sunt termeni ai şirului lui Fibonacci.
.data
a: .long 1
b: .long 1
c: .long 0
n: .space 4
x: .space 4
sir: .space 404
cit_un_numar: .asciz "%ld"
print: .asciz "%ld "
end: .asciz "\n"
.text
.global main
main:

pushl $n
pushl $cit_un_numar
call scanf
popl %ebx
popl %ebx

xorl %ecx, %ecx
lea sir, %edi

for_citire:
    cmp n, %ecx
    je exit_for_citire

    pusha
    pushl $x
    pushl $cit_un_numar
    call scanf
    popl %ebx
    popl %ebx
    popa

    movl x, %eax
    movl %eax, (%edi, %ecx, 4)
    incl %ecx
    jmp for_citire
exit_for_citire:

xorl %ecx, %ecx
while: ;# while(ecx!=n)
    cmp n, %ecx
    je exit
    movl (%edi, %ecx, 4), %edx
    movl %edx, x ;# x = sir[ecx]

    while_mic: ;# while(a<x)
        movl x, %eax
        cmp a, %eax
        jl exit_while_mic

        ;# c = b
        movl b, %edx
        movl %edx, c

        ;# b = a+b
        movl a, %edx
        add %edx,b

        ;# a = c
        movl c, %edx
        movl %edx, a

        ;# daca nu e fibonacci => exit
        cmp a, %eax
        jne while_mic

        ;#print the correct values
        pusha
        pushl x
        pushl $print
        call printf
        popl %ebx
        popl %ebx
        popa

    exit_while_mic:
    
    incl %ecx

    ;#resetam valorile din a, b, c
    movl $1, %eax
    movl $1, %ebx
    xorl %edx, %edx

    movl %eax, a
    movl %ebx, b
    movl %edx, c

    jmp while
exit_while:



exit:
pushl $end
call printf
popl %ebx

movl $1,%eax
xorl %ebx,%ebx
int $0x80
