;# sa se ordoneze crescator sirul
.data
sir: .long 14, 2, 8, 9, 13
n: .long 5

j: .long 0
.text

.global main
main:
;#
mov n, %ecx
loop:
    mov n, %eax
    sub %ecx, %eax  ;# eax este 0, 1, 2, 3, 4

    cmp $0, %ecx
    je exit

    decl %ecx ;#scadem din ecx 1 ca sa creasca eax

    lea sir, %esi

    movl %eax, j
    loop_j:
        incl j
        movl $5, %ebx

        cmp j, %ebx ;#daca j este 5
        je loop

        movl j, %edx
        movl (%esi, %eax, 4), %eax
        movl (%esi, %edx, 4), %ebx

        
        cmp %eax, %ebx
        jge loop_j

        movl %ebx, (%esi, %eax, 4)
        movl %eax, (%esi, %edx, 4)   ;# swap

        jmp loop_j 


exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80
