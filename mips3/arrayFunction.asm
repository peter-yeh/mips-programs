# arrayFunction_ans.asm

.data
array:       .word 8, 2, 1, 6, 9, 7, 3, 5, 0, 4
newl:        .asciiz "\n"
enterLeft:   .asciiz "Enter left bound: "
enterRight:  .asciiz "Enter right bound "
returnArr:   .asciiz "The reversed array is "
.text

main:
        # 1. Setup the parameter(s)
        # Call the printArray function to print the original content
        la   $a0, array
        li   $a1, 10
        jal printArray



        # 2. Ask the user for two indices
        li   $v0, 4                             # print enter left bound:
        la   $a0, enterLeft
        syscall

        li   $v0, 5                          	# System call code for read_int
        syscall
        addi $t0, $v0, 0    	                # first user input in $t0

        li   $v0, 4                             # print enter right bound:
        la   $a0, enterRight
        syscall

        li   $v0, 5         	                # System call code for read_int
        syscall
        addi $t1, $v0, 0    	                # second user input in $t1



        # 3. Setup the parameter(s)
        # Call the reverseArray function
        sll     $t2, $t0, 2                     # $t2: offset address, left bound * 4
        la      $t4, array                      # $t4: address of array[0]
        add     $t2, $t2, $t4                   # $t2: address of left bound

        sub     $t3, $t1, $t0                   # $t3: $t3 = $t1 - $t0

        la      $a0, 0($t2)                     # $a0: address of left bound
        addi      $a1, $t3, 0                   # $a0: end point of the array
        jal     reverseArray



        # 4. Setup the parameter(s)
        # Call the printArray function to print the modified array
        la      $a0, array
        li      $a1, 10
        jal     printArray



        #End of main, make a syscall to "exit"
        li      $v0, 10                         # system call code for exit
        syscall	       			                # terminate program



#######################################################################
###   Function printArray   ### 
#Input: Array Address in $a0, Number of elements in $a1
#Output: None
#Purpose: Print array elements
#Registers used: $t0, $t1, $t2, $t3
#Assumption: Array element is word size (4-byte)

printArray:
	addi $t1, $a0, 0	# $t1 is the pointer to the item
	sll  $t2, $a1, 2	# $t2 is the offset beyond the last item
	add  $t2, $a0, $t2 	# $t2 is pointing beyond the last item
l1:	
	beq  $t1, $t2, e1
	lw   $t3, 0($t1)	# $t3 is the current item
	li   $v0, 1   		# system call code for print_int
	addi $a0, $t3, 0    # integer to print
	syscall       		# print it
	addi $t1, $t1, 4
	j l1				# Another iteration
e1:
	li   $v0, 4   		# system call code for print_string
	la   $a0, newl    	# 
	syscall       		# print newline
	jr 	$ra				# return from this function


##################################################################
###   Function reverseArray                                    ### 
# Input: Array Address in $a0, Number of elements in $a1
# Output: NIL, as the array items are modified directly 
# Purpose: Reverse the array items, array pointer approach must be
#          used. 
# Registers used: $t0, $t1, $t2, $t3, $t4
# Assumption: Array element is word size (4-byte)
#             $a0 is valid and $a1 is positive integer

reverseArray:
        # Your implementation here
        # $t0 is a temp value
        addi    $t1, $a0, 0                     # $t1: address of front pointer
        sll     $t0, $a1, 2                     # $t0: address offset from $t1
        add     $t2, $t0, $t1                   # $t2: address of rear pointer


revArrLoop:
        slt     $t0, $t1, $t2                   # if $t1 less than $t2, set to 1, and continue
        beq     $t0, $zero, revArrEnd           # else goto revArrEnd

        lw      $t3, 0($t1)                     # $t3: word at front address
        lw      $t4, 0($t2)                     # $t4: word at rear address

        sw      $t4, 0($t1)
        sw      $t3, 0($t2)

        addi    $t1, $t1, 4                     # increment first address
        addi    $t2, $t2, -4                    # decrement last address

        j       revArrLoop


revArrEnd:
        jr      $ra 	                        # return from this function