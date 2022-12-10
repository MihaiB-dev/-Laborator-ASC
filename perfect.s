;# (a) Sa se defineasca procedura perfect(x), cu x numar natural. Un numar este perfect daca
;# este egal cu suma divizorilor sai pana la jumatate. Exemplu: 6 = 1 + 2 + 3; 28 = 1 + 2
;# + 4 + 7 + 14;
;# (b) Se dau de la tastatura un intreg n si un vector cu n elemente. Sa se afiseze pe ecran
;# numarul de elemente perfecte.
.data
n: .space 4
a: .space 4
vector: .space 400
suma: .long 0
citire_numar: .asciz "%ld"
print_suma: .asciz "Numarul de elemente perfecte sunt %ld \n"

.text
perfect:
    pushl %ebp
    movl %esp, %ebp

    pushl %ecx
    pushl %eax
    pushl %edx
    movl $1, %ecx
    movl $1, %ebx
    for_perfect:
        cmp %ecx, 8(%ebp)
        je exit_for_pefect

        movl 8(%ebp), %eax
        xorl %edx, %edx
        divl %ecx

        cmp $0, %edx
        jne continue

        addl %ecx, %ebx

        continue:
        incl %ecx
        jmp for_perfect
        
    exit_for_pefect:
    cmp %ebx, 8(%ebp)
    jne continue1
    movl 12(%ebp), %edx
    addl $1 , 0(%edx)

    continue1:
    popl %edx
    popl %eax
    popl %ecx

    popl %ebp
ret

.global main
main:
pushl $n
pushl $citire_numar
call scanf
popl %ebx
popl %ebx

xorl %ecx, %ecx
lea vector, %edi
for_citire:
    cmp n, %ecx
    je exit_for_citire

    pusha
    pushl $a
    pushl $citire_numar
    call scanf
    popl %ebx
    popl %ebx
    popa

    movl a, %eax
    movl %eax, (%edi, %ecx, 4)
    incl %ecx
    jmp for_citire
exit_for_citire:

xorl %ecx, %ecx
for_verificare:
    cmp %ecx, n
    je exit_for_verificare

    pusha
    pushl suma
    pushl (%edi, %ecx, 4)
    call perfect
    popl %eax
    popl %eax
    popa

    incl %ecx
    jmp for_verificare
exit_for_verificare:



exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80
