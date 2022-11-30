	.data
userInput: .space 1001

	.text
	.globl main
	
main:
	li $sp, $sp, -32
	
	li $v0, 8
	la $a0, userInput
	li $a1, 1001
	syscall
	
	addi $s0, 4
	addi $s1, 35
	move $t0, $a0
	
	sw $sp, 0($t0)
	
sub_a:
	
	
sub_b: