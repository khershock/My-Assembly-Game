	.data
list:			.space 2048
size:			.word 512
buffer:			.space 20 	# Max input size
Isize:			.word 5		# Max input characters
star: 			.word 5
x: 				.word 0
y:				.word 0
z: 				.word 0
sandwiches:		.word 0		# 5 Max in inventory
mustard:		.word 0		# 2 Max in inventory
mustardworth:	.word 0
health:			.word 10
time1:			.word 0
time2:			.word 0
sandeaten:		.word 0
musteaten:		.word 0
snakebites:		.word 0
totalmoves:		.word 0

#Title and Names
title: 		.asciiz	"ASSEMBLY ADVENTURES: QUEST FOR THE BLOOD DIAMOND\n"
by:			.asciiz "Created By:\n"
kory:		.asciiz	"Kory Hershock\n"
grant:		.asciiz	"Grant Arras\n"
ethan:		.asciiz	"Ethan Hicks\n"
jacob:		.asciiz "Jacob Reinsmith\n"
sep2:		.asciiz "#################################################\n"

# List of Commands
fleft:		.asciiz "q\n"
fright:		.asciiz "e\n"
left:		.asciiz "a\n"
right:		.asciiz "d\n"
bleft:		.asciiz "z\n"
bright:		.asciiz "c\n"
up:			.asciiz "r\n"
down:		.asciiz "f\n"
forward:	.asciiz "w\n"
backward:	.asciiz "x\n"
sleep:		.asciiz "s\n"

quit:		.asciiz "p\n"
inventory: 	.asciiz "i\n"
checkh:		.asciiz	"h\n"
yes:		.asciiz "y\n"
no:			.asciiz "n\n"
rules:		.asciiz "j\n"
eat:		.asciiz	"u\n"
emustard:	.asciiz	"o\n"

easy:		.asciiz "ez\n"
medium:		.asciiz "md\n"
hard:		.asciiz "hd\n"


# Strings used by game
difficulty:	.asciiz "Please Enter Difficulty ez, md, or hd: "
starting: 	.asciiz "Your starting location is ("
newlocp:	.asciiz "Your current location is ("
sep:		.asciiz " , "
closer:		.asciiz ")"
newline:	.asciiz "\n\n"
singleline:	.asciiz "\n"
omessage:	.asciiz "\nWelcome to the game! You are going to be put into a 8 x 8 x 8 board, you must find the diamond to win! You begin with 10 health points. If you get bit by a snake while sleeping you lose 3 health. There are sandwiches scattered thoughout the board that you may eat to regain 2 health. The inputs that are acceptable are as followed:\n\n q = Forward Left\n w = Forward\n e = Forward Right\n a = Left\n d = Right\n z = Backwards Left\n x = Backwards\n c = Backwards Right\n r = Up\n f = Down\n s = Sleep\n i = Inventory\n u = Eat Sandwich\n o = Eat Mustard Sandwich\n h = Check Health\n j = Rules\n p = Quit\n"
badinput:	.asciiz "THAT INPUT IS INVALID!!"
bound:		.asciiz "I'm sorry, you can not move that way!"
prompt:		.asciiz "Please enter your next command: "
lp:			.asciiz "You went left"
rp:			.asciiz "You went right"
upr:		.asciiz "You went up"
dp: 		.asciiz "You went down"
fp: 		.asciiz "You went forward"
bp:			.asciiz "You went backwards"
qp:			.asciiz "You quit"
snakep:		.asciiz "Your new HP is: "
sandp:		.asciiz "You found a sandwich! It has been added to your inventory."
sandp2:		.asciiz "You now have "
sandp3:		.asciiz	" sandwiches in your inventory."
maxsand:	.asciiz "Sorry, but you can only carry 5 sandwhiches at once, eat some to make room."
mustp:		.asciiz "You found some mustard! It has been added to your inventory."
mustp2:		.asciiz "You now have "
mustp3:		.asciiz	" mustards in your inventory."
maxmust:	.asciiz "Sorry, but you can only carry 2 mustards at once, eat some to make room."
sp:			.asciiz "You are sleeping..."
safep:		.asciiz "There is nothing in this location."
diamondp:	.asciiz "YOU FOUND THE DIAMOND! YOU WON!"
hpp:		.asciiz "Your new HP is: "
deadp:		.asciiz "You died :("
newgamep:	.asciiz "Would you like to start a new game? (y or n): "
safesleep:	.asciiz "You woke up safely, recieved 2 HP. Your HP is now at: "
snakesleep:	.asciiz "You woke up to a SNAKE! Lose 3 HP!"
healthfullp:.asciiz "You now have FULL health!"
eatp:		.asciiz	"You ate a sandwich, your HP is now: "
nosandp:	.asciiz	"You are out of sandwiches, Your HP is still "
checkhp:	.asciiz	"Your health is currently at "
invcheckp:	.asciiz "You have the following in your inventory:"
minv:		.asciiz	"Mustards: "
sinv:		.asciiz "Sandwiches: "
eatmustp:	.asciiz "You ate a mustard sandwich, your HP is now "
nomustp:	.asciiz "You are all out of mustard, your HP is still "
nomustsandp:.asciiz	"You have no sandwiches left to put mustard on."
gamestatp:	.asciiz "Your game statistics are the following:"
movesp:		.asciiz	"Total Moves: "
sandeatp:	.asciiz	"Sandwiches Eaten: "
musteatp:	.asciiz	"Mustard Eaten: "
snakebitep:	.asciiz	"Total Snakebites: "
timep:		.asciiz	"Time Played: "

rulesp:		.asciiz "You can choose the following commands:\n q = Forward Left\n w = Forward\n e = Forward Right\n a = Left\n d = Right\n z = Backwards Left\n x = Backwards\n c = Backwards Right\n r = Up\n f = Down\n s = Sleep\n i = Inventory\n u = Eat Sandwich\n o = Eat Mustard Sandwich\n h = Check Health\n j = Rules\n p = Quit\n"



	.text
main:
	li $t0, 10
	sw $t0, health		# Reset Health on new game

	li $t0, 0
	sw $t0, sandwiches # Reset sandwhiches on new game
	sw $t0, mustard		# Reset Mustard on new game
	sw $t0, musteaten
	sw $t0, sandeaten
	sw $t0, totalmoves
	sw $t0, snakebites

	lw $s0, size  		# Load in array length
	la $s1, list 		# Load in list start
	li $t0, 0 			# Elemant counter
	jal poparray
	lw $s0, size  		# Load in array length
	la $s1, list 		# Load in list start
	li $v0, 30
	syscall
	sw $a1, time1
	la $a0, sep2
	li $v0, 4
	syscall
	la $a0, title
	li $v0, 4
	syscall
	la $a0, by
	li $v0, 4
	syscall
	la $a0, kory
	li $v0, 4
	syscall
	la $a0, grant
	li $v0, 4
	syscall
	la $a0, ethan
	li $v0, 4
	syscall
	la $a0, jacob
	li $v0, 4
	syscall
	la $a0, sep2
	li $v0, 4
	syscall

	la $a0, omessage 	# Print opening message
	li $v0, 4
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	la $a0, difficulty
	li $v0, 4
	syscall
	la $a0, buffer
	la $a1, size
	li $v0, 8
	syscall
	la $a0, buffer
	li $t0, 0 			# Elemant counter
	jal loadeasy
	
	lw $s1, star
	jal hidestar
	li $a3, 0			# Initialize Pointer Function
	
	
	la $a0, newline
	li $v0, 4
	syscall
	jal startingloc		# Enter funtion that tells starting location
	la $a0, newline
	li $v0, 4
	syscall
	la $a0, prompt		# Print prompt
	li $v0, 4
	syscall
	la $a0, buffer
	la $a1, Isize
	li $v0, 8
	syscall
	la $a0, buffer
	jal loadl
	li $v0, 30
	syscall
	sw $a1, time2

	jal gamestats
	jal newgame

	li $v0, 10
	syscall

poparray:
	li $t1, 3
	beq $t0, $s0, return
	sw $t1, ($s1) # Put value in MemAddr $s1
	addi $s1, $s1, 4
	addi $t0, $t0, 1
	j poparray

easyarraysandwich:
	li $t1, 1
	li $t2, 154 	# Place 154 sandwiches in easy game mode
	beq $t0, $t2, ecounterreset

	li $v0, 42
	li $a1, 513
	syscall
	li $a1, 4
	mult $a0, $a1
	mflo $a0

	la $a1, list
	add $a1, $a1, $a0
	lw $t3, ($a1)
	beq $t3, $t1, easyarraysandwich
	sw $t1, ($a1)

	addi $t0, $t0, 1

	j easyarraysandwich

ecounterreset:
	li $t0, 0
	j easyarraymusturd

easyarraymusturd:

	li $t1, 2 	# Value of Mustard
	li $t2, 51 	# Place 51 mustard in easy game mode
	li $t4, 1 	# Value of sandwich
	beq $t0, $t2, return

	li $v0, 42
	li $a1, 513
	syscall
	li $a1, 4
	mult $a0, $a1
	mflo $a0

	la $a1, list
	add $a1, $a1, $a0
	lw $t3, ($a1)
	beq $t3, $t1, easyarraymusturd
	beq $t3, $t4, easyarraymusturd
	sw $t1, ($a1)
	add $t0, $t0, 1

	j easyarraymusturd

medarraysandwich:
	li $t1, 1
	li $t2, 103 	# Place 103 sandwiches in medium game mode
	beq $t0, $t2, medcounterreset

	li $v0, 42
	li $a1, 513
	syscall
	li $a1, 4
	mult $a0, $a1
	mflo $a0

	la $a1, list
	add $a1, $a1, $a0
	lw $t3, ($a1)
	beq $t3, $t1, medarraysandwich
	sw $t1, ($a1)

	add $t0, $t1, $t0

	j medarraysandwich

medcounterreset:
	li $t0, 0
	j medarraymusturd

medarraymusturd:
	li $t1, 2
	li $t2, 34 	# Place 34 mustard in medium game mode
	li $t4, 1
	beq $t0, $t2, return

	li $v0, 42
	li $a1, 513
	syscall
	li $a1, 4
	mult $a0, $a1
	mflo $a0

	la $a1, list
	add $a1, $a1, $a0
	lw $t3, ($a1)
	beq $t3, $t1, medarraymusturd
	beq $t3, $t4, medarraymusturd
	sw $t1, ($a1)
	add $t0, $t4, $t0

	j medarraymusturd

hardarraysandwich:
	li $t1, 1
	li $t2, 51 	# Place 51 sandwiches in hard game mode
	beq $t0, $t2, hcounterreset

	li $v0, 42
	li $a1, 513
	syscall
	li $a1, 4
	mult $a0, $a1
	mflo $a0

	la $a1, list
	add $a1, $a1, $a0
	lw $t3, ($a1)
	beq $t3, $t1, hardarraysandwich
	sw $t1, ($a1)

	add $t0, $t1, $t0

	j hardarraysandwich

hcounterreset:
	li $t0, 0
	j hardarraymusturd

hardarraymusturd:
	li $t1, 2
	li $t2, 17 	# Place 17 mustard in hard game mode
	li $t4, 1
	beq $t0, $t2, return

	li $v0, 42
	li $a1, 513
	syscall
	li $a1, 4
	mult $a0, $a1
	mflo $a0

	la $a1, list
	add $a1, $a1, $a0
	lw $t3, ($a1)
	beq $t3, $t1, hardarraymusturd
	beq $t3, $t4, hardarraymusturd
	sw $t1, ($a1)
	add $t0, $t4, $t0

	j hardarraymusturd

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
	lw $t5, ($a1)
	li $t1, 1
	li $t2, 2
	beq $t5, $t1, hidestar
	beq $t5, $t2, hidestar
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

loadl:
	la $a1, left
	j comparestr_l

loadeasy:
	la $a1, easy
	j comparestr_easy

loadmed:
	la $a1, medium
	j comparestr_medium

loadhard:
	la $a1, hard
	j comparestr_hard

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

loads:
	la $a1, sleep
	j comparestr_s

loady:
	la $a1, yes
	j comparestr_y

loadn:
	la $a1, no
	j comparestr_n

loadfl:
	la $a1, fleft
	j comparestr_fl

loadfr:
	la $a1, fright
	j comparestr_fr

loadbl:
	la $a1, bleft
	j comparestr_bl

loadbr:
	la $a1, bright
	j comparestr_br

loadi:
	la $a1, inventory
	j comparestr_i

loadeat:
	la $a1, eat
	j comparestr_eat

loademust:
	la $a1, emustard
	j comparestr_must

loadhealth:
	la $a1, checkh
	j comparestr_health

loadrules:
	la $a1, rules
	j comparestr_rules

comparestr_easy:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, loadmed
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, easyarraysandwich
	j comparestr_easy

comparestr_medium:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, loadhard
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, medarraysandwich
	j comparestr_medium

comparestr_hard:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, noinputdif
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, hardarraysandwich
	j comparestr_hard

comparestr_y:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, loadn
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, main
	j comparestr_y

comparestr_n:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, noinput
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, goquit
	j comparestr_n

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
	bne $t0, $t1, loads
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, gobackward
	j comparestr_b

comparestr_s:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, loadfl
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, gosleep
	j comparestr_s

comparestr_fl:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, loadfr
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, goforwardleft
	j comparestr_fl

comparestr_fr:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, loadbl
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, goforwardright
	j comparestr_fr

comparestr_bl:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, loadbr
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, gobackleft
	j comparestr_bl

comparestr_br:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, loadi
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, gobackright
	j comparestr_br

comparestr_i:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, loadeat
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, invcheck
	j comparestr_i

comparestr_eat:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, loademust
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, eatsand
	j comparestr_eat

comparestr_must:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, loadhealth
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, eatmust
	j comparestr_must

comparestr_health:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, loadrules
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, checkhealth
	j comparestr_health

comparestr_rules:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, loadq
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, viewrules
	j comparestr_rules

comparestr_q:
	lbu $t0, ($a0)
	lbu $t1, ($a1)
	bne $t0, $t1, noinput
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	beq $t0, $zero, goquit
	j comparestr_q

goleft:
	la $s1, list
	li $t1, 1
	li $t2, 32
	li $t3, 4
	li $t4, 256
	lw $a0, x
	lw $a1, y
	lw $a2, z
	lw $a3, health
	sub $a1, $a1, $t1			# Move player coordinates left 1
	blt $a1, $t1, outofbounds
	sw $a1, y 					# Store new location to y
	sub $a3, $a3, $t1			# Lose 1 HP
	beq $a3, $zero, dead
	sw $a3, health
	sub $a0, $a0, $t1	
	sub $a1, $a1, $t1			# Set up values for new location
	sub $a2, $a2, $t1

	lw $t0, totalmoves
	add $t0, $t1, $t0
	sw $t0, totalmoves

	mult $a0, $t2
	mflo $a0

	mult $a1, $t3
	mflo $a1

	mult $a2, $t4
	mflo $a2

	add $a0, $a0, $a1
	add $a0, $a0, $a2

	add $s1, $s1, $a0
	lw $a0, ($s1)

	li $t1, 0			# Value of snake
	li $t2, 1 			# Value of sandwich
	li $t3, 2 			# Value of mustard
	li $t4, 3 			# Value of Safe
	li $t5, 5 			# Value of Diamond

	beq $a0, $t1, foundsnake
	beq $a0, $t2, foundsandwich
	beq $a0, $t3, foundmustard
	beq $a0, $t4, foundsafe
	beq $a0, $t5, founddiamond

goright:
	la $s1, list
	li $t1, 1
	li $t2, 32
	li $t3, 4
	li $t4, 256
	li $t5, 8
	lw $a0, x
	lw $a1, y
	lw $a2, z
	lw $a3, health
	add $a1, $a1, $t1			# Move player coordinates right 1
	bgt $a1, $t5, outofbounds	# Jump if out of bounds
	sw $a1, y 					# Store new location to y
	sub $a3, $a3, $t1			# Lose 1 HP
	beq $a3, $zero, dead
	sw $a3, health
	sub $a0, $a0, $t1	
	sub $a1, $a1, $t1			# Set up values for new location
	sub $a2, $a2, $t1

	lw $t0, totalmoves
	add $t0, $t1, $t0
	sw $t0, totalmoves

	mult $a0, $t2
	mflo $a0

	mult $a1, $t3
	mflo $a1

	mult $a2, $t4
	mflo $a2

	add $a0, $a0, $a1
	add $a0, $a0, $a2

	add $s1, $s1, $a0
	lw $a0, ($s1)

	li $t1, 0			# Value of snake
	li $t2, 1 			# Value of sandwich
	li $t3, 2 			# Value of mustard
	li $t4, 3 			# Value of Safe
	li $t5, 5 			# Value of Diamond

	beq $a0, $t1, foundsnake
	beq $a0, $t2, foundsandwich
	beq $a0, $t3, foundmustard
	beq $a0, $t4, foundsafe
	beq $a0, $t5, founddiamond

goup:
	la $s1, list
	li $t1, 1
	li $t2, 32
	li $t3, 4
	li $t4, 256
	li $t5, 8
	lw $a0, x
	lw $a1, y
	lw $a2, z
	lw $a3, health
	add $a2, $a2, $t1			# Move player coordinates up 1
	bgt $a2, $t5, outofbounds	# Jump if out of bounds
	sw $a2, z 					# Store new location to z
	sub $a3, $a3, $t1			# Lose 1 HP
	beq $a3, $zero, dead
	sw $a3, health
	sub $a0, $a0, $t1	
	sub $a1, $a1, $t1			# Set up values for new location
	sub $a2, $a2, $t1

	lw $t0, totalmoves
	add $t0, $t1, $t0
	sw $t0, totalmoves

	mult $a0, $t2
	mflo $a0

	mult $a1, $t3
	mflo $a1

	mult $a2, $t4
	mflo $a2

	add $a0, $a0, $a1
	add $a0, $a0, $a2

	add $s1, $s1, $a0
	lw $a0, ($s1)

	li $t1, 0			# Value of snake
	li $t2, 1 			# Value of sandwich
	li $t3, 2 			# Value of mustard
	li $t4, 3 			# Value of Safe
	li $t5, 5 			# Value of Diamond

	beq $a0, $t1, foundsnake
	beq $a0, $t2, foundsandwich
	beq $a0, $t3, foundmustard
	beq $a0, $t4, foundsafe
	beq $a0, $t5, founddiamond

godown:
	la $s1, list
	li $t1, 1
	li $t2, 32
	li $t3, 4
	li $t4, 256
	lw $a0, x
	lw $a1, y
	lw $a2, z
	lw $a3, health
	sub $a2, $a2, $t1			# Move player coordinates down 1
	blt $a2, $t1, outofbounds
	sw $a2, z 					# Store new location to z
	sub $a3, $a3, $t1			# Lose 1 HP
	beq $a3, $zero, dead
	sw $a3, health
	sub $a0, $a0, $t1	
	sub $a1, $a1, $t1			# Set up values for new location
	sub $a2, $a2, $t1

	lw $t0, totalmoves
	add $t0, $t1, $t0
	sw $t0, totalmoves

	mult $a0, $t2
	mflo $a0

	mult $a1, $t3
	mflo $a1

	mult $a2, $t4
	mflo $a2

	add $a0, $a0, $a1
	add $a0, $a0, $a2

	add $s1, $s1, $a0
	lw $a0, ($s1)

	li $t1, 0			# Value of snake
	li $t2, 1 			# Value of sandwich
	li $t3, 2 			# Value of mustard
	li $t4, 3 			# Value of Safe
	li $t5, 5 			# Value of Diamond

	beq $a0, $t1, foundsnake
	beq $a0, $t2, foundsandwich
	beq $a0, $t3, foundmustard
	beq $a0, $t4, foundsafe
	beq $a0, $t5, founddiamond

goforward:
	la $s1, list
	li $t1, 1
	li $t2, 32
	li $t3, 4
	li $t4, 256
	li $t5, 8
	lw $a0, x
	lw $a1, y
	lw $a2, z
	lw $a3, health
	add $a0, $a0, $t1			# Move player coordinates forward 1
	bgt $a0, $t5, outofbounds	# Jump if out of bounds
	sw $a0, x 					# Store new location to x
	sub $a3, $a3, $t1			# Lose 1 HP
	beq $a3, $zero, dead
	sw $a3, health
	sub $a0, $a0, $t1	
	sub $a1, $a1, $t1			# Set up values for new location
	sub $a2, $a2, $t1

	lw $t0, totalmoves
	add $t0, $t1, $t0
	sw $t0, totalmoves

	mult $a0, $t2
	mflo $a0

	mult $a1, $t3
	mflo $a1

	mult $a2, $t4
	mflo $a2

	add $a0, $a0, $a1
	add $a0, $a0, $a2

	add $s1, $s1, $a0
	lw $a0, ($s1)

	li $t1, 0			# Value of snake
	li $t2, 1 			# Value of sandwich
	li $t3, 2 			# Value of mustard
	li $t4, 3 			# Value of Safe
	li $t5, 5 			# Value of Diamond

	beq $a0, $t1, foundsnake
	beq $a0, $t2, foundsandwich
	beq $a0, $t3, foundmustard
	beq $a0, $t4, foundsafe
	beq $a0, $t5, founddiamond

gobackward:
	la $s1, list
	li $t1, 1
	li $t2, 32
	li $t3, 4
	li $t4, 256
	lw $a0, x
	lw $a1, y
	lw $a2, z
	lw $a3, health
	sub $a0, $a0, $t1			# Move player coordinates backwards 1
	blt $a0, $t1, outofbounds
	sw $a0, x 					# Store new location to x
	sub $a3, $a3, $t1			# Lose 1 HP
	beq $a3, $zero, dead
	sw $a3, health
	sub $a0, $a0, $t1	
	sub $a1, $a1, $t1			# Set up values for new location
	sub $a2, $a2, $t1

	lw $t0, totalmoves
	add $t0, $t1, $t0
	sw $t0, totalmoves

	mult $a0, $t2
	mflo $a0

	mult $a1, $t3
	mflo $a1

	mult $a2, $t4
	mflo $a2

	add $a0, $a0, $a1
	add $a0, $a0, $a2

	add $s1, $s1, $a0
	lw $a0, ($s1)

	li $t1, 0			# Value of snake
	li $t2, 1 			# Value of sandwich
	li $t3, 2 			# Value of mustard
	li $t4, 3 			# Value of Safe
	li $t5, 5 			# Value of Diamond

	beq $a0, $t1, foundsnake
	beq $a0, $t2, foundsandwich
	beq $a0, $t3, foundmustard
	beq $a0, $t4, foundsafe
	beq $a0, $t5, founddiamond

goforwardleft:
	la $s1, list
	li $t1, 1
	li $t2, 32
	li $t3, 4
	li $t4, 256
	li $t5, 8
	lw $a0, x
	lw $a1, y
	lw $a2, z
	lw $a3, health
	add $a0, $a0, $t1			# Move player coordinates forward 1
	bgt $a0, $t5, outofbounds	# Jump if out of bounds
	sub $a1, $a1, $t1			# Move player coordinates left 1
	blt $a1, $t1, outofbounds
	sw $a0, x 					# Store new location to x
	
	sw $a1, y 					# Store new location to y
	sub $a3, $a3, $t1			# Lose 1 HP
	beq $a3, $zero, dead
	sw $a3, health
	sub $a0, $a0, $t1	
	sub $a1, $a1, $t1			# Set up values for new location
	sub $a2, $a2, $t1

	lw $t0, totalmoves
	add $t0, $t1, $t0
	sw $t0, totalmoves

	mult $a0, $t2
	mflo $a0

	mult $a1, $t3
	mflo $a1

	mult $a2, $t4
	mflo $a2

	add $a0, $a0, $a1
	add $a0, $a0, $a2

	add $s1, $s1, $a0
	lw $a0, ($s1)

	li $t1, 0			# Value of snake
	li $t2, 1 			# Value of sandwich
	li $t3, 2 			# Value of mustard
	li $t4, 3 			# Value of Safe
	li $t5, 5 			# Value of Diamond

	beq $a0, $t1, foundsnake
	beq $a0, $t2, foundsandwich
	beq $a0, $t3, foundmustard
	beq $a0, $t4, foundsafe
	beq $a0, $t5, founddiamond

goforwardright:
	la $s1, list
	li $t1, 1
	li $t2, 32
	li $t3, 4
	li $t4, 256
	li $t5, 8
	lw $a0, x
	lw $a1, y
	lw $a2, z
	lw $a3, health
	add $t6, $a0, $t1			# Move player coordinates forward 1
	bgt $t6, $t5, outofbounds	# Jump if out of bounds
	add $a1, $a1, $t1			# Move player coordinates right 1
	bgt $a1, $t5, outofbounds
	add $a0, $a0, $t1
	sw $a0, x 					# Store new location to x
	
	sw $a1, y 					# Store new location to y
	sub $a3, $a3, $t1			# Lose 1 HP
	beq $a3, $zero, dead
	sw $a3, health
	sub $a0, $a0, $t1	
	sub $a1, $a1, $t1			# Set up values for new location
	sub $a2, $a2, $t1

	lw $t0, totalmoves
	add $t0, $t1, $t0
	sw $t0, totalmoves

	mult $a0, $t2
	mflo $a0

	mult $a1, $t3
	mflo $a1

	mult $a2, $t4
	mflo $a2

	add $a0, $a0, $a1
	add $a0, $a0, $a2

	add $s1, $s1, $a0
	lw $a0, ($s1)

	li $t1, 0			# Value of snake
	li $t2, 1 			# Value of sandwich
	li $t3, 2 			# Value of mustard
	li $t4, 3 			# Value of Safe
	li $t5, 5 			# Value of Diamond

	beq $a0, $t1, foundsnake
	beq $a0, $t2, foundsandwich
	beq $a0, $t3, foundmustard
	beq $a0, $t4, foundsafe
	beq $a0, $t5, founddiamond
gobackleft:
	la $s1, list
	li $t1, 1
	li $t2, 32
	li $t3, 4
	li $t4, 256
	li $t5, 8
	lw $a0, x
	lw $a1, y
	lw $a2, z
	lw $a3, health
	sub $a0, $a0, $t1			# Move player coordinates backwards 1
	blt $a0, $t1, outofbounds	# Jump if out of bounds
	sub $a1, $a1, $t1			# Move player coordinates left 1
	blt $a1, $t1, outofbounds
	sw $a0, x 					# Store new location to x
	
	sw $a1, y 					# Store new location to y
	sub $a3, $a3, $t1			# Lose 1 HP
	beq $a3, $zero, dead
	sw $a3, health
	sub $a0, $a0, $t1	
	sub $a1, $a1, $t1			# Set up values for new location
	sub $a2, $a2, $t1

	lw $t0, totalmoves
	add $t0, $t1, $t0
	sw $t0, totalmoves

	mult $a0, $t2
	mflo $a0

	mult $a1, $t3
	mflo $a1

	mult $a2, $t4
	mflo $a2

	add $a0, $a0, $a1
	add $a0, $a0, $a2

	add $s1, $s1, $a0
	lw $a0, ($s1)

	li $t1, 0			# Value of snake
	li $t2, 1 			# Value of sandwich
	li $t3, 2 			# Value of mustard
	li $t4, 3 			# Value of Safe
	li $t5, 5 			# Value of Diamond

	beq $a0, $t1, foundsnake
	beq $a0, $t2, foundsandwich
	beq $a0, $t3, foundmustard
	beq $a0, $t4, foundsafe
	beq $a0, $t5, founddiamond
gobackright:
	la $s1, list
	li $t1, 1
	li $t2, 32
	li $t3, 4
	li $t4, 256
	li $t5, 8
	lw $a0, x
	lw $a1, y
	lw $a2, z
	lw $a3, health
	sub $a0, $a0, $t1			# Move player coordinates backwards 1
	blt $a0, $t1, outofbounds	# Jump if out of bounds
	add $a1, $a1, $t1			# Move player coordinates right 1
	bgt $a1, $t5, outofbounds
	sw $a0, x 					# Store new location to x
	
	sw $a1, y 					# Store new location to y
	sub $a3, $a3, $t1			# Lose 1 HP
	beq $a3, $zero, dead
	sw $a3, health
	sub $a0, $a0, $t1	
	sub $a1, $a1, $t1			# Set up values for new location
	sub $a2, $a2, $t1

	lw $t0, totalmoves
	add $t0, $t1, $t0
	sw $t0, totalmoves

	mult $a0, $t2
	mflo $a0

	mult $a1, $t3
	mflo $a1

	mult $a2, $t4
	mflo $a2

	add $a0, $a0, $a1
	add $a0, $a0, $a2

	add $s1, $s1, $a0
	lw $a0, ($s1)

	li $t1, 0			# Value of snake
	li $t2, 1 			# Value of sandwich
	li $t3, 2 			# Value of mustard
	li $t4, 3 			# Value of Safe
	li $t5, 5 			# Value of Diamond

	beq $a0, $t1, foundsnake
	beq $a0, $t2, foundsandwich
	beq $a0, $t3, foundmustard
	beq $a0, $t4, foundsafe
	beq $a0, $t5, founddiamond


gosleep:
	la $a0, newline
	li $v0, 4
	syscall
	la $a0, sp
	li $v0, 4
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	li $v0, 42
	li $a1, 3
	syscall

	li $t0, 0
	lw $t1, health
	li $t3, 1
	li $t4, 10

	beq $a0, $t0, foundsnake

	add $t2, $t1, $t3
	bgt $t2, $t4, healthfull
	add $t1, $t1, $t3
	add $t2, $t1, $t3
	bgt $t2, $t4, healthfull
	add $t1, $t1, $t3

	sw $t1, health

	la $a0, safesleep
	li $v0, 4
	syscall

	la $a0, ($t1)
	li $v0, 1
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	j newloc

healthfull:
	la $a0, healthfullp
	li $v0, 4
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	j newloc

foundsnake:
	la $a0, newline
	li $v0, 4
	syscall
	lw $t0, health
	li $t1, 3
	li $t2, 1

	la $a0, snakesleep
	li $v0, 4
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	lw $t3, snakebites
	add $t3, $t3, $t2
	sw $t3, snakebites

	sub $t2, $t0, $t1
	beq $t2, $zero, dead
	blt $t2, $zero, dead
	sub $t0, $t0, $t1
	sw $t0, health


	la $a0, hpp
	li $v0, 4
	syscall

	la $a0, ($t0)
	li $v0, 1
	syscall

	j newloc

foundsandwich:
	lw $t0, sandwiches
	li $t1, 1
	li $t2, 5
	la $a0, newline
	li $v0, 4
	syscall
	la $a0, sandp
	li $v0, 4
	syscall

	add $t3, $t0, $t1			# Add 1 to total sandwiches
	bgt $t3, $t2, sandfull
	add $t0, $t1, $t0
	sw $t0, sandwiches

	la $a0, newline
	li $v0, 4
	syscall

	la $a0, sandp2
	li $v0, 4
	syscall

	la $a0, ($t0)
	li $v0, 1
	syscall

	la $a0, sandp3
	li $v0, 4
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	lw $a0, x
	lw $a1, y
	lw $a2, z
	la $s1, list
	li $t1, 1
	li $t2, 32
	li $t3, 4
	li $t4, 256
	li $t5, 3

	sub $a0, $a0, $t1	
	sub $a1, $a1, $t1			# Set up values for new location
	sub $a2, $a2, $t1

	mult $a0, $t2
	mflo $a0

	mult $a1, $t3
	mflo $a1

	mult $a2, $t4
	mflo $a2

	add $a0, $a0, $a1
	add $a0, $a0, $a2

	add $s1, $s1, $a0
	sw $t5, ($s1)


	j newloc

sandfull:
	la $a0, newline
	li $v0, 4
	syscall

	la $a0, maxsand
	li $v0, 4
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	j newloc

eatsand:
	lw $t0, sandwiches
	lw $t1, health
	lw $t5, sandeaten
	li $t2, 1
	li $t3, 10

	sub $t4, $t0, $t2
	blt $t4, $zero, nosand
	sub $t0, $t0, $t2
	sw $t0, sandwiches

	add $t4, $t1, $t2
	bgt $t4, $t3, healthfull
	add $t1, $t1, $t2
	sw $t1, health
	add $t5, $t5, $t2
	sw $t5, sandeaten
	add $t4, $t1, $t2
	bgt $t4, $t3, healthfull
	add $t1, $t1, $t2
	sw $t1, health

	la $a0, newline
	li $v0, 4
	syscall

	la $a0, eatp
	li $v0, 4
	syscall

	la $a0, ($t1)
	li $v0, 1
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	j newloc

nosand:
	la $a0, newline
	li $v0, 4
	syscall
	lw $t1, health
	la $a0, nosandp
	li $v0, 4
	syscall

	la $a0, ($t1)
	li $v0, 1
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	j newloc

foundmustard:
	lw $t0, mustard
	lw $t6, mustardworth
	li $t1, 1
	li $t2, 2
	li $t4, 3
	la $a0, newline
	li $v0, 4
	syscall
	la $a0, mustp
	li $v0, 4
	syscall

	add $t3, $t0, $t1			# Add 1 to total mustards
	bgt $t3, $t2, mustfull
	add $t0, $t1, $t0
	sw $t0, mustard
	add $t6, $t6, $t4
	sw $t6, mustardworth

	la $a0, newline
	li $v0, 4
	syscall

	la $a0, mustp2
	li $v0, 4
	syscall

	la $a0, ($t0)
	li $v0, 1
	syscall

	la $a0, mustp3
	li $v0, 4
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	lw $a0, x
	lw $a1, y
	lw $a2, z
	la $s1, list
	li $t1, 1
	li $t2, 32
	li $t3, 4
	li $t4, 256
	li $t5, 3

	sub $a0, $a0, $t1	
	sub $a1, $a1, $t1			# Set up values for new location
	sub $a2, $a2, $t1

	mult $a0, $t2
	mflo $a0

	mult $a1, $t3
	mflo $a1

	mult $a2, $t4
	mflo $a2

	add $a0, $a0, $a1
	add $a0, $a0, $a2

	add $s1, $s1, $a0
	sw $t5, ($s1)


	j newloc

mustfull:
	la $a0, newline
	li $v0, 4
	syscall

	la $a0, maxmust
	li $v0, 4
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	j newloc

eatmust:
	lw $t0, mustard
	lw $t1, health
	lw $a1, musteaten
	lw $a2, sandeaten
	lw $t6, mustardworth
	lw $t5, sandwiches
	li $t2, 1
	li $t3, 10
	li $t7, 3

	sub $t4, $t5, $t2
	blt $t4, $zero, nomustsand
	sub $t4, $t0, $t2
	blt $t4, $zero, nomust
	sub $t0, $t0, $t2
	sw $t0, mustard
	sub $t5, $t5, $t2
	sw $t5, sandwiches
	sub $t6, $t6, $t2
	sw $t6, mustardworth

	div $t6, $t7
	mflo $t8
	mfhi $t9				#remainder
	beq $t9, $zero, newmust

	add $t0, $t0, $t2
	sw $t0, mustard

	add $t4, $t1, $t2
	bgt $t4, $t3, healthfull
	add $t1, $t1, $t2
	sw $t1, health
	add $a1, $a1, $t2
	sw $a1, musteaten
	add $a2, $a2, $t2
	sw $a2, sandeaten
	add $t4, $t1, $t2
	bgt $t4, $t3, healthfull
	add $t1, $t1, $t2
	sw $t1, health
	add $t4, $t1, $t2
	bgt $t4, $t3, healthfull
	add $t1, $t1, $t2
	sw $t1, health
	add $t4, $t1, $t2
	bgt $t4, $t3, healthfull
	add $t1, $t1, $t2
	sw $t1, health

	la $a0, eatmustp
	li $v0, 4
	syscall

	la $a0, ($t1)
	li $v0, 1
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	j newloc

nomustsand:
	la $a0, newline
	li $v0, 4
	syscall
	la $a0, nomustsandp
	li $v0, 4
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	j newloc

newmust:
	add $t4, $t1, $t2
	bgt $t4, $t3, healthfull
	add $t1, $t1, $t2
	sw $t1, health
	add $t4, $t1, $t2
	bgt $t4, $t3, healthfull
	add $t1, $t1, $t2
	sw $t1, health
	add $t4, $t1, $t2
	bgt $t4, $t3, healthfull
	add $t1, $t1, $t2
	sw $t1, health
	add $t4, $t1, $t2
	bgt $t4, $t3, healthfull
	add $t1, $t1, $t2
	sw $t1, health

	la $a0, eatmustp
	li $v0, 4
	syscall

	la $a0, ($t1)
	li $v0, 1
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	j newloc
	
nomust:
	la $a0, newline
	li $v0, 4
	syscall
	lw $t1, health
	la $a0, nomustp
	li $v0, 4
	syscall

	la $a0, ($t1)
	li $v0, 1
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	j newloc

foundsafe:
	la $a0, newline
	li $v0, 4
	syscall
	la $a0, safep
	li $v0, 4
	syscall

	j newloc

founddiamond:
	la $a0, newline
	li $v0, 4
	syscall
	la $a0, diamondp
	li $v0, 4
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	la $a0, newgame
	li $v0, 4
	syscall

	la $a0, buffer
	la $a1, Isize
	li $v0, 8
	syscall
	la $a0, buffer
	j loady

checkhealth:
	lw $t0, health
	la $a0, newline
	li $v0, 4
	syscall
	la $a0, checkhp
	li $v0, 4
	syscall

	la $a0, ($t0)
	li $v0, 1
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	j newloc

invcheck:
	lw $t0, sandwiches
	lw $t1, mustard
	la $a0, newline
	li $v0, 4
	syscall

	la $a0, invcheckp
	li $v0, 4
	syscall

	la $a0, singleline
	li $v0, 4
	syscall

	la $a0, sinv
	li $v0, 4
	syscall

	la $a0, ($t0)
	li $v0, 1
	syscall

	la $a0, singleline
	li $v0, 4
	syscall

	la $a0, minv
	li $v0, 4
	syscall

	la $a0, ($t1)
	li $v0, 1
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	j newloc

viewrules:
	la $a0, newline
	li $v0, 4
	syscall
	la $a0, rulesp
	li $v0, 4
	syscall

	la $a0, newline
	li $v0, 4
	syscall

	j newloc

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

noinputdif:
	la $a0, badinput
	li $v0, 4
	syscall
	la $a0, newline
	li $v0, 4
	syscall

	la $a0, difficulty
	li $v0, 4
	syscall
	la $a0, buffer
	la $a1, size
	li $v0, 8
	syscall
	la $a0, buffer
	li $t0, 0 			# Elemant counter
	jal loadeasy
	

newloc:
	la $a0, newline
	li $v0, 4
	syscall
	la $a0, newlocp
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

	la $a0, newline
	li $v0, 4
	syscall
	la $a0, prompt		# Print prompt
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
	la $a0, newline
	li $v0, 4
	syscall
	j return

outofbounds:
	la $a0, newline
	li $v0, 4
	syscall
	la $a0, bound
	li $v0, 4
	syscall
	la $a0, newline
	li $v0, 4
	syscall

	j newloc

dead:
	la $a0, deadp
	li $v0, 4
	syscall

	j return

gamestats:
	lw $t1, time1
	lw $t2, time2
	lw $t3, totalmoves
	lw $t4, sandeaten
	lw $t5, musteaten
	lw $t6, snakebites
	sub $t1, $t2, $t1
	sw $t1, time1
	la $a0, newline
	li $v0, 4
	syscall

	la $a0, gamestatp
	li $v0, 4
	syscall
	la $a0, singleline
	li $v0, 4
	syscall
	la $a0, movesp
	li $v0, 4
	syscall
	la $a0, ($t3)
	li $v0, 1
	syscall
	la $a0, singleline
	li $v0, 4
	syscall
	la $a0, sandeatp
	li $v0, 4
	syscall
	la $a0, ($t4)
	li $v0, 1
	syscall
	la $a0, singleline
	li $v0, 4
	syscall
	la $a0, musteatp
	li $v0, 4
	syscall
	la $a0, ($t5)
	li $v0, 1
	syscall
	la $a0, singleline
	li $v0, 4
	syscall
	la $a0, snakebitep
	li $v0, 4
	syscall
	la $a0, ($t6)
	li $v0, 1
	syscall
	la $a0, singleline
	li $v0, 4
	syscall
	la $a0, timep
	li $v0, 4
	syscall
	la $a0, ($t1)
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall

	jr $ra

newgame:
	la $a0, newline
	li $v0, 4
	syscall

	la $a0, newgamep
	li $v0, 4
	syscall

	la $a0, buffer
	la $a1, Isize
	li $v0, 8
	syscall
	la $a0, buffer
	j loady



return:
	jr $ra



