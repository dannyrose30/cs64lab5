.data
str: .ascii "CATS"

.text
main:
    la $t0 str
    lw $t1 0($t0)

    li $v0 1
    move $a0 $t1
    syscall

    li $v0 10
    syscall