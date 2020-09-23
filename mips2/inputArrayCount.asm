# inputArrayCount.asm


  .data                         # the start of gloabal var

arrayA:  .space 32              # 8 * 4 = 32 bytes reserved for int arr
count:   .word 999                # dummy value
str2:    .asciiz "Count elements less than: "
str3:    .asciiz "Enter element: "

  .text                         # end of global var



main:                           # setup the variable mappings
    la    $t0, arrayA           # $t0 is arrayA
    lw    $t8, count            # $t8 is count
    addi  $t8, $zero, 0         # initialise count to 0
    addi  $t9, $zero, 0         # $t9 used by readLoop



readLoop:                       # read user input and put into array
    slt   $t1, $t9, 32          # goto endReadLoop if $t9 >= 32
    beq   $t1, $zero, endReadLoop

    li    $v0, 4                # prompt the user to input
    la    $a0, str3
    syscall                     # print "Your element? "

    li    $v0, 5                # read user input
    syscall
    sw    $v0, arrayA($t9)      # stores int into $t2

  
    addi  $t9, $t9, 4           # increment offset by 4
    j     readLoop



endReadLoop:
    addi  $t9, $zero, 0         # change counter back to 0


    li    $v0, 4                # read input from user
    la    $a0, str2             # address of string to print
    syscall                     # print the string

    li    $v0, 5                # call to read int
    syscall
    la    $t5, 0($v0)           # stores int into $t5



loop:                           # counting elements <= to X in arrayA
    slt   $t1, $t9, 32          # goto end if $t9 >= 32
    beq   $t1, $zero, end

    lw    $t4, arrayA($t9)      # get data out of address

    slt   $t1, $t5, $t4         # check if $t5 < $t4
    bne   $t1, $zero, skip
    addi  $t8, $t8, 1           # increment count



skip:
    addi $t9, $t9, 4
    j     loop



end:
    sw    $t8, count            # store $t8 into count
    li    $v0, 1                # system call code for print_int
    la    $a0, 0($t8)
    syscall                     # print count


    li    $v0, 10               # terminating program, exiting
    syscall