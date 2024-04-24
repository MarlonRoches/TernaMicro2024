# Comparativas 🧪

## TEST fuente1, fuente2

- Realiza opearicon AND entre 2 operandos
- No almacena resultado
- Modifica banderas de registro

```nasm
[banderaZ, banderaOver, ... ] = TEST(fuente1, fuente2) 
// const resultado = fuente1 && fuente2
```

## CMP fuente1, fuente2

- Realiza una resta entre operandos
- No almacena resutado
- actualiza banderas

```nasm
[banderaZ, banderaOver, ... ] = CMP(fuente1, fuente2) 
// const resultado = fuente1 - fuente2
```