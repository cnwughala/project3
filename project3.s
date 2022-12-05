	.data
userInput: .space 1001

	.text
	.globl main
	
main:
	
	li $v0, 8
	la $a0, userInput
	li $a1, 1001
	syscall
	
	addi $s0, 4
	addi $s1, 35
	move $t0, $a0
	
	addi $sp, $sp, -1001
	
	jal sub_a
	
sub_a:
	lw $t1, (28)$sp
	add $s2, $t1, $zero
	
	jal sub_b
	
sub_b: