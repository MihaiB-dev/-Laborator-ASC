;# schimbari fata de problm 0 : 
;# malloc randul 21 (procedura, aloca spatiu dinamic)
;# free randul 54 ( dealoca spatiul dinamic)
;# facem spatiu pe stiva pentru cele 3 pointere pentru matrici randul 214, 215
;#
.data
nr_cerinta: .space 4
nr_noduri: .space 4
a: .space 4

legaturi_numar: .space 400
;# matrice = -4(%ebp)
;# m1 = -8(%ebp)
;#nres = -12(%ebp)

lungime_drum: .space 4
sursa: .space 4
destinatie: .space 4

citire: .asciz "%ld"
fs1: .asciz "\n"
print: .asciz "%ld "

.text
malloc:
    pushl %ebp
    movl %esp, %ebp

    pushl %edi
    pushl %esi
    pushl %ebx
    ;# cream dimensiunea ca sa fie stocata in ecx
    movl 8(%ebp), %eax ;# nr_noduri in eax
    movl 8(%ebp), %ebx ;#nr_noduri in ecx
    mull %ebx ;# inmultim, deoarece matricea este patraticaa
    movl $4, %ebx ;# adaugam valoarea de bytes a unui long
    mull %ebx ;# mai inmultim inca o data cu valoarea unui long
    movl %eax, %ecx ;# Dimensiunea alocata
    
    xorl %ebx, %ebx ;# ebx trebuie sa fie 0

    movl $3, %edx ;# referinta pentru PROT_READ | PROT_WRITE

    movl $33, %esi ;# referinta pentru MAP_SHARED | MAP_ANONYMOUS

    mov $-1, %edi ;# este necesar pentru Map_anonymous

    movl $192, %eax ;# punem valoarea lui mmap2 in eax, syscall
    int $0x80
    popl %ebx
    popl %esi
    popl %edi

    popl %ebp

ret
free: ;# free(adresa, lungime)
    pushl %ebp
    movl %esp, %ebp
    
    pushl %ebx
    
    movl -12(%ebp), %eax ;# cream dimensiunea ca sa fie stocata in ecx
    movl -12(%ebp), %ebx
    mull %ebx
    movl $4, %ebx
    mull %ebx
    movl %eax, %ecx ;# Dimensiunea pentru dealocata 

    movl -8(%ebp), %ebx ;#mutam adresa matricei dinamice
    movl $91, %eax ;#valoarea lui munmap pentru syscall
    int $0x80

    
    pop %ebx
    pop %ebp
ret
copiere: ;#copiere(matrice, alta_matrice_in_care_se_copiaza, nr_noduri)
    pushl %ebp
    movl %esp, %ebp

    pushl %esi
    pushl %edi
    pushl %ebx

    mov 8(%ebp), %esi ;#matricea originala
    mov 12(%ebp), %edi ;# matricea care copiaza

    xorl %ecx, %ecx
    for_copiere:
        movl 16(%ebp), %edx
        cmp %ecx, %edx
        je exit_for_copiere

        xorl %ebx, %ebx
        for_coloana_copiere:
            movl 16(%ebp), %edx
            cmp %ebx, %edx
            je exit_for_coloana_copiere

            movl 16(%ebp), %eax
            mull %ecx
            addl %ebx, %eax

            movl (%esi, %eax, 4),%edx
            movl %edx, (%edi, %eax, 4)

            incl %ebx
            jmp for_coloana_copiere
        exit_for_coloana_copiere:

        incl %ecx
        jmp for_copiere
    exit_for_copiere:

    popl %ebx
    popl %edi
    popl %esi

    popl %ebp
ret

matrix_mult:
    pushl %ebp
    movl %esp, %ebp
    subl $8, %esp
    pushl %esi
    pushl %edi
    pushl %ebx

    movl 8(%ebp), %edi ;#matricea schimbatoare
    movl 12(%ebp), %esi ;#matricea orginala

    xorl %ecx, %ecx
    for_i:
        cmp %ecx, 20(%ebp)
        je exit_for_i

        xorl %ebx, %ebx
        for_j:
            cmp %ebx, 20(%ebp)
            je exit_for_j

            ;# initializam valoarea nres[i][j] = 0
            pushl %edi
            
            movl 16(%ebp), %edi
            movl 20(%ebp), %eax
            mull %ecx
            addl %ebx, %eax

            movl $0, (%edi,%eax,4)

            popl %edi

            xorl %edx, %edx
            for_k:
                cmp %edx, 20(%ebp)
                je exit_for_k
                
                ;#adaugam pe stiva o valoare din m1
                pushl %edx

                movl 20(%ebp), %eax
                mull %ecx

                popl %edx

                addl %edx, %eax

                pushl %edx
                movl (%edi, %eax, 4), %edx
                movl %edx, -4(%ebp)
                popl %edx

                ;#adaugam pe stiva o valoarea din matrice
                pushl %edx

                movl 20(%ebp), %eax
                mull %edx

                popl %edx

                addl %ebx, %eax

                pushl %edx
                movl (%esi, %eax, 4),%edx
                movl %edx, -8(%ebp)
                popl %edx

                ;#inmultim cele 2 valori
                pushl %edx
                movl -4(%ebp), %eax
                mull -8(%ebp)
                popl %edx
                ;#punerea inmultirii in nres
                pushl %edx  ;# !!!!!! [k] II dam overwrite lui edx ca sa adaugam inmultirea in nres[i][j]
                movl %eax, %edx

                pushl %edi
                pushl %edx ;# [valoarea inmultirii] O punem pe stiva
                movl 16(%ebp), %edi
                
                movl 20(%ebp), %eax
                mull %ecx
                addl %ebx, %eax

                popl %edx
                addl %edx, (%edi, %eax, 4)

                popl %edi
                popl %edx 

                incl %edx
                jmp for_k
            exit_for_k:
        incl %ebx
        jmp for_j
        exit_for_j:
    incl %ecx
    jmp for_i
    exit_for_i:

    popl %ebx
    popl %edi
    popl %esi

    addl $8, %esp
    popl %ebp

ret
.global main
main:
movl %esp, %ebp ;# fac spatiu pe stiva pentru cele 3 matrici / pointere
subl $12, %esp ;# aloc 3 spatii pentru pointere

;# citim nr_cerinta
pushl $nr_cerinta
push $citire
call scanf
addl $8, %esp

;#citim nr_noduri
pushl $nr_noduri
push $citire
call scanf
addl $8, %esp
 
;# for (i = 0; i<nr_noduri;i++) -> legaturi_numar[i] = (%edi, %ecx, 4)
xorl %ecx, %ecx
lea legaturi_numar, %edi
for_citire_legaturi_numar:
    cmp nr_noduri, %ecx
    je exit_for_citire_legaturi_numar

    pusha
    pushl $a
    push $citire
    call scanf
    addl $8, %esp
    popa

    movl a, %eax
    movl %eax, (%edi, %ecx, 4)

    incl %ecx
    jmp for_citire_legaturi_numar
exit_for_citire_legaturi_numar:

;# alochez spatiu dinamic pentru matricea originala
pushl nr_noduri
call malloc
popl %ebx

movl %eax, -4(%ebp)
;# fac un for pentru fiecare nod, si citesc cu ce noduri se leaga ( o matrice variabila in coloane )
xorl %ecx, %ecx
movl -4(%ebp), %esi
for_matrice:
    cmp %ecx, nr_noduri
    je exit_matrice
    
    xorl %ebx, %ebx
    for_citire_fiec_leg:
        cmp (%edi, %ecx, 4), %ebx
        je exit_for_citire_fiec_leg

        pusha
        pushl $a
        push $citire
        call scanf
        addl $8, %esp
        popa 
 
        movl nr_noduri, %eax
        xorl %edx, %edx
        mull %ecx ;# in eax va fi primul indexul pentru matrice (i)

        movl a, %edx
        addl %eax, %edx
        movl $1, (%esi, %edx, 4)

        incl %ebx
        jmp for_citire_fiec_leg
    exit_for_citire_fiec_leg:

    incl %ecx
    jmp for_matrice
exit_matrice:

;#!!!!!!!!!!!!!! cerinta 3

;# citim lungimea
pushl $lungime_drum
push $citire
call scanf
popl %ebx
popl %ebx

;# citim nodul sursa
pushl $sursa
push $citire
call scanf
popl %ebx
popl %ebx

;# citim nodul destinatie
pushl $destinatie
push $citire
call scanf
popl %ebx
popl %ebx

;# matrix_mult(m1, matrice, nres, nr_noduri)
;# m1 - este o matrice care dupa fiecare calcul matrix_mult, va copia matricea nres
;# matrice - matricea originala
;# nres - rezultatul inmultirii a 2 matrici
;# nr_noduri - dimensiunea matricilor
;#PASUL 1: copiem matricea originala in m1 si nres ( in cazul lui k = 1 si pentru prima inmultire)
;#pasul 2: cream functia matrix_mult ( inmulteste primele 2 matrici si scrie rezultatul in nres)
;#PASUL 3: copiem matricea nres in m1 ( pentru a continua inmultirile )
;#PASUL 4: verificam in matricea finala nres valoarea in nres[sursa][destiantie] si o afisam 

;#alocam spatiu pentru nres
;# Numarul pentru mmap2

;#Cream un malloc(n) -> valoarea ajunge in eax
pushl nr_noduri
call malloc
popl %ebx

movl %eax, -12(%ebp) ;# punem pointerul pentru nres in -12(%ebp)
;#------------------
pushl nr_noduri
call malloc
popl %ebx

movl %eax, -8(%ebp) ;# m1
;#PASUL 1:

pushl nr_noduri
pushl -12(%ebp);#nres ;#matricea in care se copiaza cea originala
pushl -4(%ebp) ;#matricea originala
call copiere
addl $12, %esp

pushl nr_noduri
pushl -8(%ebp) ;#matricea in care se copiaza cea originala
pushl -4(%ebp) ;# matricea org.
call copiere
addl $12, %esp





;# inmultesc matricea de lungime_drum ori
movl $1, %ecx
for_matrix_mult:
    cmp lungime_drum, %ecx
    je exit_for_matrix_mult
    
    pusha
    ;#PASUL 2:
    pushl nr_noduri
    pushl -12(%ebp) ;#nres
    pushl -4(%ebp) ;# matricea org.
    pushl -8(%ebp)
    call matrix_mult
    addl $16, %esp
    popa

    pusha
    ;#PASUL 3:
    pushl nr_noduri
    pushl -8(%ebp)
    pushl -12(%ebp) ;# nres
    call copiere
    addl $12, %esp

    popa

    incl %ecx
    jmp for_matrix_mult
exit_for_matrix_mult:

;# PASUL 4: aflu vloarea de pe pozitia: nres[sursa][destinatie]
movl -8(%ebp), %edi
movl nr_noduri, %eax
movl sursa, %ecx
mull %ecx
movl destinatie, %ebx
addl %ebx, %eax
movl (%edi, %eax, 4), %ecx ;# rezultatul nostru se afla in valoarea ecx

;#afisam rezultatul
pushl %ecx
pushl $citire ;#folosesc citire doar pentru ca nu are spatiu dupa %ld
call printf
addl $8, %esp

pushl $fs1
call printf
popl %ebx

pushl $0
call fflush
popl %ebx

p:
;#free space from pointer %eax ;# IL FACEM PROCEDURA 
pushl nr_noduri
push -4(%ebp) ;#matricea originala
call free
addl $8, %esp

pushl nr_noduri
push -8(%ebp) ;# m1
call free
addl $8, %esp

pushl nr_noduri
push -12(%ebp) ;# nres
call free
addl $8, %esp


addl $12, %esp ;# eliberez cele 3 pointere pentru matrici
;#movl %esp, %ebp
exit: 
movl $1, %eax
xorl %ebx, %ebx
int $0x80