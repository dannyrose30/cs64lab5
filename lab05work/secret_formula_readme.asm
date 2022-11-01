.data
cf: .word 37 23 22
#t: .word 0x07 0x03 0x15
carray: .word 0:3
marray: .word 0:3

outE: .asciiz "Encrypted: "
outD: .asciiz "Decrypted: "
commaspace: .asciiz ", "
newline: .asciiz "\n"

.text
main:
        #la $a0,krabby
        #li $a1,10
        #la $a2,carray
        #la $a3,marray

        li $s3 0 #index, saved variable. I used s1,s2 elsewhere
        la $s4 carray
        la $s5 marray
        la $s6 cf
        #la $s7 t
loop:
        beq $s3 3 print_arrays
        li $a0 3
        li $a1 11
        lw $a2 0($s6)
       
        jal secret_formula_apply
        sw $v0 0($s4)
        lw $a2 0($s6)
        li $a0 3
        li $a1 11
        jal secret_formula_remove
        sw $v0 0($s5)
        
        #update counter and addresses
        addi $s3 $s3 1
        addiu $s4 $s4 4
        addiu $s5 $s5 4
        addiu $s6 $s6 4
        #addiu $s7 $s7 4
        j loop    

print_arrays:
     la $t0 carray
     la $t1 marray
     li $t2 0 #used for index carray
     li $t3 0 #used for index marray
     
     li $v0 4
     la $a0 outE
     syscall

print_carray:
   # beq $t2 10 print_marray
    
    #print number
    lw $a0 0($t0)
    li $v0 1
    syscall
    
    beq $t2 2 nocomma

    #print commaspace
    li $v0 4
    la $a0 commaspace
    syscall
    
    addi $t2 $t2 1 #Updates carray index
    addi $t0 $t0 4 #Moves pointer along carray
    j print_carray

nocomma:
    li $v0 4
    la $a0 newline
    syscall
    
    li $v0 4
    la $a0 outD
    syscall

print_marray:
    lw $a0 0($t1)
    li $v0 1
    syscall
    
    beq $t3 2 exit

    #print commaspace
    li $v0 4
    la $a0 commaspace
    syscall

    addi $t3 $t3 1
    addi $t1 $t1 4
    j print_marray

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
    li $a1 7 #a0=e
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
    mflo $s2 #s2=n

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

exit:
        li $v0, 10
        syscall
