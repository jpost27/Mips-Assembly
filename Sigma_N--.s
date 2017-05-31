#############################################
# Program Name: Sum of Integers
# Programmer: (Josh Post)
#############################################
# Functional Description:
# A program to find the sum of the integers
# from 1 to N, where N is a value
# read in from the keyboard
#############################################
# Cross References:
# v0: N,
# t0: Sum
#############################################

	.data	# Data declaration section
Prompt: .asciiz	"\n Please Input a value for N = "
Result: .asciiz "The sum of the integers from 1 to N is "
Bye: 	.asciiz "\n ****** Have a good day ******"
	.globl	main
	.text

main:		# Start of code section
	li	$v0, 4		#System call code for Print String
	la	$a0, Prompt	#load address of prompt into $a0
	syscall			#print the prompt message
	li	$v0, 5		#system call code for Read Integer
	syscall			#reads the value of N into $v0
	blez	$v0, End 	#branch to end if $v0 <= 0
	li	$t0, 0		#clear register $t0 to 0
Loop:
	add	$t0, $t0, $v0	#sum of integers in register $t0
	addi	$v0, $v0, -1	#summing of integers in reverse order
	bnez	$v0, Loop	#branch to loop if $v0 is != 0
	
	li	$v0, 4		#system call code for Print String
	la	$a0, Result	#load address of message into $a0
	syscall			#print the string
	
	li	$v0, 1		#system call code for Print Integer
	move	$a0, $t0	#move value to be printed to $a0
	syscall			#print sum of integers
	b	main		#branch to main
	
End:	li	$v0, 4		#System call code for Print String
	la	$a0, Bye	#load address of msg into $a0
	syscall			#print the string
	li	$v0, 10		#terminate program run and
	syscall			#return control to the system
# END OF PROGRAM
