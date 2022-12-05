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
	sw $t0, 0($sp)
	jal sub_a
	
tabspace:
	bge $t3, 1, error
	addi $a0, $a0, 1
	move $t1, $a0
	j aLoop
sub_a:
	lw $t1, 0($sp)
aLoop:
	lb $t2, ($t1)
	beq $t1, 9, tabspace
	beq $t1, 32, tabspace
	addi $t1, 1
	addi $t3, 1
	bne $t2, 44, aLoop
	
	jal sub_b
	
sub_b:

