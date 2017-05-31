##############################################
# Program Name: Palindrome Sum
# Programmer: Joshua Post
# Date 2/11/2015
#############################################
# Functional Description:
# A program to find the sum of an integer and
# its reverse-digit integer
# until a palindrome is found
#############################################
# Cross References:
# v0: N
# a3: Current integer
###########################################

	.data	# Data declaration section
Prompt:		.asciiz	"\n\nTo quit enter 0.\nEnter a number to produce a palindrome: "
Plus:	 	.asciiz " + "
Equals:		.asciiz " = "
Bye: 		.asciiz "\n ****** Have a good day ******"
	.globl	main
	.text

main:		# Start of code section
	#Get user input
	li	$v0, 4					#System call code for Print String
	la	$a0, Prompt				#load address of prompt into $a0
	syscall						#print the prompt message
	li	$v0, 5					#system call code for Read Integer
	syscall						#reads the value of N into $v0
	addi $a1, $v0, 0			#move contents of $v0 to $a1
	addi $a3, $v0, 0			#move contents of $v0 to $a1
    xor $a2, $a2, $a2  			#$a2 will hold reverse integer
    li $t1, 10					#load a value of 10 into $t1
    beqz $a1, End 				#branches to end if input is less than 0
mainloop:
	#print current integer
	li	$v0, 1			#system call code for Print Integer
	move	$a0, $a3	#move value to be printed to $a0
	syscall				#print sum of integers
	#Put reverse integer into $a2
loop:
    divu $a1, $t1      # Divide number by 10
    mflo $a1           # $a1 = quotient
    mfhi $t2           # $t2 = reminder
    mul $a2, $a2, $t1  # reverse=reverse*10
    addu $a2, $a2, $t2 # + reminder  
    beq $a2, $a3, Fin  #finish current process when palindrome is found
    bgtz $a1, loop	   #continue loop until reverse is found
    #print what is being added
    li	$v0, 4		#System call code for Print String
	la	$a0, Plus		#load address of msg into $a0
	syscall				#print the string
    li	$v0, 1			#system call code for Print Integer
	move	$a0, $a2	#move value to be printed to $a0
	syscall				#print sum of integers
	li	$v0, 4		#System call code for Print String
	la	$a0, Equals		#load address of msg into $a0
	syscall				#print the string
	#get ready for next reverse-digit summation
    add $a3, $a3, $a2	#store new number in $a3
    addi $a1, $a3, 0	#move contents of $v0 to $a1
    li $a2, 0			#reset $a0 to 0
	b mainloop			#branch to mainloop
Fin:
	#clear all used registers for next process
	li $t1, 0	#reset $t1 to 0
	li $a1, 0	#reset $a1 to 0
	li $a2, 0	#reset $a2 to 0
	li $a3, 0	#reset $a3 to 0
	b main 		#Branch back to the beginning
End:	
	li	$v0, 4		#System call code for Print String
	la	$a0, Bye		#load address of msg into $a0
	syscall				#print the string
	li	$v0, 10			#terminate program run and
	syscall				#return control to the system
# END OF PROGRAM
