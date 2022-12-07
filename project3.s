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
	addi $s7, $zero, 1
	move $t0, $a0
	
	addi $sp, $sp, -4
	sw $t0, 0($sp)
	
	jal sub_a
	addi $sp, $sp, 4
	
	li $v0, 10
	syscall
	
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
	move $s3, $t0
	lw $s2, 4($sp)
	add $s2, $s2, $t3
	addi $sp, $sp, -4
	sw $s2, 0($sp)
	
	jal sub_b
	move $a0, $t6
	syscall
	
	beq $s6, $s7, noSlash
	li $v0, 11
	la $a0, 47
	syscall
	
	li $v0, 1
	lw $a0, 0($sp)
	syscall	
	addi $sp, $sp, 4
	
	beq $s8, $s7, nEnd

noSlash:
	move $a0, $t6
	syscall
	addi $sp, $sp, 4
	
nEnd:
	addi $sp, $sp, 4
	lw $ra, 0($sp)
	jr $ra
	
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
	
enterEnding:
	addi $s8, $zero, 1
commaEnding:
	addi $t0, $t0, -1
	lb $t1, ($t0)
	bge $t1, 97, lowercase
	bge $t1, 65, uppercase
	bge $t1, 48, number
	beq $t1, 44, error
	beq $t1, 32, tsCheck
	beq $t1, 9, tsCheck
	beq $s2, $t0, next
	j error
	
error:
	addi $s6, $zero, 1
	li $v0, 11
	addi $t4, $zero, 63
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	jr $ra
	
tsCheck:
	bne $t6, 0, error
	bne $s8, $zero, enterEnding
	j commaEnding
	
lowercase:
	bge $t1, 122, error
	sub $t1, $t1, 87
	j base35	
	
uppercase:
	bge $t1, 90, error
	sub $t1, $t1, 55
	j base35

number:
	bge $t1, 58, error
	sub $t1, $t1, 48
	j base35

base35:
	beq $t5, $t6, addLoop
	multu $t1, $s1
	mflo $t7
	add $t1, $t7, $zero
	addi $t5, 1
	bne $t5, $t6, base35
addLoop:
	sub $t5, $t5, $t5
	add $t8, $t1, $t8
	addi $t6, 1
	bgt $t6, $s0, error
	beq $s2, $t0, next 
	bne $s8, $zero, enterEnding
	j commaEnding

next:
	li $v0, 1
	add $t4, $t8, $zero
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	jr $ra
	
	