##############################################
# Program Name: Shapes
# Programmer: Joshua Post
# Date 2/11/2015
#############################################
# Functional Description:
# A program to find the area of a shape based on
# two coordinates read from keyboard input
#############################################
# Cross References:
# v0: N
# t1: area
###########################################

	.data	# Data declaration section
Prompt:		.asciiz	"\n\nTo quit enter 0.\nTo continue enter 1.\n"
Invalid: 	.asciiz "!*!*!*That is not a valid selection.*!*!*!"
X1:			.asciiz "\nX1: "
Y1:			.asciiz "Y1: "
X2:			.asciiz "X2: "
Y2:			.asciiz "Y2: "
CircleCalc:		.asciiz "The area of the circle is: "
SquareCalc:		.asciiz "\nThe area of the square is: "
RectangleCalc:	.asciiz "\nThe area of the rectangle is: "
Bye: 		.asciiz "\n ****** Have a good day ******"
	.globl	main
	.text

main:		# Start of code section
	li	$v0, 4					#System call code for Print String
	la	$a0, Prompt				#load address of prompt into $a0
	syscall						#print the prompt message
	li	$v0, 5					#system call code for Read Integer
	syscall						#reads the value of N into $v0
	beq	$v0, $zero, End 		#branch to end if $v0 == 0
	li	$t0, 1 					#load 1 into $t0
	bne $v0, $t0, invalid 		#show invalid prompt if response is not 1 or 0
	jal Inputs 					#gather coordinates
	jal Circle 					#calculate circle area and output
	jal Square 					#calculate square area and output
	jal Rectangle 				#calculate rectangle area and output
	b	main					#branch back to start
Inputs:
	#inputs
	#X1 in $f2
	li	$v0, 4			#System call code for Print String
	la	$a0, X1			#load address of prompt into $a0
	syscall				#print the X1 message
	li	$v0, 7			#system call code for Read Double
	syscall				#reads the value of N into $v0
	mov.d $f2, $f0 		#store in $f2
	#Y1 in $f4
	li	$v0, 4			#System call code for Print String
	la	$a0, Y1			#load address of prompt into $a0
	syscall				#print the Y1 message
	li	$v0, 7			#system call code for Read Double
	syscall				#reads the value of N into $v0
	mov.d  $f4, $f0		#store in $f4
	#X2 in $f6
	li	$v0, 4			#System call code for Print String
	la	$a0, X2			#load address of prompt into $a0
	syscall				#print the X2 message
	li	$v0, 7			#system call code for Read Double
	syscall				#reads the value of N into $v0
	mov.d  $f6, $f0		#store in $f6
	#Y2 in $f8
	li	$v0, 4			#System call code for Print String
	la	$a0, Y2			#load address of prompt into $a0
	syscall				#print the Y2 message
	li	$v0, 7			#system call code for Read Double
	syscall				#reads the value of N into $v0
	mov.d  $f8, $f0		#store in #f8
	jr	$ra 			#return from function
Xlength:
	#Xlength stored in $f20
	sub.d $f20, $f6, $f2 	#calculate XLength and store in $f20
	jr	$ra 				#return from function
Ylength:
	#Ylength stored in $f22
	sub.d $f22, $f8, $f4 	#calculate YLength and store in $f22
	jr	$ra 				#return from function
Length:
	#Length stored in $f24
	mul.d $f0, $f20, $f20 	#square XLength and store in $f0
	mul.d $f10, $f22, $f22 	#square YLength and store in $f10
	add.d $f24, $f0, $f10 	#calculate Length and store in $f24
	jr	$ra 				#return from function
Circle:
	addi $sp, $sp,-4
	sw $ra, 0($sp)				#put $ra into stack
	jal Xlength 				#calculate x length
	jal Ylength 				#calculate y length
	jal Length 					#calculate length of line squared
	#calculations
	li.d $f10, 3.1416
	mul.d $f12, $f10, $f24
	#output
	li	$v0, 4			#System call code for Print String
	la	$a0, CircleCalc	#load address of prompt into $a0
	syscall				#print the prompt message
	li	$v0, 3			#system call code for Print Double
	syscall				#print sum of integers
	lw $ra, 0($sp)
	addi $sp, $sp,4
	jr	$ra				#return from function
Square:
	addi $sp, $sp,-4
	sw $ra, 0($sp)
	jal Xlength 				#calculate x length
	jal Ylength 				#calculate y length
	jal Length 					#calculate length of line squared
	#calculations
	#Side squared is already stored in $f24
	#output
	li	$v0, 4			#System call code for Print String
	la	$a0, SquareCalc	#load address of prompt into $a0
	syscall				#print the prompt message
	li	$v0, 3			#system call code for Print Double
	mov.d $f12, $f24	#move value to be printed to $f12
	syscall				#print sum of integers
	lw $ra, 0($sp)
	addi $sp, $sp,4
	jr	$ra				#return from function
Rectangle:
	addi $sp, $sp,-4
	sw $ra, 0($sp)
	jal Xlength 				#calculate x length
	jal Ylength 				#calculate y length
	jal Length 					#calculate length of line squared
	#calculations
	mul.d $f12, $f20, $f22	#multiplies sides and stores in $f12
	#output
	li	$v0, 4				#System call code for Print String
	la	$a0, RectangleCalc	#load address of prompt into $a0
	syscall					#print the prompt message
	li	$v0, 3				#system call code for Print Double
	syscall					#print sum of integers
	lw $ra, 0($sp)
	addi $sp, $sp,4
	jr	$ra				#return from function
invalid:
	li	$v0, 4			#System call code for Print String
	la	$a0, Invalid	#load address of msg into $a0
	syscall				#print the string
	b   main
End:	
	li	$v0, 4		#System call code for Print String
	la	$a0, Bye		#load address of msg into $a0
	syscall				#print the string
	li	$v0, 10			#terminate program run and
	syscall				#return control to the system
# END OF PROGRAM
