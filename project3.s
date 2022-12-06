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
	

tabspace:
	bge $t3, 1, lastTS
	addi $t8, $t8, 1
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
	
	li $v0, 1
	add $a0, $t3, $zero
	syscall
	
	li $v0, 11
	la $a0, 47
	syscall
	
	addi $sp, $sp, 4
	addi $sp, $sp, -4
	add $s3, $t0, $t8
	sw $s3, 0($sp)
	jal sub_b

	
error:
	addi $s2, $zero, 1
	li $v0, 11 
	la $a0, 63
	syscall
	
	li $v0, 10
	syscall
sub_b:
	
	beq $a0, 63, next
	lw $t5, 0($sp)
	add $t1, $t5, $t3
	
bLoop:
	beq $t5, $t1, b_exit
	addi $t1, $t1, -1
	lb $t2, ($t1)
	bge $t2, 97, lowercase
	bge $t2, 65, uppercase
	bge $t2, 48, number
	j bLoop
	
lowercase:
	sub $t2, $t2, 87
	j base35	
	
uppercase:
	sub $t2, $t2, 55
	j base35

number:
	sub $t2, $t2, 48
	j base35

base35:
	beq $t7, $t4, addLoop
	multu $t2, $s1
	mflo $t9
	add $t2, $t9, $zero
	addi $t7, 1
	bne $t7, $t4, base35

addLoop:
	sub $t7, $t7, $t7
	add $t6, $t2, $t6
	addi $t4, 1
	j bLoop

b_exit:
	li $v0, 1
	move $a0, $t6
	syscall
	
next:
	addi $sp, $sp, -4
	sw $t6, 4($sp)
	
	li $v0, 10
	syscall