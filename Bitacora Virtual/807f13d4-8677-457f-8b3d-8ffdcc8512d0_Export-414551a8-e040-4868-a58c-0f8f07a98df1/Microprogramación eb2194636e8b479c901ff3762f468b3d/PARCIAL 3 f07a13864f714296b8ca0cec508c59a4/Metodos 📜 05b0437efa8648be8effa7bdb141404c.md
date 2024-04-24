# Metodos 📜

- Modularizan el programa
- **Retornan** al punto donde se quedaron anteriormente al ser llamados.

### Reservadas:

- Proc: Inicio Declaracion
- EndP: Fin de Declaracion
- Ret: Regreso
- Call: Llamada
- near:
    - Desplazamiento de 16 bits
    - Mismo segmento de codigo
- far:
    - diferente segmento de codigo al principal o donde se ejecuta todo.

```nasm

Definicion:
<Id_Proc> proc near | far
<Secuencia de instrucciones>
ret
<Id_Proc> endp

Uso:
call <Id_Proc>

Ejemplo:
Proc_ej proc near
MOV AX, BX
ret

Proc_ej endp
call proc_ej
```