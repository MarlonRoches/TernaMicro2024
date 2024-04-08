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
	operacion1: .string "X + Y"
operacion2 : .string "X – Z"
operacion3 : .string "X*Y"
operacion4 : .string "X/Y"
operacion5 : .string "X%Y"
operacion6 : .string "X* Y -Z"
operacion7 : .string "Z-X*Y"
operacion8 : .string "X+Z/Y"
operacion9 : .string "Z-X/Y"
operacion10 : .string "Y+Z/X"
titulo : .string "Valores X Y Z"
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
	
	# Macro para imprimir un string seguido de un salto de línea
	# Argumento:
	# %1 - Registro que contiene la dirección del string a imprimir
	.macro printReg (%reg)
		mv a0, %reg          # Carga la dirección del string en a0
		li a7, 4             # Código de servicio para imprimir un string
		ecall                # Realiza la llamada al sistema para imprimir el string
	.end_macro
	# Macro para la impresión de un salto de línea en pantalla
	.macro printEnter ()
		li a0, 10            # Código ASCII para salto de línea (\n)
		li a7, 11            # Código de servicio para imprimir un carácter
		ecall                # Imprime el salto de línea
	.end_macro
	.macro printCharMin(%reg)
		mv a0,%reg
		li a7, 1                   # Código de servicio para imprimir un carácter
		ecall                       # Imprime el primer byte
	.end_macro 
	# ============================================ INCIO DEL PROGRAMA ======================

print(titulo)
li a1, 15
li a2, 5
li a3, 10
	printEnter()
printCharMin(a1)
	printEnter()
printCharMin(a2)
	printEnter()
printCharMin(a3)
	printEnter()
	printEnter()
	printEnter()
# 1. X + Y
	print(operacion1)
	printEnter()
add a4, a1, a2
printCharMin(a4)
printEnter()
# 2. X – Z
print(operacion2)
	printEnter()
sub a4, a1, a3
printCharMin(a4)
printEnter()
# 3. X*Y
print(operacion3)
	printEnter()
mul a4, a1, a2 
printCharMin(a4)
printEnter()
# 4. X/Y
print(operacion4)
	printEnter()
div a4, a1, a2 
printCharMin(a4)
printEnter()

# 5. X%Y
print(operacion5)
	printEnter()
div a3, a1,a2
mul a4, a3, a1
sub a5, a1, a4
printCharMin(a5)
printEnter()
# 6. X* Y -Z
print(operacion6)
	printEnter()
mul a4, a1, a2 
sub a5, a4, a3
printCharMin(a5)
printEnter()
# 7. Z-X*Y
print(operacion7)
	printEnter()
mul a4, a1, a2 
sub a5, a3, a4
printCharMin(a5)
printEnter()
# 8. X+Z/Y
print(operacion8)
	printEnter()
div a4, a2, a3
add a5, a1, a4
printCharMin(a5)
printEnter()
# 9. Z-X/Y
print(operacion9)
	printEnter()
div a4, a1, a2
add a5, a3, a4
printCharMin(a5)
printEnter()
# 10.Y+Z/X
print(operacion10)
	printEnter()
div a4, a3, a1
add a5, a2, a4
printCharMin(a5)
printEnter()	 
finalizar:
	print(msg_End)
	li a7, 10
	ecall
