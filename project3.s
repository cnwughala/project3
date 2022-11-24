	.data
userInput: .space 1001

	.text
	.globl main
	
main:
	li $v0, 8
	la $a0, userInput
	li $a1, 1001
	syscall
	
	