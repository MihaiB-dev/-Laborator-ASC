;#Sa sa implementeze procedura x86 cu acelasi efect ca procedura C memcpy:
;#void *memcpy(void *dest, const void *src, size_t n);
;#care copiaza n octeti de la adresa src la adresa dest si returneaza dest.

.data
n: .space 4
sir1: .space 400
sir2: .space 400

fs1: .asciz "%s"
fsprint: .asciz "%s\n"
.text
memcpy_replica: ;# 8(%ebp) = sir care va copia ; 12(%ebp) = sir care va fi copiat ; 16(%ebp) = lungimea
push %ebp
movl %esp, %ebp

pushl %edi
pushl %esi
p:
xorl %ecx, %ecx
movl 8(%ebp), %edi ;# in care copie
movl 12(%ebp), %esi ;# din care luam date
for_memcpy:
    cmp %ecx, 16(%ebp)
    je exit_for_memcpy

    movl (%esi, %ecx, 4), %eax
    movl %eax, (%edi, %ecx,4)

    incl %ecx
    jmp for_memcpy
exit_for_memcpy:

;#movl 16(%ebp), %ecx
;#incl %ecx
;#movl $'\0', (%edi, %ecx, 4)
pop %esi
pop %edi
pop %ebp
ret
.global main
main:

pushl $sir1 ;#citesc sirul initial
call gets
pop %ebx

pushl $sir1
pushl $fs1
call strlen 
addl $8, %esp
movl %eax, n ;# n = strlen(sir1)

pushl n
pushl $sir1
pushl $sir2
call memcpy_replica
addl $12, %esp

pushl $sir2
push $fsprint
call printf
addl $8, %esp
exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80