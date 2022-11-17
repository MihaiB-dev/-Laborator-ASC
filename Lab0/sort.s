# sa se ordoneze crescator sirul
.data
sir: .long 14, 2, 8, 9, 13
n: .long 5

j: .long 0
.text

.global main
main:
;#
xorl %ecx, %ecx
loop:
      ;# ecx este 0, 1, 2, 3, 4

    cmp n, %ecx
    je exit

    lea sir, %esi

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



exit:
movl $1, %eax
xorl %ebx, %ebx
int $0x80
