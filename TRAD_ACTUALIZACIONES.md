## 18 de enero de 2026 — Prueba de Entrenamiento con Cerebro Pequeño

Antes de comenzar el entrenamiento a largo plazo con la red de tamaño completo, decidí realizar un último experimento. Recientemente encontré un proyecto de damas españolas en GitHub que alcanzó un nivel sorprendentemente bueno en solo unas horas entrenando una red neuronal muy pequeña.

Como la red principal de BB‑Zero es mucho más grande y tardará bastante en aprender, creé una versión de “cerebro pequeño” de mi motor para verificar si mi pipeline de entrenamiento está funcionando correctamente. Si una red diminuta puede aprender a jugar bien, entonces sabré que la arquitectura, el bucle de MCTS y la lógica de entrenamiento están implementados correctamente.

A partir de mañana, ejecutaré este cerebro pequeño de manera continua durante 2–3 días y revisaré todos los logs y métricas para ver si realmente aprende. Si no aprende, tendré que inspeccionar el código en busca de errores o lógica faltante. Si el experimento funciona, restauraré la red de tamaño completo y comenzaré el entrenamiento a largo plazo hasta acumular suficientes ejemplos para un aprendizaje real.

Este experimento me ayudará a confirmar que BB‑Zero está listo para la siguiente fase.
