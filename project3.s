	.data
userInput: .space 1001
	.text
	.globl main
	
main:
	
	li $v0, 8
	la $a0, userInput
	li $a1, 1001
	syscall
	
	addi $s0, $zero, 4
	addi $s1, $zero, 35
	move $t0, $a0
	
	addi $sp, $sp, -4
	sw $t0, 0($sp)
	jal sub_a
	
lastTS:
	addi $t1, $t1, 1
	lb $t2, ($t1)
	beq $t1, 9, lastTS
	beq $t1, 32, lastTS
	beq $t1, 44, a_exit
tabspace:
	bge $t3, 1, lastTS
	j aLoop
sub_a:
	lw $t1, 0($sp)
aLoop:
	lb $t2, ($t1)
	beq $t1, 9, tabspace
	beq $t1, 32, tabspace
	bgt $t3, $s0, error
	addi $t1, $zero, 1
	addi $t3, $zero, 1
	bne $t2, 44, aLoop
a_exit:
	li $v0, 1
	addi $t3, $zero, -1
	add $a0, $t3, $zero
	syscall
	
	li $v0, 11
	la $a0, 47
	syscall
	
	jal sub_b
	
error:
	addi $s2, $zero, 1
	li $v0, 11
	la $a0, 63
	syscall

	jal sub_b
	
sub_b:

