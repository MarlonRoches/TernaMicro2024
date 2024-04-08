.global programa
.data
# ================================================= Constantes de instrucciones =================================================
	ingresoCantidad:
		.string "Ingrese la cantidad de matrices: "
	ingresoDimensiones:
		.string "Ingrese las dimensiones de la matriz "
	ingresoFilas:
		.string "Ingrese la cantidad de filas: "
	ingresoColumnas:
		.string "Ingrese la cantidad de columas: "
	matrizCartel:
		.string "Matriz "
	ingresoValor:
		.string "Ingrese valor para "
	ingresoOperacion:
		.string "Ingrese la Operacion: "
	inputOperacion:
		.string "Operacion ingresada: "
	ln:
		.string " "
	msg_ValoresMatriz:
		.string "Valores dentro de la matriz: "
	msg_BuscandoxyY:
	.string "Buscando pos x y"
			
	msg_DimsMAtrices:
		.string "Valores x,y: "
	msg_valx:
		.string "Dir x"
	msg_valy:
		.string "Dir y: "
		msg_DimX:
		.string "Dim x: "
	msg_DimY:
		.string "Dim y: "
	msg_DirEfectiva:
	.string "dir efectiva = X-1 + (TamY  * Y-1): "
	mas: .string " + "
	menos: 	.string " - "
	por: 	.string " * "
	dividido: 	.string " / "
	igual: 	.string " = "
	msg_ValorEncontrado: .string "Valor Encontrado: "
	msg_MatrixNameInfo: .string "Informacion de la matriz: "
	
	msg_DifDim: .string "ERR!! No se pueden operar matrices con dimensiones diferentes."
	msg_End: .string "Terminando programa: "
	msg_Operando: .string "Dimensiones Compatibles Operando: "
	corcheteIzq: .string "["
	coma: .string " , "
	corcheteDer: .string "]"
	numMatriz: .string "Matriz #: "
	msgSkipSpaces: .string "Espacios a saltar para Matriz #: "
		msgCalcSpaces: .string "Calculando espacios a saltar para Matriz #: "
		msgEmptySpace: .string " ====== "
	labelResultado: .string "Resultado: "
		titleSuma: .string " ====== ====== ====== ====== SUMA ====== ====== ====== ======: "
		titleResta: .string " ====== ====== ====== ====== RESTA ====== ====== ====== ======: "
	titleMultiplicacion: .string " ====== ====== ====== ====== Multiplicacion ====== ====== ====== ======: "
# ================================================= Variables de control  =================================================
	cantidadMatrices:
		.byte 0
	nombresMatrices:
		.string	"ABCDEFGHIJKLMNOPQRSTUVWXY"
	# Almacena en 50 espacios 25 filas y 25 columnas de la forma [f1,c1,f2,c2...,fn,cn]
	# Matrices 	-> A   B   C   D
	#FilaColumna 	-> 2 3 4 5 2 5 3 5
	# Como es de 50, quiere decir que el programa puede almacenar como máximo 25 matrices
	matrizFilasColumnas:
		.space 50	
	# Arreglo que almacena los elementos de todas la matrices ingresadas al programa
	matrices:
		.space 500
	# Buffer para almacenar la operación que se desea realizar 
	operacion:
    		.space 100               # Reserva 100 bytes para el string de entrada
	# Matriz auxiliar para almacenar resultado de hasta 100 elmentos
	resultante:
		.space 500	
	# Operacion actual, almacena '+' o '*'
	operando:
		.byte 0
		
	tamanoBuffer: 
		.space 100      # Tamaño máximo del buffer
	dimX_1: #s3
		.word  1     
	dimY_1: #s4
		.word  1     
	dimX_2: #s5
		.word  1     
	dimY_2: #s6
		.word  1  
		
		  
	val_Matriz1: #s9
		.word  1 
	val_Matriz2: #s10
		.word  1
	val_ResultadoOp: #s11
		.word  1 
.text

programa:
	# Macro para la impresión de un salto de línea en pantalla
	.macro printEnter ()
		li a0, 10            # Código ASCII para salto de línea (\n)
		li a7, 11            # Código de servicio para imprimir un carácter
		ecall                # Imprime el salto de línea
	.end_macro
	
	# Macro para imprimir un string seguido de un salto de línea
	# Argumento:
	# %1 - Registro que contiene la dirección del string a imprimir
	.macro print (%reg)
		la a0, %reg          # Carga la dirección del string en a0
		li a7, 4             # Código de servicio para imprimir un string
		ecall                # Realiza la llamada al sistema para imprimir el string
	.end_macro
	
	# Macro para imprimir un string seguido de un salto de línea
	# Argumento:
	# %1 - Registro que contiene la dirección del string a imprimir
	.macro printReg (%reg)
		mv a0, %reg          # Carga la dirección del string en a0
		li a7, 4             # Código de servicio para imprimir un string
		ecall                # Realiza la llamada al sistema para imprimir el string
	.end_macro
	
	.macro printCharMin(%reg)
		mv a0,%reg
		li a7, 1                   # Código de servicio para imprimir un carácter
		ecall                       # Imprime el primer byte
	.end_macro 

	# Macro para la lectura de filas y columnas de las matrices
	# cm: cantidad matrices, n1: filas, n2: columnas
	.macro IngresoFilasColumnas(%cm)
		li t6, 0	# Contador cantidad de matrices
		la a1, matrizFilasColumnas # a1 contiene la posicón del arreglo que almacena filas, columnas
		la a2, nombresMatrices # a2 contiene la poscición del arreglos que tiene los identificadores de matrices
	pedirdimensiones:
		print(ingresoDimensiones)
		lb a0, 0(a2)
		li a7, 11	# Imprimir un caracter ascii
		ecall
		addi a2, a2, 1	# Mover hacia el siguiente posible identificador de matriz
		printEnter()	
	
		print(ingresoFilas)
		li a7, 5	# Lectura entrada de un número
		ecall
		mv t1, a0	# Almacenar filas en t1
		
		print(ingresoColumnas)
		li a7, 5	# Lectura entrada de un número
		ecall
		mv t2, a0	# Almacenar columnas en t2
		
		sb t1, 0(a1)	# Almacena filas
		addi a1, a1, 1
		sb t2, 0(a1)	# Almacena columnas
		addi a1, a1, 1
		
		printEnter()
		
		addi t6, t6, 1
		blt t6, %cm, pedirdimensiones
	.end_macro
	
	# Macro para el ingreso de los valores de una matriz
	# Se hace un almacenamiento por filas
	# nf: numero de filas, nc: numero de columnas, pm: posición en arreglo de matrices
	.macro LlenarMatriz(%nf, %nc, %pm)
		li t6, 0		# Contador filas ingresadas t6 < %nf
		li t5, 0		# Contador columnas ingresadas t5 < %nc
	nuevoElemento:
		print(ingresoValor)
		li a7, 11
		li a0, 32		# Imprimir un espacio
		ecall		
		addi a0, t6, 48		# Imprimir fila actual
		ecall
		li a0, 120		# Imprimir una X
		ecall
		addi a0, t5, 48		# Imprimir columna actual
		ecall
		li a0, 58		# Imprimir :
		ecall
		li a0, 32
		ecall			# Imprimir un espacio
		
		li a7, 5		# Lectura entrada de un número
		ecall
		
		mv t4, a0
		sb t4, 0(%pm)		# Almacenar elemento ingresado
		addi %pm, %pm, 1	# Siguiente posición para almacenar
		addi t5, t5, 1		# Siguiente columna
		
		blt t5, %nc, nuevoElemento	# Comparación di terminó de leer columnas
		
		li t5, 0		# Reinicia contador de columnas
		addi t6, t6, 1
		
		blt t6, %nf, nuevoElemento
	.end_macro
	
	# Macro para obtener el número de matriz según una letra en específico del arreglo de identificadores
	# %char = contiene la letra de la matriz
	# t2 tendrá almacendao el número de matriz correspondiente.
		# Ejemplo
	# li t1, 68	#letra D
	# ObtenerNumeroMatriz(t1)
	# mv a0, t2	# t2 contiene el número que representa el identificador de la matriz
	# li a7, 1	# imprime caracter comprobando que sea correcto
	# ecall
	.macro ObtenerNumeroMatriz(%char)
		li t2, 0	# Inicio contador de la posición de la matriz
		la a1, nombresMatrices	# Carga en a1 la posición del primer identificador
	comprobarIdentificador:
		lb t3, 0(a1)
		beq t3, %char, salirMacro
		addi a1, a1, 1		# Pasar a siguiente identificador
		addi t2, t2, 1		# Sumar contador
		j comprobarIdentificador
	salirMacro:		
	.end_macro
	
	# Macreo para obtener la posición en la que se comienzan a almacenar los valores de una matriz
	# %nm = numero de matriz de la que se quiere leer sus valores
	# s1 contiene el resultado de desplazamiento en la matriz
		# Ejemplo
	# li t2, 3
	# ObtenerInicioValoresMatriz(t2)	# Guarda desplazamiento en s1	
	# la s3, matrices
	# add s3, s3, s1
	# lb a0, 0(s3)
	# li a7, 1	# imprime caracter comprobando que sea correcto
	# ecall
	.macro ObtenerInicioValoresMatriz(%nm)
		li t3, 0	# Reinicio variable control
		li s1, 0	# Vairable acumuladora para almacenar el número de posciión
		la a6, matrizFilasColumnas	# Carga en la posción de las filas y colmunas
	sumarElementosMatriz:
		beq %nm, t3, devolverPosicion
		lb t4, 0(a6)	# Carga en t4 el número de filas de la matriz actual
		addi a6, a6, 1
		lb t5, 0(a6)	# Carga en t5 el número de columnas de la matriz actual
		addi a6, a6, 1
		
		mul t6, t4, t5	# Almacena en t6 el valor de filas x columas de la matriz actual
		add s1, s1, t6	#Sumar resultado a acumulador
		printCharMin(s1)
		addi t3, t3, 1
		j sumarElementosMatriz
	devolverPosicion:
	.end_macro
	
	
	
	.macro printChar(%reg)
		mv a0,%reg
		li a7, 1                   # Código de servicio para imprimir un carácter
		ecall                       # Imprime el primer byte
		printEnter()
	.end_macro 
	
	# Macro referente al cálculo de una posicón de una matriz dadas las posiciones i, j
	# Con el método de Mapero léxico gráfico
	# %cantidadCol = numero de elementos de una fila en la matriz
	# %i = numreo de fila
	# %j = numero de columna
	# Retorna en s11, la posición de en arreglo lineal de i, j
		#Ejemplo
	# Matriz 4x5
	# Busca posición (2,2)
	# la a1, matrizFilasColumnas
	# addi a1, a1, 1
	# lb t1, 0(a1), # cantidad de columanas
	# li t2, 2
	# li t3, 2
	# MLG(t1, t2, t3)
	# mv a0, s11
	.macro MLG(%cantidadCol, %i, %j)
		mul s11, %i, %cantidadCol
		add s11, s11 %j 
	.end_macro
	
	# Macro para realiza la multiplicación de dos matrices
	# La multiplicación es A x B
	# %piA = posición inicial de la matriz A t1
	# %fA = numero de filas de A t2
	# %cA = numero de columnas de A t3
	# %piB = posición inicial de la matriz B t4
	# %fB = numero de filas de B t5
	# %cB = numero de columnas de B t6
	.macro Multiplicar(%piA, %fA, %cA, %piB, %fB, %cB)
	print(titleMultiplicacion)
	printEnter()
		li s10, 0	# Inicio de contador para filas de matriz A
		li s9, 0	# Inicio de contador para columnas de matriz B
		li s8, 0	# Inicio de contador para columnas de A = filas de B
		la a1, resultante	# Cargar el espacio donde se va a guardar la matriz resultante en a1
		li s7, 0	# Inicio de acumulador para resultado de cada celda de matriz resultante
		bne  %cA, %fB, diferentDimentions
		filasA:
			columnasB:
				columnasAFilasB:
					MLG(%cA, s10, s8)	# Obtener valor de la celda de A
					add %piA, %piA, s11	# Desplazar hacia posición actual
					lb s6, 0(%piA)
					sub %piA, %piA, s11	# Retornar a posición incial
					
					MLG(%cB, s8, s9)	# Obtener valor de la celda de B
					add %piB, %piB, s11	# Desplazamr hacia la posición actual
					lb s5, 0(%piB)
					sub %piB, %piB, s11	# Retornar a posición incial
					
					mul s5, s5, s6
					add s7, s7, s5
					
					addi s8, s8, 1	# Mover al siguiente elemento u operacion
				blt s8, %cA, columnasAFilasB	# Aumentar 1 a total operaciones in a row
				printChar(s7)
				sb s7, 0(a1)
				addi a1, a1, 1
				li s7, 0
				li s8, 0
				addi s9, s9, 1	# Mover a la siguiente columna
		 	blt s9, %cB, columnasB	# Aumentar una columna de B si ya llegó al máximo
		 	addi s10, s10, 1	# Aumnetar una fila A
		 	li s9, 0
		blt s10, %fA, filasA
	.end_macro
	
INICIOPROGRAMA:
	#j prueba
# --------------------     1)Inicio e ingreso de cantidad de matrices     ----------------------
	print(ingresoCantidad)	# Imprimir mensaje inicial para ingresar una matriz
	
	li a7, 5	# Lectura entrada de un número
	ecall
	mv t0, a0	# t0 contiene la cantidad de matrices
	
	la a1, cantidadMatrices
	sb t0, 0(a1)

# ------------------------    2) ingreso de dimensiones de matrices       -----------------------
	IngresoFilasColumnas(t0)

# ----------------------      3) Ingreso los valores de cada matriz     -------------------------
	li t1, 0	# t1 es contador para llenar n matrices
	la a1, matrizFilasColumnas	# Apunta a las primeras dimensiones fila de A
	la a2, matrices			# Apunta a arreglo que almacena valores de la matriz
	la a3, nombresMatrices		# Apunta en orden a los identificadores de matrices A B C D E ...
completarMatrices:
	lb t2, 0(a1)		# t2 almacena la cantidad de filas
	addi a1, a1, 1
	lb t3, 0(a1)		# t3 almacena la cantidad de columnas
	addi a1, a1, 1
	
	print(matrizCartel)	# Mensaje de matriz
	lb a0, 0(a3)
	li a7, 11		# Imprime identificador matriz actual
	ecall
	printEnter()
	
	LlenarMatriz(t2, t3, a2)
	
	addi a3, a3, 1		#Pasa al siguiente identificador
	printEnter()
	
	addi t1, t1, 1		# Se llenó una matriz
	blt t1, t0, completarMatrices
	printEnter()
 # ----------------------            4) Ingreso de operación a realizar      -----------------------
	print(ingresoOperacion)
	la a0, operacion	# Se almacena el buffer en el contedor de a0
	li a1, 20		# Se permite un máximo de 20 caractere para leer
	li a7, 8		# Función para le lecctura de un buffer del teclado
	ecall
	
# -----------         5) Obtención de datos para realizar operacion        --------------------------
	
	# %piA = posición inicial de la matriz A t1
	# %fA = numero de filas de A t2
	# %cA = numero de columnas de A t3
	# %piB = posición inicial de la matriz B t4
	# %fB = numero de filas de B t5
	# %cB = numero de columnas de B t6
	 
	#A
	li t3, 65
	ObtenerNumeroMatriz(t3) # resultado en t2
	ObtenerInicioValoresMatriz(t2) # s1
	la a5, matrices
	add a5, a5, s1
	mv t1, a5
	
	
	#B
	li t4, 66 # resultado en t2
	ObtenerNumeroMatriz(t4) # resultado en t2
	ObtenerInicioValoresMatriz(t2) # s1
	la a5, matrices
	add a5, a5, s1
	mv t4, a5
	

	li t2, 2
	li t3, 2
	#s3,4
	
	li t5, 2
	li t6, 2
	
	lb a0, 0(t1)
	li a7, 1
	ecall
	
	lb a0, 0(t4)
	li a7, 1
	ecall
	
	Multiplicar(t1, t2, t3, t4, t5, t6)
	
	
	
	
	# ===================== ROCHES =====================


	.macro printMin (%reg)
		la a0, %reg          # Carga la dirección del string en a0
		li a7, 4             # Código de servicio para imprimir un string
		ecall                # Realiza la llamada al sistema para imprimir el string
	.end_macro
	
	

	# Macro para leer un string de entrada y almacenarlo en un buffer
		# Argumentos:
		# %1 - Registro que contiene la dirección base del buffer de entrada
		# %2 - Tamaño máximo del buffer
	.macro leerString (%buffer, %size, %label)
	    print  (%label) 
		mv t0, %buffer           # t0 = Dirección base del buffer
		li t1, %size             # t1 = Tamaño máximo del buffer
		li t2, 0                 # t2 = Contador de caracteres leídos

		leerCaracter:
			li a7, 12                # Código de servicio para leer un carácter del usuario
			ecall                    # Realiza la llamada al sistema para leer el carácter
			li a4,10
			beq a0, a4, finString    # Si el carácter leído es un salto de línea, termina la lectura

			sb a0, 0(t0)             # Almacena el carácter en el buffer
			addi t0, t0, 1           # Incrementa la dirección del buffer
			addi t2, t2, 1           # Incrementa el contador de caracteres
			blt t2, t1, leerCaracter # Si aún no se ha alcanzado el tamaño máximo, lee otro carácter

		finString:
			sb zero, 0(t0)           # Añade el carácter nulo al final del string
	.end_macro
	
	.macro leerOperacion ()
		la t2, entradaBuffer
		la t3, tamanoBuffer
		leerString(t2,100, ingreseOperacion)
		print(inputOperacion)
		print(entradaBuffer)
	.end_macro 


	# Macro para imprimir el contenido de un arreglo
	# Argumentos:
	# %1 - Registro que contiene la dirección base del arreglo
	# %2 - Número de elementos en el arreglo
	.macro imprimirArreglo (%arreglo, %numElementos)
		mv t0, %arreglo           # t0 = Dirección base del arreglo
		li t1, %numElementos      # t1 = Número de elementos en el arreglo
		li t2, 0                  # t2 = Contador de posición

		imprimirElemento:
			lb a0, 0(t0)              # Carga el valor en la posición actual del arreglo en a0
			li a7, 1                  # Código de servicio para imprimir un entero
			ecall                     # Imprime el valor

			addi t0, t0, 1            # Incrementa la dirección del arreglo
			addi t2, t2, 1            # Incrementa el contador de posición
			blt t2, t1, imprimirElemento # Si aún no se ha alcanzado el final del arreglo, sigue imprimiendo
	.end_macro
	
	# Macro para recorrer un arreglo y imprimir sus elementos
		# Argumentos:
		# %1 - Registro que contiene la dirección base del arreglo
		# %2 - Número de elementos en el arreglo
	.macro recorrerImprimirArreglo (%arreglo, %numElementos)
		mv t0, %arreglo           # t0 = Dirección base del arreglo
		li t1, %numElementos      # t1 = Número de elementos en el arreglo
		li t2, 0                  # t2 = Contador de posición

		recorrerElemento:
			lb a0, 0(t0)              # Carga el valor en la posición actual del arreglo en a0
			addi a1, a0, 0            # Mueve el valor a a1 para imprimirlo como entero
			li a7, 1                  # Código de servicio para imprimir un entero
			ecall                     # Imprime el valor
			printEnter()
			addi t0, t0, 1            # Incrementa la dirección del arreglo
			addi t2, t2, 1            # Incrementa el contador de posición
			blt t2, t1, recorrerElemento # Si aún no se ha alcanzado el final del arreglo, sigue recorriendo
	.end_macro


	
	
	# ------------------------------ME SIRVE
	.macro printMatrixName(%numMatriz)
		la a2, nombresMatrices
		add a2, a2,%numMatriz
		lb a0, 0(a2)
		li a7, 11	# Imprimir un caracter ascii
		ecall
		
		
	.end_macro 

	# Macro para saltarse un número específico de posiciones en un arreglo y luego imprimir los siguientes dos bytes
		# Argumentos:
		# %1 - Registro que contiene la dirección base del arreglo
		# %2 - Número de posiciones a saltarse (se multiplicará por 2)
	.macro cargarDimX_Y (%arreglo, %numero)
		mv t0, %arreglo             # t0 = Dirección base del arreglo
		# li t1, %numero
		mv t1, %numero              # t1 = Número de posiciones a saltarse
		li t2,2
		mul a2, t1,t2
		add t0,t0,a2
		# print(msg_valx)
		lb a0, 0(t0)  
		mv s3, a0                  
		# print(msg_valy)
		lb a0, 1(t0)  
		mv s4, a0                                                
		# printEnter()
	.end_macro
	
	.macro cargarDimX_Y_Reg (%arreglo, %numero)
		mv t0, %arreglo             # t0 = Dirección base del arreglo
		mv t1, %numero              # t1 = Número de posiciones a saltarse
		li t2,2
		mul a2, t1,t2
		add t0,t0,a2
		lb a0, 0(t0)  
		mv s3, a0                  
		lb a0, 1(t0)  
		mv s4, a0                                                
		printEnter()
	.end_macro
	.macro cargarDimX_Y_Reg2 (%arreglo, %numero)
		mv t0, %arreglo             # t0 = Dirección base del arreglo
		mv t1, %numero              # t1 = Número de posiciones a saltarse
		li t2,2
		mul a2, t1,t2
		add t0,t0,a2
		lb a0, 0(t0)  
		mv s5, a0                  
		lb a0, 1(t0)  
		mv s6, a0                                                
		printEnter()
	.end_macro

	.macro saltarMatrices(%numMatriz) # resultado en a5
		li t1,0
		li a4,0
		li a5,0
		li a6,0
		la s11, matrizFilasColumnas     # Carga la dirección de 'matrices' en s11

		beqz %numMatriz,skip
		# print(msgCalcSpaces)
		# printChar(%numMatriz)
		
		sumarMatrices:
			cargarDimX_Y( s11, a4)
			#print(msg_DimX)
			#printChar(s3) #dim x
			#printEnter()
			#print(msg_DimY)
			#printChar(s4) #dim Y
			#printEnter()
			#t2
			mul a6, s3,s4
			add a5,a5,a6
			addi a4,a4,1
		blt a4, %numMatriz, sumarMatrices
		# printEnter()
		#print(msgSkipSpaces)
		#printChar(a5) #caracteres a saltar
		skip:
	.end_macro 

	.macro dirEfectiva(%numMatriz,%x, %y) #resultado en S9
		li a5,0


		saltarMatrices(%numMatriz) # resultado en a5

		#print(msgSkipSpaces)
		#printChar(a5) #caracteres a saltar
		#add t0,t0,a5
		
		la t0, matrizFilasColumnas     # Carga la dirección de 'matrices' en t0
		mv t6,%numMatriz
		cargarDimX_Y( t0,t6 )
		# print(msg_DimX)
		# printChar(s3) #dim x
		# printEnter()
		# print(msg_DimY)
		# printChar(s4) #dim Y
		# printEnter()

		
		# li t1, %x # t1 = x
		# li t2, %y # t2 = y
		mv t1, %x # t1 = x
		mv t2, %y # t2 = y

		# dir efectiva = X-1 + (TamY * Y-1)
		mul t3,t2, s4 # (TamY * Y-1)
		# printChar(t3)
		# printEnter()
		# dir efectiva =X-1 t3
		mv t4,t1
		add t4,t4,t3	

		# printEnter()

		# print(msg_DirEfectiva) 
		# printEnter()

		# printCharMin(t4)
		# printMin(igual)
		# printCharMin(t1)
		# printMin(mas)
		# printCharMin(s4)
		# printMin(por)
		# printChar(t2)

		la t0, matrices     # Carga la dirección de 'matrices' en t0
		add t0,t0,t4
		add t0,t0,a5
		# printMatrixName(%numMatriz)
		# print(msg_ValorEncontrado) 
		lb a0,0(t0)
		mv s9,a0
		#saltarMatrices(%numMatriz) # resultado en a5
		# printChar(s9)
		li a5,0
	.end_macro

	.macro dirEfectiva2(%numMatriz,%x, %y) #resultado en S9
		li a5,0


		saltarMatrices(%numMatriz) # resultado en a5

		#print(msgSkipSpaces)
		#printChar(a5) #caracteres a saltar
		#add t0,t0,a5
		
		la t0, matrizFilasColumnas     # Carga la dirección de 'matrices' en t0
		mv t6,%numMatriz
		cargarDimX_Y( t0,t6 )
		# print(msg_DimX)
		# printChar(s3) #dim x
		# printEnter()
		# print(msg_DimY)
		# printChar(s4) #dim Y
		# printEnter()

		
		# li t1, %x # t1 = x
		# li t2, %y # t2 = y
		mv t1, %x # t1 = x
		mv t2, %y # t2 = y

		# dir efectiva = X-1 + (TamY * Y-1)
		mul t3,t2, s4 # (TamY * Y-1)
		# printChar(t3)
		# printEnter()
		# dir efectiva =X-1 t3
		mv t4,t1
		add t4,t4,t3	

		# printEnter()

		# print(msg_DirEfectiva) 
		# printEnter()

		# printCharMin(t4)
		# printMin(igual)
		# printCharMin(t1)
		# printMin(mas)
		# printCharMin(s4)
		# printMin(por)
		# printChar(t2)

		la t0, matrices     # Carga la dirección de 'matrices' en t0
		add t0,t0,t4
		add t0,t0,a5
		# printMatrixName(%numMatriz)
		# print(msg_ValorEncontrado) 
		lb a0,0(t0)
		mv s10,a0
		#saltarMatrices(%numMatriz) # resultado en a5
		# printChar(s10)
		li a5,0
	.end_macro
	
	.macro printCoordenada(%x,%y)
	.end_macro
	 
	
	.macro Sumar (%numMatriz1, %numMatriz2)
	printEnter()
	print(titleSuma)
	li s1,0
	li s3,0
	li s4,0
	li s5,0
	li s6,0
	# verificar dimensiones
	printMin(msg_MatrixNameInfo)
	printMatrixName(%numMatriz1)
	printEnter()
	# DIMs (x,y) = s3,s4
	la t0, matrizFilasColumnas     # Carga la dirección de 'matrices' en t0
		cargarDimX_Y_Reg( t0, %numMatriz1)#s3) #dim x ,s4) #dim Y
		
		
	printMin(msg_MatrixNameInfo)
	printMatrixName(%numMatriz2)
	printEnter()
	# DIMs (x,y) = s5,s6
	la t0, matrizFilasColumnas     # Carga la dirección de 'matrices' en t0
		cargarDimX_Y_Reg2( t0, %numMatriz2)
		printMin(msg_DimX)
		printChar(s5) #dim x
		printMin(msg_DimY)
		printChar(s6) #dim Y
		printEnter()
 	
 	
 	# if(s3!=s5 \\ s4!=s6) ? 
 		#j diferentDimentions	
 		bne  s3,s5,diferentDimentions
		bne  s4,s6,diferentDimentions 
		# : Operar
		#print(msg_Operando) 
		li s5,0
		li s6,0
		#printEnter()
		#printChar(%numMatriz1)
		#printChar(%numMatriz2)
		#for x , i=s5
		SumaLoopI:
			#for y, j=s6
			SumaLoopJ:
				# printMin(msgEmptySpace)
				printMin(corcheteIzq)
				printCharMin(s5)
				printMin(coma)
				printCharMin(s6)
				print(corcheteDer)
				li s9,0
				li s10,0
				dirEfectiva(%numMatriz1,s6, s5) #resultado en S9
				dirEfectiva2(%numMatriz2,s6, s5) #resultado en S10
				add s1,s9,s10
				#sub s1,s9,s10
				printChar(s1)
			end:
			addi s6, s6, 1
			blt s6, s3, SumaLoopJ
		# printEnter()
		addi s5, s5, 1
		li s6,0
		blt s5, s4, SumaLoopI
	.end_macro
	
	.macro Restar (%numMatriz1, %numMatriz2)
	print(titleResta)
	printEnter()
	li s3,0
	li s4,0
	li s5,0
	li s6,0
	# verificar dimensiones
	printMin(msg_MatrixNameInfo)
	printMatrixName(%numMatriz1)
	printEnter()
	# DIMs (x,y) = s3,s4
	la t0, matrizFilasColumnas     # Carga la dirección de 'matrices' en t0
		cargarDimX_Y_Reg( t0, %numMatriz1)#s3) #dim x ,s4) #dim Y
		
		
	printMin(msg_MatrixNameInfo)
	printMatrixName(%numMatriz2)
	printEnter()
	# DIMs (x,y) = s5,s6
	la t0, matrizFilasColumnas     # Carga la dirección de 'matrices' en t0
		cargarDimX_Y_Reg2( t0, %numMatriz2)
		printMin(msg_DimX)
		printChar(s5) #dim x
		printMin(msg_DimY)
		printChar(s6) #dim Y
		printEnter()
 	
 	
 	# if(s3!=s5 \\ s4!=s6) ? 
 		#j diferentDimentions	
 		bne  s3,s5,diferentDimentions
		bne  s4,s6,diferentDimentions 
		# : Operar
		#print(msg_Operando) 
		li s5,0
		li s6,0
		
		SumaLoopI:
			#for y, j=s6
			SumaLoopJ:
				# printMin(msgEmptySpace)
				printMin(corcheteIzq)
				printCharMin(s5)
				printMin(coma)
				printCharMin(s6)
				print(corcheteDer)
				li s9,0
				li s10,0
				dirEfectiva(%numMatriz1,s6, s5) #resultado en S9
				dirEfectiva2(%numMatriz2,s6, s5) #resultado en S10
				sub s10,s9,s10
				printChar(s10)
			addi s6, s6, 1
			blt s6, s3, SumaLoopJ
		# printEnter()
		addi s5, s5, 1
		li s6,0
		blt s5, s4, SumaLoopI
	.end_macro

	
	# ============================ Main Method
	
	li s7,0
	li s8,1
	Sumar(s7,s8)
	li s7,0
	li s8,1
	Restar(s7,s8)
	
	
	li s7,1
	li s8,2
	Sumar(s7,s8)
	li s7,1
	li s8,2
	Restar(s7,s8)
	

j finalizar	
  # ============================ END MAIN
																											
	# la a1, matrizFilasColumnas
	# sb t2, 0(a1)
	# addi a1, a1, 1
	# sb t2, 0(a1)

	# la t2, matrizFilasColumnas
	# lb t3, 0(t2)
diferentDimentions:
	print(msg_DifDim)
	j finalizar
	 
finalizar:
	print(msg_End)
	li a7, 10
	ecall