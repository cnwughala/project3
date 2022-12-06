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
	beq $t2, 9, lastTS
	beq $t2, 32, lastTS
	beq $t2, 44, a_exit

tabspace:
	move $s3, $t1
	bge $t3, 1, lastTS
	addi $t1, $t1, 1
	j aLoop
	
sub_a:
	lw $t1, 0($sp)
aLoop:
	lb $t2, ($t1)
	beq $t2, 44, a_exit
	beq $t2, 9, tabspace
	beq $t2, 32, tabspace
	ble $t2, 47, error
	bge $t2, 123, error
	beq $t2, 58, error
	beq $t2, 59, error
	beq $t2, 60, error
	beq $t2, 61, error
	beq $t2, 62, error
	beq $t2, 63, error
	beq $t2, 64, error
	beq $t2, 91, error
	
	bgt $t3, $s0, error
	addi $t1, $t1, 1
	addi $t3, $t3, 1
	bne $t2, 44, aLoop
	bne $t2, 10, aLoop
	bne $t2, 0, aLoop
	
a_exit:
	li $v0, 1
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

	jr $ra
	
sub_b:
