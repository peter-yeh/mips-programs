# arrayCount.asm
  .data                                    # the start of gloabal var
arrayA: .word 11, 0, 31, 22, 9, 17, 6, 9   # arrayA has 5 values, changed to 8
count:  .word 0                            # dummy value
str: .asciiz "The answer = "
str2: .asciiz "Enter something: "
  .text                                    # end of global var

main:
# setup the variable mappings
    la $t0, arrayA                    # $t0 is arrayA
    lw $t8, count                     # $t8 is count
    addi $t7, $zero, 0                # $t7 is current index
    addi $t6, $zero, 8                # $t6 max index
    la $t2, arrayA                    # $t2 is current address

# read in user input, X 
    li   $v0, 4                       # prompt the user to input
    la   $a0, str2                    # address of string to print
    syscall                           # print the string

    li   $v0, 5                       # call to read int
    syscall
    la   $t5, 0($v0)                  # stores int into $t5

# counting elements <= to X in arrayA
loop:
    slt $t1, $t7, $t6                  # check if it's end of index
    beq $t1, $zero, end                # exit if end of index

    lw $t4, 0($t2)                     # get data out of address

    slt $t1, $t5, $t4                  # check if $t5 < $t4
    bne $t1, $zero, skip
    addi $t8, $t8, 1
    

skip:
    addi $t7, $t7, 1
    addi $t2, $t2, 4                   # increment address
    j loop

# printing result
end:
    li   $v0, 1         # system call code for print_int
    la   $a0, 0($t8)    # integer to print, why won't li work ?
    syscall             # print the integer

# terminating program, exiting
    li  $v0, 10
    syscall