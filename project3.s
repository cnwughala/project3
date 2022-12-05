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
	
sub_a:
	lw $t1, 0($sp)
	lb $t2, ($t1)
	addi $t1, 1
	beq $t1, 9, tabspace
	beq $t1, 32, tabspace
	
	jal sub_b
	
sub_b: