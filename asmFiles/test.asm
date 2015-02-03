# Testing all functionality listed in asm -i

org 0x0000
ADDU  $1, $2, $3
ADD   $2, $3, $1
AND   $3, $7, $3
JR    $2
NOR   $2, $5, $4
OR    $3, $0, $1
SLT   $1, $2, $3
SLTU  $2, $0, $0
SLL   $1, $3, 8
SRL   $2, $2, 3
SUBU  $3, $5, $4
SUB   $5, $6, $7
XOR   $1, $0, $1
ADDIU $1, $2, 8
ADDI  $1, $2, 1024
ANDI  $1, $1, 12
label1:
BEQ   $1, $2, label1
label2:
BNE   $3, $4, label2
LUI   $3, 12
LW    $3, 4($1)
ORI   $1, $2, 10
SLTI  $2, $3, 100
SLTIU $1, $3, 122
SW    $1, 120($1)
LL    $1, 10($1)
SC    $1, 10($2)
XORI  $2, $2, 1023
label3:
J     label3
JAL   label4
label4:
halt
