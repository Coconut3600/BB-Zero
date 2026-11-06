## BB‑Zero — Descripción General del Proyecto

BB‑Zero es un motor estilo AlphaZero para damas españolas, utilizando PUCT, Monte Carlo Tree Search, ruido Dirichlet, temperatura y autoentrenamiento puro sin heurísticas. La primera versión completa del programa se terminó el 16 de enero de 2026. La siguiente fase comienza ahora: generar todos los conjuntos de datos de entrenamiento desde cero y documentar todo el proceso conforme el proyecto avanza.

El motor está escrito 100% en Python dentro de un solo archivo .py y es compatible con Linux y Windows. BB‑Zero incluye tres modos integrados: Modo de Juego, Modo de Creación de Datasets y Modo de Entrenamiento.

Mi objetivo a largo plazo es claro: **desafiar y eventualmente derrotar a Profound**, uno de los motores más fuertes de damas españolas documentado en la página **Programas de Damas Clásicas de Herson P. Guier**:  
https://damasclasicas.blogspot.com/

Se estima que el proyecto estará terminado alrededor de **enero de 2026**.

---

## Estado Actual

Durante 2026, continué refinando y validando la canalización de entrenamiento de BB‑Zero. A principios de año, corregí varios problemas que afectaban la generación de datos de self‑play y la consistencia del entrenamiento, lo que resultó en conjuntos de datos más limpios y un comportamiento de aprendizaje más estable. 

El 1 de noviembre de 2026 completé una actualización importante en la representación de políticas de BB‑Zero. La salida de la red fue ampliada a un espacio de políticas de 1024 acciones, permitiendo al motor representar directamente el espacio completo de acciones. Durante esta transición también se identificaron y eliminaron varias funciones heredadas de versiones anteriores del motor. 

BB‑Zero ahora aplica una máscara de movimientos legales sobre la política completa de 1024 acciones, garantizando que la inferencia de la política, el MCTS y el entrenamiento utilicen la misma representación de acciones. Además, la canalización de entrenamiento puede utilizar tanto una ventana de entrenamiento ilimitada como una ventana limitada de hasta dos millones de partidas de self‑play. En paralelo, desarrollé e integré una estructura de búsqueda inspirada en el árbol persistente de AlphaZero, manteniendo un rendimiento significativamente más rápido y un uso de memoria más eficiente en la práctica. 

El entrenamiento continuará durante noviembre, diciembre y enero utilizando aproximadamente 800 simulaciones por movimiento para acumular más datos de self‑play y evaluar el impacto de estas mejoras arquitectónicas. Una vez que la nueva red alcance una fuerza suficiente, planeo realizar partidas de evaluación contra Matilde de Checkersboard para medir el progreso y establecer una referencia de rendimiento.

---

## Video de la GUI

Aquí puedes ver una demostración corta de la interfaz gráfica de BB‑Zero.  
(Nota: la red neuronal mostrada aquí aún no ha sido entrenada correctamente.)

https://www.youtube.com/watch?v=9LgB3CJ3WV4

---

## Plan de Publicación

Una vez completado el entrenamiento, BB‑Zero se publicará como un ejecutable para Windows (~180 MB) junto con su red neuronal *La_Marioneta* (~15 MB), permitiendo que cualquiera pueda jugar con él.

---

## Agradecimientos

Agradecimientos especiales a **Herson P. Guier**, mi consultor y experto en reglas, cuyo profundo conocimiento de las damas españolas ha sido esencial para este proyecto.

**Autor:** Alberto Cervantes  
**Palabras clave:** damas españolas, Spanish checkers, damas clásicas, motor de damas, AlphaZero, IA, Monte Carlo, reinforcement learning, PUCT, redes neuronales.

---

## Vista Previa de la GUI

A continuación se muestra una captura de pantalla de la GUI actual.  
(Nota: la red neuronal mostrada aquí aún no ha sido entrenada correctamente.)

### Modo de Juego

![Modo de Juego](images/gameplay_es.png)

