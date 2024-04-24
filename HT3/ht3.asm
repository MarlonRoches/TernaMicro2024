    .data
prompt_mult:    .string "Ingrese dos números para multiplicar: "
prompt_div:     .string "Ingrese dividendo y divisor para la división: "
prompt_factors: .string "Ingrese un número para calcular sus factores: "
prompt_fib:     .string "Ingrese un número para la serie Fibonacci: "
result:         .string "Resultado: "

    .text
    .globl main
    	# Macro para la impresión de un salto de línea en pantalla
	.macro printEnter ()
		li a0, 10            # Código ASCII para salto de línea (\n)
		li a7, 11            # Código de servicio para imprimir un carácter
		ecall                # Imprime el salto de línea
	.end_macro
main:
    # Multiplicación mediante sumas sucesivas
    li a7, 4
    la a0, prompt_mult
    ecall
       
    li a7, 5
    ecall
    mv t0, a0                 # Primer número
    li a7, 5
    ecall
    mv t1, a0                 # Segundo número
    li t2, 0                  # Resultado de la multiplicación
multiply_loop:
    beq t1, zero, next_task1  # Si t1 es 0, pasar a la siguiente tarea
    add t2, t2, t0            # Sumar t0 a t2
    addi t1, t1, -1           # Decrementar t1
    j multiply_loop
next_task1:
   
    li a7, 4
    la a0, result
    ecall
    
    mv a0, t2
    li a7, 1
    ecall
printEnter ()
    # División mediante restas sucesivas
    li a7, 4
    la a0, prompt_div
    ecall
       
    li a7, 5
    ecall
    mv t0, a0                 # Dividendo
    li a7, 5
    ecall
    mv t1, a0                 # Divisor
    li t2, 0                  # Cociente
division_loop:
   printEnter ()
    blt t0, t1, next_task2    # Si dividendo < divisor, pasar a la siguiente tarea
    sub t0, t0, t1            # Restar divisor del dividendo
    addi t2, t2, 1            # Incrementar cociente
    j division_loop
next_task2:
   
    li a7, 4
    la a0, result
    ecall
    mv a0, t2
    li a7, 1
    ecall
    printEnter ()

    # Encontrar factores de un número
    li a7, 4
    la a0, prompt_factors
    ecall
    li a7, 5
    ecall
    mv t0, a0                 # Número a factorizar
    li t1, 1
factor_loop:

    bgt t1, t0, next_task3    # Si el factor es mayor que el número, pasar a la siguiente tarea
    rem t2, t0, t1            # Resto de t0 dividido t1
    bnez t2, update_factor    # Si t2 no es 0, continuar
    li a7, 4
    la a0, result
    ecall
    mv a0, t1
    li a7, 1
    ecall

update_factor:
   
    addi t1, t1, 1            # Incrementar factor
    j factor_loop

next_task3:
       printEnter ()
    # Serie Fibonacci
    li a7, 4
    la a0, prompt_fib
    ecall
       
    li a7, 5
    ecall
    mv t0, a0                 # Número máximo para Fibonacci
    li t1, 0                  # Primer número Fibonacci
    li t2, 1                  # Segundo número Fibonacci

print_fib:
    li a7, 4
    la a0, result
    ecall
    mv a0, t1
    li a7, 1
    ecall
    printEnter ()
    mv t3, t2
    add t2, t2, t1            # Actualizar el segundo número de Fibonacci
    mv t1, t3                 # Actualizar el primer número de Fibonacci
fibonacci_loop:
   printEnter ()
    ble t1, t0, print_fib     # Continuar mientras el número de Fibonacci no exceda t0
    j finish
finish:
    # Salir
    li a7, 10                 # syscall para terminar ejecución
    ecall   