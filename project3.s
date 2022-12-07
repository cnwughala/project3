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
	

	
sub_a:
	lw $t0, 0($sp)
aLoop:
	lb $t1, ($t0)
	beq $t1, 44, a_exit
	beq $t1, 10, a_exit
	beq $t1, 0, a_exit
	beq $t1, 9, tabspace
	beq $t1, 32, tabspace
	
	addi $t1, $t1, 1
	addi $t2, $t2, 1
	
	j aLoop
	
lastTS:
	lb $t1, ($t0)
	beq $t1, 44, a_exit
	beq $t1, 10, a_exit
	beq $t1, 0, a_exit
	beq $t1, 9, lastTS
	beq $t1, 32, lastTS
	addi $t1, $t1, 1

tabspace:
	bge $t2, 1, lastTS
	addi $t8, $t8, 1
	addi $t1, $t1, 1
	j aLoop
	
a_exit:
	
	sw $t1, 0($sp)
	li $v0, 1
	add $a0, $t3, $zero
	syscall
	
	li $v0, 11
	la $a0, 47
	syscall
	
	add $s3, $t0, $t8
	sw $s3, 8($sp)
	jal sub_b

	
error:
	li $v0, 11 
	la $a0, 63
	syscall
	
#-----------------------------------------------------------------------------------------#
	
sub_b:
	beq $a0, 63, next
	lw $t5, 8($sp)
	add $t1, $t5, $t3
	sub $t7, $t7, $t7
	sub $t4, $t4, $t4
	sub $t6, $t6, $t6
	sub $t2, $t2, $t2
	
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
	sw $t6, 4($sp)
	addi $t4, 1
	j bLoop

b_exit:
	li $v0, 1
	move $a0, $t6
	syscall
	lw $t1, 12($sp)
	lw $t2, 0($sp)
	bne $t2, 44, ending
	
next:
	li $v0, 11
	la $a0, 44
	syscall
	jal sub_a
	
ending:
	li $v0, 10
	syscall
	