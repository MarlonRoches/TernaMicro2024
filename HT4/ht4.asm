    .data
prompt:         .string "Ingrese dos números: "
not_friends:    .string "Los números no son amigos.\n"
are_friends:    .string "Los números son amigos.\n"

    .text
    .globl main
main:
    # Leer los dos números
    li a7, 4
    la a0, prompt
    ecall
    li a7, 5
    ecall
    mv t0, a0                 # Primer número
    li a7, 5
    ecall
    mv t1, a0                 # Segundo número

    # Calcular suma de divisores del primer número, excluyendo el mismo número
    li t2, 1                  # Inicializar contador de divisores
    li t3, 0                  # Suma de divisores de t0
sum_divisors1:
    beq t2, t0, update1       # Excluir el mismo número
    div t4, t0, t2
    mul t5, t4, t2
    bne t5, t0, update1       # Si t5 no es igual a t0, no es divisor exacto
    add t3, t3, t2            # Sumar divisor a t3
update1:
    addi t2, t2, 1            # Incrementar contador de divisor
    blt t2, t0, sum_divisors1 # Continuar hasta t2 < t0

    # Calcular suma de divisores del segundo número, excluyendo el mismo número
    li t2, 1                  # Reiniciar contador de divisores
    li t4, 0                  # Suma de divisores de t1
sum_divisors2:
    beq t2, t1, update2       # Excluir el mismo número
    div t5, t1, t2
    mul t6, t5, t2
    bne t6, t1, update2       # Si t6 no es igual a t1, no es divisor exacto
    add t4, t4, t2            # Sumar divisor a t4
update2:
    addi t2, t2, 1            # Incrementar contador de divisor
    blt t2, t1, sum_divisors2 # Continuar hasta t2 < t1

    # Comparar sumas de divisores con los números originales
    beq t3, t1, check_friend  # Si suma de divisores de t0 es igual a t1, verificar la otra dirección
    j not_friends_msg

check_friend:
    beq t4, t0, friends_msg   # Si suma de divisores de t1 es igual a t0, son amigos
    j not_friends_msg

friends_msg:
    li a7, 4
    la a0, are_friends
    ecall
    j exit

not_friends_msg:
    li a7, 4
    la a0, not_friends
    ecall

exit:
    li a7, 10                 # Salir del programa
    ecall
