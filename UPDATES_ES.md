## 18 de enero de 2026 — Prueba de Entrenamiento con Mini‑Cerebro

Antes de comenzar el entrenamiento a largo plazo con la red de tamaño completo, creé una versión de “mini‑cerebro” de BB‑Zero para validar todo el sistema de entrenamiento. Un proyecto de referencia en damas inglesas mostró que una red muy pequeña puede aprender rápidamente, así que este experimento ayuda a confirmar si mi arquitectura, el bucle MCTS y la generación del dataset están funcionando correctamente.

El plan es ejecutar esta red reducida durante 2–3 días y monitorear todos los registros y métricas. Si aprende, restauraré la red de tamaño completo para el entrenamiento a largo plazo. Si no aprende, inspeccionaré el código en busca de problemas estructurales.

---

## 20 de enero de 2026 — Resultados del Mini‑Cerebro, Arreglos y Próximos Pasos

Después de dos días de pruebas, la red reducida (“small‑brain”) no mostró aprendizaje.  
Compararla con el proyecto de referencia AlphaCheckers‑Zero de MadrasLe (https://github.com/MadrasLe/AlphaCheckers-Zero) ayudó a revelar varios problemas estructurales en mi programa. También doy crédito a MadrasLe por dos ideas que mejoraron significativamente BB‑Zero:  
el mapeo de política basado en el origen y el uso de una mapa de movimientos legales, que mi programa no incluía originalmente.

A diferencia de las damas inglesas, las damas españolas son mucho más complejas (cadenas largas de captura, capturas obligatorias estrictas, múltiples casillas de coronación, reglas de empates, detección completa de repeticiones y un sistema de legalidad mucho más profundo). Esta complejidad requiere más datos de entrenamiento y una red más grande.

Para comparar de manera justa, reduje temporalmente mi red al tamaño del proyecto de referencia.  
Esto expuso varios problemas, incluyendo propagación de Q‑values, asignación de priors, mapa de movimientos legales, estructura interna del estado del juego y el mapeo de política basado en el origen.  
Todos estos problemas ya han sido corregidos.

## 25 de enero de 2026 — Preparación para el Entrenamiento Completo

Debido a que las damas españolas requieren mayor capacidad, regresaré a la red de tamaño completo y la entrenaré con más partidas que el proyecto de referencia.  
Antes de comenzar el entrenamiento de partidas completas, ejecutaré una última prueba: una sesión de entrenamiento de final de damas‑vs‑damas para verificar estabilidad y comportamiento.

Un nuevo folder, `technical_data/`, almacenará partidas de ejemplo, métricas, registros, notas técnicas e imágenes para documentar la evolución de BB‑Zero conforme el proceso de entrenamiento quede completamente validado.

## 30 de enero de 2026 — Preparando a BB‑Zero para lo imposible

Hoy cierro una etapa importante. Probé dos ejemplos controlados de finales para verificar que todo el motor funcionara bajo condiciones reales y lentas. A pesar de que BB‑Zero corre en Python, en una sola computadora, sin la velocidad de un motor en C++, el sistema se comportó sorprendentemente bien. El paralelismo, los batches de inferencia y las funciones optimizadas compensan lo que Python no puede dar. Un programa lentisimo en Python… pero sólido.

Estos dos finales fueron suficientes para demostrar que el pipeline completo está sano: el MCTS, la red, la generación de datasets y el entrenamiento. Incluso con pocas simulaciones, BB‑Zero aprendió patrones reales. Eso me dio la confianza para diseñar un plan de entrenamiento que pueda sobrevivir a mis limitaciones de hardware.

La idea del ORIGEN (inspirada en MadrasLe) resultó ser una ventaja enorme. Le da estructura al árbol y contexto a las jugadas, algo que la red sola no puede ver en damas españolas. Y con un cerebro convolucional de 15 MB, BB‑Zero tiene espacio para aprender maniobras largas, finales complejos y estilo propio.

El objetivo final es ambicioso: enfrentar a Profound, el monstruo absoluto, el “Stockfish” de las damas clásicas. Un motor artesanal, optimizado a mano, escrito en C++, y con décadas de ventaja. Si BB‑Zero logra competir —aunque sea un poco— será un logro enorme. Un verdadero David contra Goliat, hecho con una sola máquina, datasets caseros y pura terquedad científica.

BB‑Zero ya está listo. Ahora comienza el entrenamiento brutal: meses de disciplina, constancia y una persistencia casi obsesiva. No hay atajos, no hay milagros. Solo un lentisimo programa en Python, un cerebro de 15 MB y la voluntad de desafiar a Profound, el gigante de gigantes. Desde este momento, empieza la batalla larga… empieza el entrenamiento sin parar.

![Profound](https://github.com/Coconut3600/BB-Zero/blob/main/images/Profound.png?raw=true)

## Plan de Entrenamiento (Feb–Jun 2026)

**Febrero 2026**  
• 40 simulaciones por jugada  
• 200,000 partidas de autojuego  
• Entrenar cada 10,000 partidas  
• Objetivo: intuición global y reconocimiento de patrones básicos

**Marzo 2026**  
• 80 simulaciones por jugada  
• 100,000 partidas de autojuego  
• Entrenar cada 5,000 partidas  
• Objetivo: refinar estructuras defensivas y estabilizar el juego

**Abril 2026**  
• 800 simulaciones por jugada  
• 10,000 partidas de autojuego  
• Entrenar cada 500 partidas  
• Objetivo: precisión táctica, cálculo profundo y finales complejos

**Mayo 2026**  
• 1,600 simulaciones por jugada  
• 5,000 partidas de autojuego  
• Entrenar cada 250 partidas  
• Objetivo: pulido final, consolidación de estilo y preparación para torneo

**Junio 2026**  
• Evaluación final  
• Match completo: **BB‑Zero vs. Profound**  
• Objetivo: medir la verdadera fuerza del motor después de meses de entrenamiento

## 5 de febrero de 2026 — Entrenamiento

BB‑Zero ya alcanzó su cuarto ciclo de entrenamiento. Aún no he probado jugar contra los cerebros del ciclo 2 ni del ciclo 3, pero sí jugué varias partidas contra el cerebro generado en el ciclo 1.

En la primera prueba ese cerebro me ganó una partida, aunque yo estaba cansado y no jugué bien. Al día siguiente jugué otra vez, esta vez con 80 simulaciones, y logré empatar, pero con mucha dificultad. Hoy volví a enfrentarme al mismo cerebro del primer entrenamiento, también a 80 simulaciones, tratando de jugar lo mejor posible… y volvió a ganarme. Comparto la foto y la partida completa.

![BB-Zero vs yo](https://github.com/Coconut3600/BB-Zero/blob/main/images/bb_zero_vs_me.jpg?raw=true)

Estuve platicando con mi consultante Herson, y quizá pronto juguemos una partida en la plataforma PlayOK, para ofrecer algunos juegos amistosos con BB‑Zero a los aficionados. Su página es una referencia excelente sobre Damas Clásicas: documenta los mejores programas, partidas computadora vs computadora y enfrentamientos contra grandes maestros: https://damasclasicas.blogspot.com/

**Partida jugada (0–1):**  
1.11-15, 21-18; 2.15-19, 22x15; 3.12x19, 23x14; 4.10x19, 27-23; 5.06-10, 23x14; 6.10x19, 31-27; 7.05-10, 27-23; 8.02-05, 23x14; 9.10x19, 25-21; 10.05-10, 28-23; 11.19x28, 32x23; 12.07-11, 23-19; 13.08-12, 26-22; 14.12-16, 21-17; 15.04-08, 30-27; 16.08-12, 29-26; 17.11-15, 27-23; 18.16-20, 23x16x07; 19.03x12, 26-21; 20.12-16, 19x12; 21.01-05, 22-19; 22.09-13, 18x09x02; 23.10-13, 17x10; 24.16-20, 24x15; 0–1

##  8 de febrero de 2026 — Ciclo 4: crisis, aprendizaje y nuevo rumbo

No soy ingeniero en IA; estoy aprendiendo. Tampoco soy buen jugador de damas clásicas españolas, por eso uso a *Matilde* como referencia. En este ciclo BB‑Zero empezó a regalar piezas, como si se frustrara al no poder ganarme, y pensé que había dañado el cerebro por sobreentrenamiento.

Para comprobarlo subí las simulaciones a 300 y lo enfrenté a Matilde. Para mi sorpresa llegó a un final empatado, pero terminó perdiendo porque no sabe mantener la dama. Esto confirmó que el problema real no es el cerebro: **son los finales**. Sin patrones de finales, el motor evalúa mal, cae en trampas y necesita millones de partidas para aprender algo que puedo enseñarle directamente.

Decidí pausar el entrenamiento general y crear un **curriculum de finales**: pequeñas “vitaminas” para el cerebro artificial. Entrenaré posiciones clave (manejo de dama, finales de tablas, persecuciones, trampas típicas) con simetrías y cambios de color. Luego mezclaré estos datasets con el self‑play normal y reanudaré el entrenamiento continuo por varios meses.


### Partida contra Matilde

1.10-13, 21-17; 2.13-18, 22x13; 3.09x18, 26-21; 4.12-15, 21x14;
5.11x18, 29-26; 6.05-10, 23-20; 7.07-11, 28-23; 8.10-14, 17-13;
9.01-05, 13-09; 10.05-10, 27-22; 11.18x27, 31x22; 12.10-13, 26-21;
13.03-07, 21-17; 14.06-10, 09-05; 15.02x09, 20-16; 16.08-12, 25-21;
17.13-18, 22x13x06; 18.14-19, 23x14; 19.11x18x25, 06-02; 20.15-19, 30-27;
21.25-29, 02-05; 22.12-15, 05x23; 23.09-13, 17x10; 24.15-19, 23x14;
25.07-12, 16x07; 26.04x11x18, 10-05; 27.18-21, 27-23; 28.29-12, 23-19;
29.12x22, 05-01; 30.21-26, 01-05; 31.26-30, 05-09; 32.22-08

### Matilde vs BB-Zero(Negro)

![bbzero_matilde](https://github.com/Coconut3600/BB-Zero/blob/main/images/bbzero_matilde.png)

Nota: Tras 32.22-08, la jugada 09-18 es perdedora. La jugada correcta es 9-31



## 12 de febrero de 2026 — Nueva Dirección de Entrenamiento y Simetrías con Espejo Horizontal

Después de experimentar con conjuntos de datos de finales, me di cuenta de que el curriculum learning estaba desestabilizando el cerebro. Forzar finales o agregar ejemplos artificiales generaba rigidez y comportamientos inconsistentes, mientras que las últimas 40,000 partidas de autojuego mostraron que BB‑Zero aprende mucho mejor mediante estabilidad, disciplina e intuición natural. Algunos finales ya están siendo manejados correctamente sin haber sido enseñados explícitamente, lo que confirma que el cerebro está aprendiendo por sí mismo. Por esta razón, detengo la creación de conjuntos de datos de finales por ahora. Aunque perdí casi una semana que podría haberse usado para generar más datos, implementar el espejo horizontal (simetrías) es un gran avance que compensa con creces ese tiempo. El espejo se aplica directamente en Keras/TensorFlow, no consume tiempo adicional y duplica instantáneamente el volumen efectivo de entrenamiento.

A partir de hoy, el entrenamiento continuará con un plan simple y estable: 40 simulaciones por movimiento, ciclos de 10,000 partidas de autojuego, el espejo horizontal completamente habilitado y la arquitectura de origen+mask para mantener limpio el espacio de acciones. Este será un experimento a largo plazo durante los próximos cuatro meses para ver si la consistencia, la paciencia y la intuición pueden convertir a BB‑Zero en un motor experto de damas clásicas capaz de empatar y eventualmente derrotar a programas fuertes.

También terminé un pequeño video mostrando la GUI de BB‑Zero, y lo comparto aquí para documentar el progreso del proyecto: https://www.youtube.com/watch?v=9LgB3CJ3WV4

## 18 de febrero de 2026 — Ciclo 7: estabilidad, simetrías y el comienzo del aprendizaje real

Después de una semana intensa de entrenamiento continuo, BB‑Zero acaba de completar su séptimo ciclo, alcanzando 70,000 partidas de autojuego a 40 simulaciones por movimiento. Este ciclo marca un punto importante en el proyecto: por primera vez, las métricas muestran una mejora clara y consistente, señal de que el cerebro está empezando a aprender patrones reales de juego.

### El impacto del espejo horizontal

En el ciclo 5 habilité por completo el espejo horizontal, una simetría aplicada directamente en Keras/TensorFlow que duplica cada posición del dataset sin costo adicional de tiempo.  
Esto significa que:

• Aunque cada ciclo genera 10,000 partidas reales  
• El entrenamiento recibe el equivalente a 20,000 posiciones gracias al espejo  

En el ciclo 5 esto introdujo ruido, algo totalmente esperado: la red tuvo que reorganizarse para integrar la nueva simetría.  
Pero ahora, en los ciclos 6 y 7, ese ruido se transformó en estabilidad y mejor generalización.

### Ciclo 7: el mejor ciclo hasta ahora

Las métricas del ciclo 7 muestran la primera señal sólida de aprendizaje:

• total_loss bajó a 1.6887  
• policy_loss bajó a 1.5088  
• value_loss bajó a 0.1844  
• ratio subió a 8.18 (más estabilidad interna)

Estas mejoras indican:

• Una política más coherente  
• Un value más estable y preciso  
• Menos ruido interno  
• Mejor entendimiento de quién está ganando o perdiendo en posiciones típicas  

Es, sin duda, el ciclo más fuerte del proyecto hasta la fecha.

### Corrección importante: medir progreso contra Matilde, no contra mí

En una actualización anterior mencioné que BB‑Zero me había ganado una partida.  
Eso fue un error de interpretación: yo soy un jugador muy débil de damas clásicas españolas, así que usarme como referencia no tiene ningún valor científico.

A partir de ahora, la única métrica válida será enfrentar a BB‑Zero contra “Matilde”, el motor de nivel medio incluido en Checkersboard.  
Matilde es un rival estable, consistente y perfecto para medir progreso real.

### Nuevo protocolo de evaluación

A partir de este viernes comenzaré un ritual semanal:

**Cada viernes: match de 3 rondas (cambiando colores) contra Matilde.**

Publicaré:

• Las partidas completas  
• Comentarios  
• Errores típicos  
• Señales de mejora o retroceso  

El objetivo es observar si BB‑Zero sigue recibiendo palizas o si empieza a mostrar resistencia.

### Plan de entrenamiento continuo

El entrenamiento seguirá con la misma disciplina:

• 40 simulaciones por movimiento  
• Entrenamiento cada 10,000 partidas  
• Espejo horizontal activado  
• Origen + máscara legal para mantener limpio el espacio de acciones  

Cuando BB‑Zero logre:

• Empatar consistentemente partidas completas contra Matilde  
• O conseguir su primera victoria real  

Entonces subiré el entrenamiento a 60 simulaciones por movimiento.

### Un bebé que empieza a caminar

Me emocioné cuando BB‑Zero me ganó una partida y cuando casi empata contra Matilde.  
Pero la realidad es que aún es un bebé: comete errores graves, pierde finales simples y todavía no entiende cómo manejar una dama.

Aun así, este ciclo 7 demuestra que:

• La constancia  
• La disciplina  
• La estabilidad  
• Y la paciencia  

son suficientes para que un motor pequeño, hecho en Python y entrenado en una sola computadora, empiece a aprender de verdad.

El objetivo final sigue intacto: desafiar a Profound, el gigante absoluto de las damas clásicas.

Falta muchísimo, pero por primera vez, el camino se ve claro.

Este viernes publicaremos un enfrentamiento a 3 rounds cambiando color contra Matilde para ver si sigue recibiendo palizas.


