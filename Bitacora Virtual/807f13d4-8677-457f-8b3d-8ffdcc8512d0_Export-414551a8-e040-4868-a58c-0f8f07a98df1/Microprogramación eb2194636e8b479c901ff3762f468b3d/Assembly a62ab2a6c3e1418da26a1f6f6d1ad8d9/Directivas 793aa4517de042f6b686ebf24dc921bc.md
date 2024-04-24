# Directivas

Indican al ensamblador la estructura del programa.

Inicializan los segmentos. 

Gobiernan el programa.

### Regex:

Dir = `´.´(L|D)´`

### Ej:

- *.data*
    - segmento de datos
- *.model*
    - indicar el modelo del programa.
- *.stack*
    - inicializa segmento de pila.
- *.80286*
    - Indica que se emulara y retrocompatibilidad para el intel 80286.