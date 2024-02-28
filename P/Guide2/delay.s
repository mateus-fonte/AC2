.equ READ_CORE_TIMER,11
.equ RESET_CORE_TIMER,12
.equ INKEY, 1
.equ PUT_CHAR,3
.equ PRINT_INT,6
.data
.text
.globl main

main:

    li $t0, 0   # count1
    li $t1, 0   # count5
    li $t2, 0   # count10
    li $t3, 20000
    li $t4, 100
    mul $t5, $t3, $t4
    move $t6, $t5


while:

    li $a0, '\r'
    li $v0, PUT_CHAR
    syscall

    move $a0, $t2
    li $a1, 0x0005000A
    li $v0, PRINT_INT
    syscall

    li $a0, '\t'
    li $v0, PUT_CHAR
    syscall

    move $a0, $t1
    li $a1, 0x0005000A
    li $v0, PRINT_INT
    syscall

    li $a0, '\t'
    li $v0, PUT_CHAR
    syscall

    move $a0, $t0
    li $a1, 0x0005000A
    li $v0, PRINT_INT
    syscall

    li $v0, INKEY
    syscall

    beq $v0, 0x00000041, A_pressed
    beq $v0, 0x0000004E, N_pressed
    beq $v0, 0x00000053, S_pressed

delay:

    li $v0, RESET_CORE_TIMER
    syscall

loop_delay:

    li $v0, READ_CORE_TIMER
    syscall

    bltu $v0, $t5, loop_delay

    addiu $t0, $t0, 1

    rem $a0, $t0, 2

    beqz $a0, first_if

    j while

first_if:

    addiu $t1, $t1, 1

    rem $a0, $t0, 10

    bne $a0, 0, while

    addiu $t2, $t2, 1

    j while

A_pressed:

    div $t5, $t5, 2

    j delay

N_pressed:

    move $t5, $t6

    j delay

S_pressed:

    li $v0, INKEY
    syscall

    beq $v0, 0x00000052, delay

    j S_pressed


    jr $ra









