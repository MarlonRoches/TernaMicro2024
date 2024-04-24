# Loops 🔁

## LOOP dir

- Salta a la tag si CX es mayor que 0
- Resta 1 a CX

```jsx
// Inicializamos el registro CX a 10
var cx = 10;

// Bucle que se repite 10 veces
while (cx > 0) {
  // ...
  // ...
cx--
}

// cx =0 y sigue ya no salta
```

## **LOOPE / LOOPZ etiqueta**

- Salta si CX > 0 y Z ==1
- Z se establece cuando el resultado de la última instrucción es igual a 0.

```jsx
// Bucle que se repite mientras que el registro CX sea mayor que 0 y la bandera Z esté establecida
while (cx > 0 && z == 1) {
  // ...
cx--
}
// cx =0 o z=0
```

## **LOOPE / LOOPZ etiqueta**

- Salta si CX > 0 y Z ==0
- Z se establece cuando el resultado de la última instrucción es igual a 0.

```jsx
// Bucle que se repite mientras que el registro CX sea mayor que 0 y la bandera Z esté establecida
while (cx > 0 && z == 0) {
  // ...
  // ...
cx--
}
// cx =0 o z=1
```