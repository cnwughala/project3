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
	
	addi $sp, $sp, -16
	sw $t0, 12($sp)
	sw $t0, 4($sp)
	
	jal sub_a
	
	li $v0, 10
	syscall
	
sub_a:
	sw $ra, 8($sp)
	lw $t0, 12($sp)
aLoop:
	lb $t1, ($t0)
	beq $t1, 44, a_exit
	beq $t1, 10, a_exit
	beq $t1, 0, a_exit
	beq $t1, 9, tabspace
	beq $t1, 32, tabspace
	
	addi $t0, $t0, 1
	addi $t2, $t2, 1 #counter for length of legal input
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
	addi $t3, $t3, 1 #counter for length of starting tabs and spaces
	addi $t0, $t0, 1
	j aLoop
	
a_exit:
	move $s3, $t0
	lw $s2, 4($sp)
	add $s2, $s2, $t3
	sw $s2, 4($sp)
	
	jal sub_b
	beq $s6, $s7, noSlash
	
	move $a0, $t6
	syscall

	li $v0, 11
	la $a0, 47
	syscall
	
	li $v0, 1
	lw $a0, 0($sp)
	syscall
	
	beq $s8, $s7, nEnd
	j cEnd
	
noSlash:
	la $a0, 0($sp)
	syscall
	beq $s8, $s7, nEnd
	
cEnd:
	li $v0, 11
	la $a0, 44
	syscall
	move $t0, $s3
	sw $s3, 4($sp)
	addi $t0, $t0, 1
	add $t2, $zero, $zero
	addi $t3, $zero, 1
	add $t4, $zero, $zero
	add $t5, $zero, $zero
	add $t6, $zero, $zero
	add $t7, $zero, $zero
	add $t8, $zero, $zero
	add $s6, $zero, $zero

	j aLoop
	
nEnd:
	lw $ra, 8($sp)
	jr $ra
	
#-----------------------------------------------------------------------------------------#
	
sub_b:
	lw $t0, 4($sp)
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
	beq $s2, $t0, next
	addi $t0, $t0, -1
	lb $t1, ($t0)
	bge $t1, 97, lowercase
	bge $t1, 65, uppercase
	bge $t1, 48, number
	beq $t1, 32, tsCheck
	beq $t1, 9, tsCheck
	beq $s2, $t0, next
	j error
	
error:
	addi $s6, $zero, 1
	li $v0, 4
	addi $t4, $zero, 63
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
	bne $s8, $zero, enterEnding
	j commaEnding

next:
	beq $t6, 0, error
	li $v0, 1
	add $t4, $t8, $zero
	sw $t4, 0($sp)
	jr $ra
	
	