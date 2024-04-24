# Instrucciones

## Instrucciones de Movimiento 🏃🏽

```jsx
MOV destino, fuente
```

- Transfiere un byte o una palabra desde el operando fuente o elemento de memoria.
- Destino: registro de memoria
- Fuente: Registro elemento de memoria o valor inmediato

Ej:

```jsx
MOV ah, 0
MOV x, ah

❌ MOV x, 0 (mover valores a espacios de memoria)
✅ MOV al, ah (mover entre registros)

```

![Untitled](Instrucciones%20c3dfc39b42e64737a68a3ea3a28bde0d/Untitled.png)

## PUSH → 🔋

### PUSH fuente

- ⚠️ SOLAMENTE PARA PALABRAS (2 bytes)
- Decrementa el puntero de pila (SP) en 2.
- Transfiere el oprando fuente a la cima de la pila

### POP destino

Saca una palabra de la pila.

- Transfiere el elemento que se encuentra en la cima de la pila al operando destino.
- Incremente el puntero de pila (SP) en 2.

## LEA

```jsx
LEA destino, Fuente
```

Recuperar la difreccion de memoria del dato que queremos mover.

## LDS

```jsx
LDS destino fuente
```

- Transfiere un puntero de 32 (segmento y desplazamiento)
- Destino:  Debe ser un registro, pero no de segmento.
- Fuente: operando de memoria de doble pañabra

## LES

```jsx
LES destino, fuente
```

- Igual que LDS, epero el segmento se transfiere al segmento transfiere al registro ES.

![Untitled](Instrucciones%20c3dfc39b42e64737a68a3ea3a28bde0d/Untitled%201.png)