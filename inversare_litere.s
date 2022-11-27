# cerinta : transform litere mici dintr-un sir de caractere in litere mari si vice versa
;# input Mihai 
;# output mIHAI 

.data
len: .space 4
sir: .space 404
rst: .space 1
fs1: .asciz "%s\n"
.text
.global main
main:
pushl $sir ;# adadugam ce este scris la tastatura in sir
call gets
popl %ebx

pushl $sir  ;# adaugmam lungimea lui sir
call strlen
popl %ecx
mov %eax, len

xorl %ecx,%ecx
lea sir, %edi
for:
    cmp len, %ecx
    je exit_for

    movb (%edi,%ecx,1), %dl

    cmp $'A', %dl
    jl continue_for

    cmp $'Z', %dl
    jg continue_a

    subb $'A', %dl
    add $'a', %dl

    movb %dl, (%edi,%ecx,1)

    jmp continue_for

    continue_a:
    cmp $'a', %dl
    jl continue_for

    cmp $'z', %dl
    jg continue_for

    subb $'a', %dl
    add $'A', %dl
    
    movb %dl, (%edi,%ecx,1)

    continue_for:
    incl %ecx
    jmp for
exit_for:

afisare:
push $sir
pushl $fs1
call printf
popl %ebx
popl %ebx

    
exit:
movl $1, %eax
xorl %ebx,%ebx
int $0x80
