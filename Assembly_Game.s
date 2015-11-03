	.data
list:	.space 2048
size:	.word 512
buffer:	.space 20 	# Max input size
Isize:	.word 5		# Max input characters
star: 	.word 5
x: 		.word 0
y:		.word 0
z: 		.word 0

starting: 	.asciiz "Your starting location is ("
sep:		.asciiz " , "
closer:		.asciiz ")"
left:		.asciiz "l\n"
right:		.asciiz "r\n"
up:			.asciiz "u\n"
down:		.asciiz "d\n"
forward:	.asciiz "f\n"
backward:	.asciiz "b\n"
sleep:		.asciiz "s\n"
quit:		.asciiz "q\n"
newline:	.asciiz "\n\n"
omessage:	.asciiz "Welcome to the game! You are going to be put into a 8 x 8 x 8 board, you must find the diamond to win! You begin with (x) health. If you get bit by a snake you lose (x) health. There are burgers scattered thoughout the board that you may eat to regain health. The inputs that are acceptable are as followed:\n u: Move Up\n d: Move Down\n l: Move Left\n r: Move Right\n f: Move Forward\n b: Move Backwards\n s: Sleep\n q: Quit\n"
badinput:	.asciiz "THAT INPUT IS INVALID!!"
prompt:		.asciiz "Please enter your move: "
lp:			.asciiz "You went left"
rp:			.asciiz "You went right"
upr:		.asciiz "You went up"
dp: 		.asciiz "You went down"
fp: 		.asciiz "You went forward"
bp:			.asciiz "You went backwards"
qp:			.asciiz "You quit"
#rulesp:		.asciiz "Enter prompt for rules"

# Prompts for testarray
rmsg:		.asciiz "Enter row: "
cmsg:		.asciiz "Enter cloumn: "
lmsg:		.asciiz "Enter level: "
valp:		.asciiz "The value in this location is: "


	.text
main:
	lw $s0, size  # Load in array length
	la $s1, list # Load in list start
	li $t0, 0 # Elemant counter
	jal poparray
	lw $s1, star
	jal hidestar
	# Initialize Pointer Function
	li $a3, 0
	jal startingloc


	#jal testarray

	#la $a0, omessage # Print opening message
	#li $v0, 4
	#syscall

	#la $a0, newline
	#li $v0, 4
	#syscall

	# Enter funtion that tells starting location 
	# Jump to funtion that asks for action

	

	#la $a0, prompt	# Print prompt
	#li $v0, 4
	#syscall
	#la $a0, buffer
	#la $a1, Isize
	#li $v0, 8
	#syscall
	#la $a0, buffer
	#jal loadl

	li $v0, 10
	syscall

poparray:
	beq $t0, $s0, return
	li $v0, 42
	li $a1, 4
	syscall
	sw $a0, ($s1) # Put value in MemAddr $s1
	addi $s1, $s1, 4
	addi $t0, $t0, 1
	j poparray

hidestar:
	li, $a0, 1 # Lower bound for random placement
	li, $a1, 513 # Upper bound for random placement
	li $v0, 42
	syscall
	li $a1, 4
	mult $a0, $a1 # Mult placement by 4 for memory
	mflo $a0
	la $a1, list
	add $a1, $a1, $a0
	sw $s1, ($a1) # Store star in memory locatioin

	jr $ra

startingloc:
	li $v0, 42	# Random starting row
	li $a1, 8
	syscall
	addi $a0, $a0, 1
	sw $a0, x


	li $v0, 42	# Random starting Column
	li $a1, 8
	syscall
	addi $a0, $a0, 1
	sw $a0, y

	li $v0, 42	# Random starting level
	li $a1, 8
	syscall
	addi $a0, $a0, 1
	sw $a0, z

	la $a0, starting
	li $v0, 4
	syscall

	lw $a0, x
	li $v0, 1
	syscall

	la $a0, sep
	li $v0, 4
	syscall

	lw $a0, y
	li $v0, 1
	syscall

	la $a0, sep
	li $v0, 4
	syscall

	lw $a0, z
	li $v0, 1
	syscall

	la $a0, closer
	li $v0, 4
	syscall

	jr $ra

testarray:
	li $t6, 1
	la $s1, list
	la $a0, rmsg  # Collect row number for test
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	beq $v0, $zero, return

	sub $t0, $v0, $t6
	la $a0, cmsg	# Collect column number for test
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	beq $v0, $zero, return
	sub $t1, $v0, $t6

	la $a0, lmsg	# Collect level number for test
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	beq $v0, $zero, return
	sub $t2, $v0, $t6

	li $t3, 32
	mult $t0, $t3
	mflo $t0

	li $t3, 4
	mult $t1, $t3
	mflo $t1

	li $t3, 256
	mult $t2, $t3
	mflo $t2

	add $t0, $t0, $t1
	add $t0, $t0, $t2

	add $s1, $s1, $t0

	la $a0, valp
	li $v0, 4
	syscall

	lw $a0, ($s1)
	li $v0, 1
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	j testarray


loadl:
	la $a1, left
	j comparestr_l

loadr:
	la $a1, right
	j comparestr_r

loadu:
	la $a1, up
	j comparestr_u

loadd:
	la $a1, down
	j comparestr_d

loadf:
	la $a1, forward
	j comparestr_f

loadb:
	la $a1, backward
	j comparestr_b

loadq:
	la $a1, quit
	j comparestr_q

comparestr_l:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, loadr
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, goleft
	j comparestr_l

comparestr_r:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, loadu
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, goright
	j comparestr_r

comparestr_u:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, loadd
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, goup
	j comparestr_u

comparestr_d:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, loadf
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, godown
	j comparestr_d

comparestr_f:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, loadb
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, goforward
	j comparestr_f

comparestr_b:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, loadq
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, gobackward
	j comparestr_b

comparestr_q:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, noinput
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, goquit
	j comparestr_q

goleft:
	la $a0, lp
	li $v0, 4
	syscall

	jr $ra

goright:
	la $a0, rp
	li $v0, 4
	syscall

	jr $ra

goup:
	la $a0, upr
	li $v0, 4
	syscall

	jr $ra

godown:
	la $a0, dp
	li $v0, 4
	syscall

	jr $ra

goforward:
	la $a0, fp
	li $v0, 4
	syscall

	jr $ra

gobackward:
	la $a0, bp
	li $v0, 4
	syscall

	jr $ra

#spray:
#snake:
#sandwich:
#mustard:
#sleep:
#diamond:

noinput:
	la $a0, badinput
	li $v0, 4
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	la $a0, prompt	# Print prompt
	li $v0, 4
	syscall
	la $a0, buffer
	la $a1, Isize
	li $v0, 8
	syscall
	la $a0, buffer
	j loadl

goquit:
	la $a0, qp
	li $v0, 4
	syscall

	jr $ra

return:
	jr $ra



