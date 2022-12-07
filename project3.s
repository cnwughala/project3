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
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	lw $t0, 4($sp)
aLoop:
	lb $t1, ($t0)
	beq $t1, 44, a_exit
	beq $t1, 10, a_exit
	beq $t1, 0, a_exit
	beq $t1, 9, tabspace
	beq $t1, 32, tabspace
	
	addi $t0, $t0, 1
	addi $t2, $t2, 1
	j aLoop
	
lastTS:
	lb $t1, ($t0)
	beq $t1, 44, a_exit
	beq $t1, 10, a_exit
	beq $t1, 0, a_exit
	addi $t0, $t0, 1
	beq $t1, 9, lastTS
	beq $t1, 32, lastTS
	j aLoop

tabspace:
	bge $t2, 1, lastTS
	addi $t3, $t3, 1
	addi $t0, $t0, 1
	j aLoop
	
a_exit:
	move $s3, $t1
	lw $s2, 4($sp)
	add $s2, $s2, $t3
	addi $sp, $sp, -4
	sw $s2, 0($sp)
	
	jal sub_b
	
	li $v0, 1
	syscall
	
	li $v0, 11
	la $a0, 47
	syscall
	
#-----------------------------------------------------------------------------------------#
	
sub_b:
	lw $t0, 0($sp)
bLoop:
	lb $t1, ($t0)
	beq $t1, 44, commaEnding
	beq $t1, 10, enterEnding
	beq $t1, 0, enterEnding
	addi $t0, $t0, 1
	j bLoop
	
commaEnding:
	addi $t0, $t0, -1
	lb $t1, ($t0)
	bge $t1, 97, lowercase
	bge $t1, 65, uppercase
	bge $t1, 48, number
	beq $t1, 44, error
	beq $s2, $t0, next
	j commaEnding
	
error:
	li $v0, 11
	addi $t5, $zero, 63
	jr $ra
	
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
	