# tasks1.asm
  .data 
str: .asciiz "Something is: "
str2: .asciiz "Enter something: "
  .text

main: 

    li   $v0, 4         # system call code for print_string
    la   $a0, str2      # address of string to print
    syscall             # print the string


    li   $v0, 5         # call to read int
    syscall
    la   $t1, 0($v0)    # stores address of int into $t1


    li   $v0, 4         # system call code for print_string
    la   $a0, str       # address of string to print
    syscall             # print the string

    li   $v0, 1         # system call code for print_int
    la   $a0, 0($t1)    # puts address of int into $a0
    syscall             # print the integer
    
    li   $v0, 10        # system call code for exit
    syscall             # terminate program