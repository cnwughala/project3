	.data
userInput: .space 1001

	.text
	.globl main
	
main:
	li $sp, $sp, -8
	
	li $v0, 8
	la $a0, userInput
	li $a1, 1001
	syscall
	
sub_a:
sub_b: