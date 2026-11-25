## BB‑Zero — Descripción General del Proyecto

BB‑Zero es un motor estilo AlphaZero para damas españolas, que utiliza PUCT, Monte Carlo Tree Search (MCTS), ruido Dirichlet, temperatura y autoentrenamiento puro (*self‑play*) sin heurísticas. El primer prototipo completo del programa se terminó el 16 de enero de 2026 y, tras meses de optimización, el motor ya está finalizado y entrando en la fase de entrenamiento a gran escala.

Escrito originalmente al 100 % en Python, BB‑Zero ha evolucionado hacia una **arquitectura híbrida en Python + bitboards en C++**, aumentando drásticamente su velocidad y manteniendo la compatibilidad tanto con Linux como con Windows. En su núcleo incorpora una **arquitectura personalizada de árbol persistente plano con reciclaje de memoria** (separando las estadísticas activas de búsqueda de los estados del tablero con reciclaje en O(1)) que mantiene el consumo de RAM y CPU muy bajo. *(Corrección/Nota: anteriormente describí esta estructura como una invención propia más rápida que el árbol de Leela Zero. Tras realizar pruebas comparativas e investigar más a fondo, comprobé que había llegado de forma independiente a principios del **Diseño Orientado a Datos** y **Structure of Arrays (SoA)**, una técnica clásica de organización en memoria nacida en la década de 1970 que resulta especialmente eficaz para ejecutar cientos de árboles de self‑play en paralelo.)* Esto permite que una laptop *gamer* estándar ejecute cientos de *workers* en paralelo, cada uno construyendo su propio árbol persistente de manera simultánea. BB‑Zero incluye tres modos integrados: Modo de Juego, Modo de Creación de Datasets y Modo de Entrenamiento.

Mi objetivo a largo plazo es claro: **desafiar y eventualmente derrotar a Profound**, uno de los motores más fuertes de damas españolas documentado en la página **Programas de Damas Clásicas de Herson P. Guier**:  
https://damasclasicas.blogspot.com/

Se estima que el proyecto estará terminado alrededor de **enero de 2027**.

---

## Estado Actual

Durante 2026, continué refinando y depurando toda la canalización de entrenamiento de BB‑Zero. Un avance decisivo fue identificar y corregir un error incompleto de inversión de signos durante las transformaciones del tablero según la perspectiva del jugador, el cual había estancado el aprendizaje anteriormente. Inmediatamente después de esta corrección, una prueba corta de apenas **25,000 partidas de self‑play** logró empatar contra un motor de nivel experto, un resultado que había sido imposible incluso tras 80,000 partidas antes de corregir el error.

El 1 de noviembre de 2026 también completé una actualización importante en la representación de políticas de BB‑Zero. La salida de la red fue ampliada a un espacio unificado de **1024 acciones de política** con enmascaramiento estricto de movimientos legales en la inferencia, el MCTS y el entrenamiento, eliminando código heredado de versiones anteriores del motor.

Gracias a la velocidad y eficiencia en memoria del nuevo núcleo de bitboards en C++ y de la estructura de búsqueda personalizada, el motor escala ahora de 4–8 *workers* hasta **512–1,024 *workers* simultáneos** en una RTX 4060 (16 GB de RAM), manteniendo el consumo de memoria bajo y estable. Debido a esta enorme aceleración, lo que antes requería meses ahora puede completarse en **un par de semanas**.

### Plan de Entrenamiento (Comienza el Domingo 22 de Noviembre de 2026)

El entrenamiento a gran escala comienza **este domingo 22 de noviembre de 2026** utilizando una **ventana deslizante de 200,000 partidas** (eliminando automáticamente las partidas más antiguas conforme se acumulan nuevas) y ejecutando **512 *workers* concurrentes las 24 horas del día** para mantener una estabilidad térmica óptima:

1. **Experimento 1 — Red Pequeña (~7 MB, *La Marioneta*):** Ejecución ininterrumpida durante **1 semana** de autojuego puro para maximizar el volumen de partidas y validar el escalado.
2. **Experimento 2 — Red Grande (~30 MB, *La MarionetaG*):** Preentrenada con una base de datos de partidas clásicas de damas españolas jugadas entre los mejores motores y grandes maestros —convertida mediante mi herramienta personalizada **`txt2npz`** (adaptada a partir de *verifikator*)—, seguida de **2 semanas** de autojuego continuo.

Una vez concluido el entrenamiento, BB‑Zero será puesto a prueba en partidas de evaluación contra motores expertos (incluido *Matilde* de CheckerBoard) para medir su fuerza y determinar si está listo para enfrentarse a **Profound**.
---

## Video de la GUI

Aquí puedes ver una demostración corta de la interfaz gráfica de BB‑Zero.  
(Nota: la red neuronal mostrada aquí aún no ha sido entrenada correctamente.)

https://www.youtube.com/watch?v=9LgB3CJ3WV4

---

## Plan de Publicación

Una vez completado el entrenamiento, se liberará el código fuente de la **GUI de BB‑Zero** y del **motor de bitboards en C++** para que cualquier persona pueda compilarlo y jugarlo, incluyendo ya la red neuronal pequeña entrenada (*La_Marioneta*, ~7 MB).

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

