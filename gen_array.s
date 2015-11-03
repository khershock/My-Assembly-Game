	.data
list:	.space 400
stew: .word 100
msg: .asciiz "Please enter row (1-10): "
msg1: .asciiz "Please enter column (1-10): "
val: .asciiz "The value in that index is: "
nline: .asciiz "\n\n"

	.text

main:
	lw $s0, stew
	la $s1, list
	li $t0, 0
	jal array

	jal arrayindex
	li $v0, 10
	syscall


array:
	beq $t0, $s0, return
	
	li $v0, 42
	li $a1, 9
	syscall

	sw $a0, ($s1)
	addi $t0, $t0,  1
	addi $s1, $s1, 4
	j array

return:
	jr $ra

arrayindex:
	li $t9, 1
	la $s1, list
	la $a0, msg
	li $v0, 4

	syscall

	li $v0, 5
	syscall
	beq $v0, $zero, return

	sub $t0, $v0, $t9
	la $a0, msg1
	li $v0, 4
	syscall

	li $v0, 5
	syscall
	beq $v0, $zero, return
	sub $t1, $v0, $t9


	li $t3, 40
	mult $t0, $t3
	mflo $t0

	li $t3, 4
	mult $t1, $t3
	mflo $t1

	add $t0, $t0, $t1
	add $s1, $s1, $t0

	la $a0, val
	li $v0, 4
	syscall

	lw $a0, ($s1)
	li $v0, 1
	syscall

	la $a0, nline
	li $v0, 4
	syscall

	j arrayindex










	



