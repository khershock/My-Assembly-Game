	.data
msg:	.asciiz "Please write an integer: "
num:	.word 0

	.text

main:

	la $a0, msg
	li $v0, 4
	
	syscall
	
	li $v0, 5
	syscall
	
	sw $v0, num
	lw $a0, num
	jal mult
	
	li $v0, 1
	lw $a0, num
	syscall
	
	li $v0, 10
	syscall
	
mult:
	sll $a0, $a0, 1
	jr $ra

	
	
