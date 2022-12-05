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
	
	addi $sp, $sp, -4
	sw $t0, ($sp)
	jal sub_a
	
sub_a:
	lb $t1, ($t0)
	addi $t9, 1
	sb $t1, ($sp)
	bne $t1, 44, sub_a
	
	jal sub_b
	
sub_b: