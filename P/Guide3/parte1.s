.data
.equ ADDR_BASE_HI, 0xBF88
.equ TRISE, 0x6100
.equ TRISB, 0x6040
.equ LATE,  0x6120
.equ LATB,  0x6060
.text
.globl main

main:

lui  $t0, ADDR_BASE_HI

lw  $t1, TRISB($t0)
ori $t1, $t1, 0x0001 
sw  $t1, TRISB($t0)

lw  $t2, TRISE($t0)
andi $t2, $t1, 0xFFFE
sw  $t2, TRISE($t0)

while:

    lw $t3, LATB($t0)       # read 
    lw $t4, LATE($t0)       # read

    andi $t4, $t4, 0xFFFE
    andi $t3, $t3, 0X0001
    or   $t4, $t4, $t3      # modify
    sw   $t4, LATE($t0)     # write

    j while

    jr $ra