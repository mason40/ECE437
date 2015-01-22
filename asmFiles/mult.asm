# Jason Lin
# lin57@purdue.edu
# 1/16/2015
#
# Multiply Algorithm
          org 0x0800
init:     ori $29, $0, 0xfffc
          ori $4, $0, 0x0000
          ori $10, $0, 0x0005
          ori $11, $0, 0x0002
          push $10
          push $11
beg:
          ori $20, $0, 0x0000
          pop $2
          pop $1
loop:     slt $5, $20, $1
          beq $5, $0, end
          addu $4, $4, $2
          addiu $20, $20, 1
          j loop
end:
          push $4
          halt
