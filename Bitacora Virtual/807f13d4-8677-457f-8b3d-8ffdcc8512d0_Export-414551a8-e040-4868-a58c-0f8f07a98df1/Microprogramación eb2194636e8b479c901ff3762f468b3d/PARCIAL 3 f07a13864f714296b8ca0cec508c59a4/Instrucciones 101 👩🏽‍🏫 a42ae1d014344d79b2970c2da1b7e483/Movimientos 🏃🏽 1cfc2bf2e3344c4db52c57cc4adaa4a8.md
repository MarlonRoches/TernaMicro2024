# Movimientos 🏃🏽

## MOV Destino, Fuente

Mueve los datos de la fuente al destino

```nasm
destino = fuente
```

## PUSH <fuente(valor | registro | Dir) >

Almacena un dato en la pila,  por lo que puede ser recuperado luego.

```nasm
var pilaDePrograma = new Stack<valores>();
pilaDePrograma.push(valor);
```

## POP <registro Destino>

Saca y almacena en el registro destino el dato que se encuentra mas arriba en la pila de ejecucion.

```nasm
const eax = pilaDePrograma.pop() //saca heap
```

## LEA destino, fuente 32bits

Obtiene la dirección efectivca de memoria de un registro o variable. 

- Direccion de memoria donde inicia un arreglo.

```nasm

//la siguiente instrucción LEA carga la dirección del byte siguiente 
// al byte actual en el registro BX:
lea bx, [bx+1]
```

```nasm
const arreglo= [1,2,3]
const arrayInit : Type<Dir> = LEA(Arreglo) 
```

## LDS Destino, fuente 32

Carga la direccion efectiva de un registro y la almacena en el destino y DS.

## LES Destino, fuente 32

Almacena la direccion efeciva en ES y DI.

# Comparacion

| Característica | LEA | LDS | LES |
| --- | --- | --- | --- |
| Objetivo | Carga la dirección efectiva del operando en un registro | Carga la dirección efectiva del operando en los registros DS y SI | Carga la dirección efectiva del operando en los registros ES y DI |
| Registros | Cualquier registro | DS y SI | ES y DI |
| Modo de direccionamiento | Cualquier modo | Base o base-desplazamiento | Base o base-desplazamiento |