# Jason Lin
# lin57@purdue.edu
# 1/16/2015
#
# Multiplication procedure

        org 0x0800
init:   ori $29, $0, 0xfffc
        ori $30, $0, 0xfff8
        ori $1, $0, 0x0002
        ori $2, $0, 0x0003
        ori $3, $0, 0x0004
        ori $4, $0, 0x0005
        ori $5, $0, 0x0006
        ori $6, $0, 0x0007
        ori $7, $0, 0x0008
        push $1
        push $2
        push $3
        push $4
        push $5
        push $6
        push $7
main:   beq $29, $30, mend
        jal mult
        j main
mend:
        halt

mult:   pop $2
        pop $3
        ori $4, $0, 0x0000
        ori $5, $0, 0x0000
mloop:  slt $6, $5, $2
        beq $6, $0, lend
        addu $4, $4, $3
        addiu $5, $5, 1
        j mloop
lend:
        ori $3, $0, 0x8000
        sw $4, 0($3)
        push $4
        jr $31
