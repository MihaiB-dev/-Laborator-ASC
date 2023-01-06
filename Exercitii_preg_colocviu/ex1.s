;#(a) Sa se defineasca procedura perfect(x), cu x numar natural. Un numar este perfect daca
;#este egal cu suma divizorilor sai pana la jumatate. Exemplu: 6 = 1 + 2 + 3; 28 = 1 + 2
;#+ 4 + 7 + 14;
;#(b) Se dau de la tastatura un intreg n si un vector cu n elemente. Sa se afiseze pe ecran
;#numarul de elemente perfecte.
.data
n: .space 4 ;# nr in vector
x: .space 4 ;#val din vector
vector: .space 400
suma_el_perfecte: .long 0

fs1: .asciz "%ld"
print: .asciz "%ld\n"
.text
perfect: ;# 8(%ebp) = numarul x ; -4(%ebp) = suma ; -8(%ebp) = x/2
pushl %ebp
movl %esp, %ebp

subl $8, %esp ;# spatiu pentru suma

movl $1, -4(%ebp)

;#calculam jumatatea unui numar
movl 8(%ebp), %eax
xorl %edx, %edx
movl $2, %ecx
divl %ecx 
movl %eax, -8(%ebp)

movl $2, %ecx
for_perfect:
    cmp -8(%ebp), %ecx
    ja exit_for_perfect

    movl 8(%ebp), %eax
    xorl %edx, %edx
    divl %ecx

    cmp $0, %edx
    jne continue

    addl %ecx, -4(%ebp)
    continue:
    incl %ecx
    jmp for_perfect
exit_for_perfect:
;#verificam daca este perfect ; 1 - Da, 0 - Nu 
movl $0, %eax
movl -4(%ebp), %ecx
cmp 8(%ebp), %ecx
jne exit_perfect
movl $1, %eax

exit_perfect:
addl $8, %esp
pop %ebp
ret
.global main
main:
;#citesc n 
pushl $n
pushl $fs1
call scanf
popl %ebx
popl %ebx

;#creez vectorul
xorl %ecx, %ecx
lea vector, %edi
for_citire:
    cmp n,%ecx
    je exit_for_citire

    pusha
    pushl $x
    pushl $fs1
    call scanf
    popl %ebx
    popl %ebx
    popa
    movl x, %eax
    movl %eax, (%edi,%ecx,4)

    incl %ecx
    jmp for_citire
exit_for_citire:

;#contorizam cate numere sunt perfecte
xorl %ecx, %ecx
for_contor:
    cmp n,%ecx
    je exit_contor
    push %ecx
    movl (%edi, %ecx, 4), %ebx ;# ebx este numarul curent
    pushl %ebx
    call perfect
    popl %ebx

    cmp $1, %eax
    jne continue_contor

    incl suma_el_perfecte
    continue_contor:
    pop %ecx
    incl %ecx
    jmp for_contor
exit_contor:

;#print contor
push suma_el_perfecte
push $print
call printf
pop %ebx
pop %ebx

exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80