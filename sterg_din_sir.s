;# Problema : sa se stearga cifrele dintr-un sir de caractere
.data
sir: .space 800
len: .space 4
fs1: .asciz "%s\n"
.text
.global main
main:

;#citim sirul
pushl $sir
call gets
popl %ebx

;# aflam lungimea sirului
pushl $sir
call strlen
popl %ebx
mov %eax, len

xorl %ecx, %ecx
lea sir, %esi
;# for(ecx = 0; ecx< len(sir); ecx++)
i_for: ;# --------
    cmp len, %ecx
    je exit_i_for

    movb (%esi,%ecx,1), %dl
    cmp $'0', %dl
    jb continue_i_for

    cmp $'9', %dl
    jg continue_i_for

    movl %ecx, %ebx
    ;# for(ebx = ecx; ebx < len(sir); ebx++)
    j_for: ;# -------
        cmp len, %ebx
        je exit_j_for

        incl %ebx
        movb (%esi, %ebx, 1), %dl
        decl %ebx

        movb %dl, (%esi,%ebx,1)

        incl %ebx
        jmp j_for ;# -------
    exit_j_for:
    
    ;#scadem din len ptc se sterge un caracter
    decl len
    jmp i_for ;#cand sterge !ecx! ramane pe aceeasi pozitie
    
    continue_i_for:
    incl %ecx
    jmp i_for ;# ------
exit_i_for:

;# print sir
push $sir
pushl $fs1
call printf
popl %ebx
popl %ebx

exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80
