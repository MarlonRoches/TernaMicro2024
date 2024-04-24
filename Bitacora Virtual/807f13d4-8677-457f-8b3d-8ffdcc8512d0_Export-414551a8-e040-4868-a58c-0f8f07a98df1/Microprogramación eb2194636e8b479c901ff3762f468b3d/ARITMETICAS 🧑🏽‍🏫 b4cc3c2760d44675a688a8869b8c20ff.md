# ARITMETICAS 🧑🏽‍🏫

# Suma ➕

```jsx
ADD destino, fuente
destuno = destino + fuente

//EJ: 5+3
MOV ah, 5
MOV al,3

ADD ah, al
// ah = ah + al
```

- Resultado se almacena en destino
- Deben ser del mismo tipo (byte o palabra)

## ADC Suma ➕

```jsx
ADC destino, fuente
destino= fuente + destino
// if(acarreo) destino + 1
```

- Suma los 2 operandos, incrementando en 1 si la bandera de acarreo esta activada.

## RESTA ➖

```jsx
SUB destino, fuente
destino = destino - fuente
// grande - peque

SBB destino, fuente
destino = destino - fuente
// if(acarreo) destino + 1
```

- Si es negativo, se complementa a 2.

# Multiplicacion ✖️

```jsx
MUL fuente

// AX = fuente * al
```

1. el primer factor debe moverlo al (byte) o ax (palabra)
2. Resultado se guarda en AX (palabra) 
3. Doble Palabra
    1. DX:AX
    2. Mas significativos (DX)
    3. Menos significativos (AX)

```jsx
IMUL fuente
```

- Lo mismo que MUL, pero toma en cuenta el signo

# Division ➗

```jsx
DIV fuente
```

- Divide sin considerar el signo

![Untitled](ARITMETICAS%20%F0%9F%A7%91%F0%9F%8F%BD%E2%80%8D%F0%9F%8F%AB%20b4cc3c2760d44675a688a8869b8c20ff/Untitled.png)

![Untitled](ARITMETICAS%20%F0%9F%A7%91%F0%9F%8F%BD%E2%80%8D%F0%9F%8F%AB%20b4cc3c2760d44675a688a8869b8c20ff/Untitled%201.png)

# INC destino

```jsx
INC destino
destino ++
```

## DEC destino

```jsx
DEC destino
destino--
```

## NEG destino

Niega el destino y complementa en 2

```jsx

```