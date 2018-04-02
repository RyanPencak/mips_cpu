
.text
.global puts

# puts2 uses syscall 1

puts2:
    li $v0, 1
    syscall
    jr $ra
