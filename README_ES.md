## BB‑Zero — Descripción General del Proyecto

BB‑Zero es un motor estilo AlphaZero para damas españolas, utilizando PUCT, Monte Carlo Tree Search, ruido Dirichlet, temperatura y autoentrenamiento puro sin heurísticas. La primera versión completa del programa se terminó el 16 de enero de 2026. La siguiente fase comienza ahora: generar todos los conjuntos de datos de entrenamiento desde cero y documentar todo el proceso conforme el proyecto avanza.

El motor está escrito 100% en Python dentro de un solo archivo .py y es compatible con Linux y Windows. BB‑Zero incluye tres modos integrados: Modo de Juego, Modo de Creación de Datasets y Modo de Entrenamiento.

Mi objetivo a largo plazo es claro: **desafiar y eventualmente derrotar a Profound**, uno de los motores más fuertes de damas españolas documentado en la página **Programas de Damas Clásicas de Herson P. Guier**:  
https://damasclasicas.blogspot.com/

Se estima que el proyecto estará terminado alrededor de **junio de 2026**.

---

## Estado Actual

Durante los primeros meses de 2026 validé todo el pipeline de entrenamiento de BB‑Zero utilizando una red reducida tipo “mini‑brain”. Este proceso reveló varios problemas estructurales en mi implementación original de AlphaZero. El más importante fue descubierto en abril: un error en la forma en que manejaba el origin plane dentro del tensor de política. Ese fallo distorsionaba los objetivos de π y dañaba silenciosamente el entrenamiento. Después de identificarlo, reconstruí por completo la lógica de generación de la política y corregí el manejo del plano de origen. Con esta corrección, el pipeline de entrenamiento se estabilizó y los datos de self‑play se volvieron consistentes.

Durante la misma refactorización también desarrollé un nuevo enfoque de búsqueda persistente, inspirado en la idea de los árboles persistentes de DeepMind, pero sin depender de una estructura clásica de árbol. Este diseño será documentado próximamente en la sección technical_data.


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

