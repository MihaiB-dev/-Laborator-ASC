;# cerinta : Se citesc de la tastatura un numar x, un numar n si apoi un vector cu n numere naturale . 
;# Sa se stocheze in memorie si sa se afiseze pe ecran doar numerele din vector care sunt multiplii de x.

.data
x: .space 4
n: .space 4
a: .space 4
ok: .byte 0
vector: .space 400
cit_un_numar: .asciz "%ld"
fsx: .asciz "Scrieti numarul x : "
fsn: .asciz "Scrieti cate numere sa aiba vectorul : "
fsv: .asciz "Scrieti numerele din vector : "
fsr: .asciz "Numerele care sunt multipli lui %d din vector sunt : "
niciunul: .asciz "Niciunul"
print: .asciz "%ld "
endline: .asciz "\n"

.text
.global main
main:
 ;# citim x
 pushl $fsx
 call printf
 popl %ebx

 pushl $x
 pushl $cit_un_numar
 call scanf
 popl %ebx
 popl %ebx
 ;# --------
;# citim n
pushl $fsn
call printf
popl %ebx

pushl $n
pushl $cit_un_numar
call scanf
popl %ebx
popl %ebx
;# --------

xorl %ecx, %ecx
lea vector, %edi

pusha
pushl $fsv #"Scrieti numerele din vector : "
call printf
popl %ebx
popa

;# for(ecx = 0; ecx<n; ecx++)
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

    movl a, %eax #punem numarul in a
    movl %eax, (%edi, %ecx, 4) #punem numarul a in vactor
    incl %ecx
    jmp for_citire
exit_for_citire:

;# "Numerele care sunt multipli lui %d din vector sunt : "
push x
push $fsr
call printf 
pop %ebx
pop %ebx
;#-----------

;# for(ecx = 0; ecx < n; ecx++)
xorl %ecx, %ecx
for:
    cmp n, %ecx
    je verif
    
    ;# vector[ecx] / x
    xorl %edx,%edx
    movl (%edi,%ecx,4), %eax
    movl x, %ebx
    div %ebx

    cmp $0, %edx #daca NU se divide
    jne continue

    ;#print the correct numbers
    pusha
    movl (%edi, %ecx, 4), %eax
    movl $1, ok
    pushl %eax
    pushl $print
    call printf
    popl %ebx
    popl %ebx
    popa

    continue:
    incl %ecx
    jmp for
    
;#verificam daca exista cel putin un multiplu
verif: 
    movl ok, %eax
    cmp $1, %eax
    je exit

    pushl $niciunul
    call printf
    popl %ebx


exit:
pushl $endline
call printf
popl %ebx
movl $1, %eax
xorl %ebx, %ebx
int $0x80
