# Jason Lin
# lin57@purdue.edu
# mg208
# 1/16/2015
#
# Calculate Days asm code

        org 0x0800
init:   ori $29, $0, 0xfffc
        ori $1, $0, 2014  #year
        ori $2, $0, 7    #month
        ori $3, $0, 11    #day
        ori $30, $0, 1
main:   subu $2, $2, $30   #month-1
        ori $30, $0, 2000
        subu $1, $1, $30  #year-2000
        ori $4, $0, 365
        push $4
        push $1
        jal mult
        pop $1
        ori $4, $0, 30
        push $4
        push $2
        jal mult
        pop $2
        addu $1, $1, $2
        addu $1, $3, $1
        halt

mult:   ori $20, $0, 0x0000
        ori $21, $0, 0x0000
        pop $19
        pop $18
mloop:  slt $17, $20, $19
        beq $17, $0, lend
        addu $21, $21, $18
        addiu $20, $20, 1
        j mloop
lend:   push $21
        jr $31
