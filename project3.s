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
	beq $t2, 44, a_exit
	beq $t2, 10, a_exit
	beq $t2, 0, a_exit
	addi $t1, $t1, 1
	lb $t2, ($t1)
	beq $t2, 9, lastTS
	beq $t2, 32, lastTS
	

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
	beq $t2, 10, a_exit
	beq $t2, 0, a_exit
	beq $t2, 9, tabspace
	beq $t2, 32, tabspace
	ble $t2, 47, error
	bge $t2, 122, error
	beq $t2, 58, error
	beq $t2, 59, error
	beq $t2, 60, error
	beq $t2, 61, error
	beq $t2, 62, error
	beq $t2, 63, error
	beq $t2, 64, error
	beq $t2, 90, error
	beq $t2, 91, error
	beq $t2, 92, error
	beq $t2, 93, error
	beq $t2, 94, error
	beq $t2, 95, error
	beq $t2, 96, error
	
	addi $t1, $t1, 1
	addi $t3, $t3, 1
	bgt $t3, $s0, error
	
	j aLoop
	
a_exit:
	move $s4, $t1
	li $v0, 1
	add $a0, $t3, $zero
	syscall
	
	li $v0, 11
	la $a0, 47
	syscall
	addi $sp, $sp, 4
	addi $sp, $sp, -4
	sw $s4, 0($sp)
	jal sub_b
	
error:
	addi $s2, $zero, 1
	li $v0, 11 
	la $a0, 63
	syscall
	
sub_b:
	sub $s3, $s4, $t3
	move $t4, $s4
bLoop:
	lb $t2, ($t4)
	