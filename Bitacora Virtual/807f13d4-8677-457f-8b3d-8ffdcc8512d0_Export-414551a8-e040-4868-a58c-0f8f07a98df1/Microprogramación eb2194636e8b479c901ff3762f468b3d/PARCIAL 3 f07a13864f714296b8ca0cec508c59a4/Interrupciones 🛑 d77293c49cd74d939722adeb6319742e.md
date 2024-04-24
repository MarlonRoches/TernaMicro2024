# Interrupciones 🛑

### Que es?

Alteraciones del programa que se ejecutan para llevar a cabo acciones especificas del sistema.

- Realiza un salto a una rutina especifica para luego reanudar la normal.

# Tipos:

- Hardware 🦾
    - Internas
        - No modificables
        - Manejadas y requeridas por el UC
        - Generadas por eventos en la ejecucion del programa
    - Externas
        - Generadas por las senales de los perifericos.
- Software 🧠
    - BIOS
        - Runtinas I/O y tablas de estados de dispositivos del sistema
        - No tienen proteccion
        - Rango: 0h a 19h
    - DOS
        - Funciones del SO para manipular Hardware
        - Abstraccion de las inerrupciones de la BIOS
        - Rango: 20h a 3fh
        - Generadas por ensablador
        - Ocupan la palabra ***INT*** y su numero asignado
        - Requieren condiciones previas de registros para su invocacion
    
    # Tablas de Servicios 🪠
    
    - Ocupa los primeros 1024 bytes de la memoria (000h - 03FFh)
    - contiene 256 interrupciones con su desplazamiento y posicion relativa
    - Tiene un vector de insterrupciones, que apuntan al ISR
        - ISR: Instrucciones que encapsulan a una insterrupcion.

# Eventos (Flujo de una insterrupcion) 🚶🏽‍♂️

1. **Termina la anterior**
2. Almacenamiento de.todos los registros nternos en la Pila (Push CS, IP, Banderas).
3. Instruction Pointer **(IP) recibe la dirección** del ISR para la interrupcion.
4. **Ejecución las instrucciones del ISR**, hasta encontrar IRET. (se ejecuta como **Metodo**)
5. **Regresa a donde se llamo:** Devolución de los registros internos al momento de la interrupción (Pop CS, IP, Banderas).