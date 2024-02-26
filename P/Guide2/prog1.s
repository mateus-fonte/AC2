.equ READ_CORE_TIMER,11
.equ RESET_CORE_TIMER,12
.equ PUT_CHAR,3
.equ PRINT_INT,6
.data
.text
.globl main

main:   li  $t0, 0      # counter=0

    li $a0, 5000
    li $a1, 20000
    jal delay

while:

    li $a0, '\r'
    li $v0, PUT_CHAR
    syscall

    move $a0, $t0
    li $a1, 0x0004000A
    li $v0, PRINT_INT
    syscall

    li $v0, RESET_CORE_TIMER
    syscall

    

loop:

    li $v0, READ_CORE_TIMER
    syscall

    bltu $v0, 2000000, loop

    addiu $t0, $t0, 1

    j while

    jr $ra


    
delay:

    mul $t2, $a0, $a1

    li $v0, RESET_CORE_TIMER
    syscall 

loop_delay:

    li $v0, READ_CORE_TIMER
    syscall

    bltu $v0, $t2, loop_delay
    
    jr  $ra