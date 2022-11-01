.text

pow:
        beq $a1 $zero pow_exit
        mult $t0 $a0
        mflo $t0
        addi $a1 $a1 -1
        j pow

pow_exit:
        move $v0 $t0
        jr $ra
secret_formula_apply:
    #we can assume $a0=x, $a1=y, $a2=m
    mult $a0 $a1
    mflo $s1 #$s1=n
    
    #save ra in stack
    addiu $sp $sp -4
    sw $ra 0($sp) 

    move $a0 $a2
    li $a1 7 #a1=e
    li $t0 1 #represents result
    jal pow #pow(m,e)

    move $t2 $v0 #result
    div $t2 $s1
    mfhi $t3 #t3 is c
   
    move $v0 $t3

    #get ra from stack
    lw $ra 0($sp)
    addiu $sp $sp 4
    jr $ra

secret_formula_remove:
    #a0=x, $a1=y, $a2=c
    li $t0 3
    mult $a0 $a1
    mflo $s2

    #save ra in stack
    addiu $sp $sp -4
    sw $ra 0($sp)

    move $a0 $a2
    move $a1 $t0
    li $t0 1 #represents result
    jal pow

    move $t2 $v0
    div $t2 $s2
    mfhi $t3
    
    move $v0 $t3

    #get ra from stack
    lw $ra 0($sp)
    addiu $sp $sp 4
    jr $ra

main:
    li $a0 3
    li $a1 11
    li $a2 29

    jal secret_formula_remove
    move $a0 $v0
    li $v0 1
    syscall

    li $v0 10
    syscall






