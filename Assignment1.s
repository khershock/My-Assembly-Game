	.data
hello_msg:	.asciiz "Hello Olivetian World!\n"

	.text

main:

	la $a0, hello_msg
	li $v0, 4
	syscall

	li $v0, 10
	syscall
