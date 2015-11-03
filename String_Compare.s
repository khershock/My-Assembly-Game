.data 
buffer:     .space 20 # Max Size
size:       .word 5 # Max Characters
compare:    .asciiz "Yas\n"
message:    .asciiz "Do you liek mudkipz? "
fail:       .asciiz "Wat?!"
pass:       .asciiz "Gud!!"
nline:      .asciiz "\n"

.text
main:
    la $a0, message # Print Message
    li $v0, 4
    syscall
    la $a0, buffer # Gather String
    lw $a1, size
    li $v0,8 
    syscall
    # Do bit by bit comparison for strings Next
    la $a0, buffer 
    la $a1, compare
    jal comparestr
    li $v0, 10
    syscall

comparestr: # Bytewise compare
    lbu $t0, ($a0)
    lbu $t1, ($a1)
    bne $t0, $t1, failure
    addi $a0, $a0, 1
    addi $a1, $a1, 1
    beq $t0, $zero, success
    b comparestr

stringlen: # String Length

success:
    la $a0, pass
    li $v0, 4
    syscall
    j return

failure:
    la $a0, fail
    li $v0, 4
    syscall
    j return

return:
    jr $ra