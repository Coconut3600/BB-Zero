## 18 de enero de 2026 — Prueba de Entrenamiento con Mini‑Cerebro

Antes de comenzar el entrenamiento a largo plazo con la red de tamaño completo, creé una versión de “mini‑cerebro” de BB‑Zero para validar todo el sistema de entrenamiento. Un proyecto de referencia en damas inglesas mostró que una red muy pequeña puede aprender rápidamente, así que este experimento ayuda a confirmar si mi arquitectura, el bucle MCTS y la generación del dataset están funcionando correctamente.

El plan es ejecutar esta red reducida durante 2–3 días y monitorear todos los registros y métricas. Si aprende, restauraré la red de tamaño completo para el entrenamiento a largo plazo. Si no aprende, inspeccionaré el código en busca de problemas estructurales.

---

## 20 de enero de 2026 — Resultados del Mini‑Cerebro, Arreglos y Próximos Pasos

Después de dos días de pruebas, la red reducida (“small‑brain”) no mostró aprendizaje.  
Compararla con el proyecto de referencia AlphaCheckers‑Zero de MadrasLe (https://github.com/MadrasLe/AlphaCheckers-Zero) ayudó a revelar varios problemas estructurales en mi programa. También doy crédito a MadrasLe por dos ideas que mejoraron significativamente BB‑Zero:  
el mapeo de política basado en el origen y el uso de una mapa de movimientos legales, que mi programa no incluía originalmente.

A diferencia de las damas inglesas, las damas españolas son mucho más complejas (cadenas largas de captura, capturas obligatorias estrictas, múltiples casillas de coronación, reglas de tablas de 20 y 12 movimientos, detección completa de repeticiones, repetición ABABAB y un sistema de legalidad mucho más profundo). Esta complejidad requiere más datos de entrenamiento y una red más grande.

Para comparar de manera justa, reduje temporalmente mi red al tamaño del proyecto de referencia.  
Esto expuso varios problemas, incluyendo propagación de Q‑values, asignación de priors, mapa de movimientos legales, estructura interna del estado del juego y el mapeo de política basado en el origen.  
Todos estos problemas ya han sido corregidos.

## 25 de enero de 2026 — Preparación para el Entrenamiento Completo

Debido a que las damas españolas requieren mayor capacidad, regresaré a la red de tamaño completo y la entrenaré con más partidas que el proyecto de referencia.  
Antes de comenzar el entrenamiento de partidas completas, ejecutaré una última prueba: una sesión de entrenamiento de final de damas‑vs‑damas para verificar estabilidad y comportamiento.

Un nuevo folder, `technical_data/`, almacenará partidas de ejemplo, métricas, registros, notas técnicas e imágenes para documentar la evolución de BB‑Zero conforme el proceso de entrenamiento quede completamente validado.

## 30 de enero de 2026 — Preparando a BB‑Zero para lo imposible

Hoy cierro una etapa importante. Probé dos ejemplos controlados de finales para verificar que todo el motor funcionara bajo condiciones reales y lentas. A pesar de que BB‑Zero corre en Python, en una sola computadora, sin la velocidad de un motor en C++, el sistema se comportó sorprendentemente bien. El paralelismo, los batches de inferencia y las funciones optimizadas compensan lo que Python no puede dar. Un slow python program… pero sólido.

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

