.data
sir: .space 200
vocale: .asciz "AEIOUaeiou"
len: .space 4
PrintFormat: .asciz " Numarul de vocale este %ld\n"
contor: .long 0
.text

.global main
main:

pushl $sir ;# adadugam ce este scris de la tastatura in sir
call gets
popl %ebx

pushl $sir  ;# adaugmam lungimea lui sir
call strlen
popl %ecx
mov %eax, len

xorl %ecx, %ecx ;# facem ecx = 0

lea sir, %esi ;#adaugam sir in esi
lea vocale, %edi ;# adaugam vocale in edi
i_for:

cmp len, %ecx ;#daca ecx = len atunci iese din for
je et_print

mov (%esi, %ecx, 1), %al ;# al = fiecare caracter

xorl %ebx,%ebx ;# facem ebx = 0
    j_for:

    cmp $10, %ebx ;#daca ebx = numarul de vocale (10) iese din j_for
    je end_i_for

    mov (%edi, %ebx, 1), %dl;# trece prin fiecare AEIOUaeiou

    cmp %al, %dl ;#compara caracterul din %al cu fiecare vocala, daca sunt egale iese din j_for
    je end_j_for
    
    incl %ebx ;# %ebx ++ 
    jmp j_for ;# continua loopul

    end_j_for: ;# contor ++, iar dupa continua prin i_for
    incl contor 
    
end_i_for:
incl %ecx ;# ecx++
jmp i_for ;#continua loopul


et_print: 
pushl contor
pushl $PrintFormat ;# == " Numarul de vocale este %ld\n"
call printf
pop %ebx
pop %ebx



et_exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80
