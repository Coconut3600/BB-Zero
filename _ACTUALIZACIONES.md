## 18 de enero de 2026 — Prueba de Entrenamiento con Cerebro Pequeño

Antes de comenzar el entrenamiento a largo plazo con la red de tamaño completo, decidí realizar un último experimento. Recientemente encontré un proyecto de damas inglesas o "checkers" en GitHub que alcanzó un nivel sorprendentemente bueno en solo unas horas entrenando una red neuronal muy pequeña.

Como la red principal de BB‑Zero es mucho más grande y tardará bastante en aprender, creé una versión de “cerebro pequeño” de mi motor para verificar si mi pipeline de entrenamiento está funcionando correctamente. Si una red diminuta puede aprender a jugar bien, entonces sabré que la arquitectura, el bucle de MCTS y la lógica de entrenamiento están implementados correctamente.

A partir de mañana, ejecutaré este cerebro pequeño de manera continua durante 2–3 días y revisaré todos los logs y métricas para ver si realmente aprende. Si no aprende, tendré que inspeccionar el código en busca de errores o lógica faltante. Si el experimento funciona, restauraré la red de tamaño completo y comenzaré el entrenamiento a largo plazo hasta acumular suficientes ejemplos para un aprendizaje real.

Este experimento me ayudará a confirmar que BB‑Zero está listo para la siguiente fase.

## 20 de enero de 2026 — Resultados del Experimento y Correcciones Críticas

Después de dos días ejecutando el experimento con el “cerebro pequeño”, confirmé que la red reducida no estaba aprendiendo absolutamente nada. Esto fue inesperado, ya que un proyecto de referencia —**AlphaCheckers‑Zero de MadrasLe** (https://github.com/MadrasLe/AlphaCheckers-Zero)— logra un nivel de juego amateur en pocas horas usando una red diminuta. Gracias a ese contraste pude detectar varios errores profundos en mi pipeline.

Es importante mencionar que MadrasLe trabaja con **damas inglesas**, una variante mucho más simple: reglas reducidas, forzosa básica, coronaciones directas y sin cadenas largas. En cambio, BB‑Zero implementa **damas españolas completas**, con reglas estrictas de forzosa, coronaciones complejas, cadenas de captura extensas, empates por 20 y por 12, repetición general de posiciones, repetición ABABAB y un sistema de legalidad mucho más detallado. Él simplificó para acelerar el aprendizaje; yo hice lo contrario.

Para hacer una comparación justa, reduje temporalmente mi red al **mismo tamaño que la suya**. Esto reveló varios problemas:  
- errores en la propagación de valores Q,  
- priors mal asignados en nodos del MCTS,  
- fallos en la máscara de movimientos legales,  
- inconsistencias en la estructura interna de los estados `h[x]`,  
- y un bug crítico que impedía mapear correctamente la política basada en ORIGEN hacia los hijos generados.  

También corregí la profundidad dinámica, la detección de repeticiones, la normalización de políticas y la generación del dataset.

A diferencia del proyecto de referencia, mi motor utiliza un **cerebro grande estilo AlphaZero**, implementado en **Keras + CUDA sobre una GPU RTX**, lo cual requiere mucho más tiempo de entrenamiento para mostrar mejoras reales. Por eso fue necesario usar un cerebro pequeño para validar el pipeline antes de volver al modelo grande.

Con todas estas correcciones aplicadas, repetiré el experimento durante los próximos dos días para verificar si el motor finalmente aprende como debería. Antes de estas reparaciones, el nivel de juego era tan bajo que incluso yo podía ganarle fácilmente, lo cual confirma que el problema estaba en la infraestructura y no en la arquitectura. Ahora que el pipeline está corregido, comenzaré una nueva corrida de autojuego para validar el aprendizaje real del sistema.

Worker,Resultado,Movimientos,Q,π,Retro,Inicio,Fin,Duración

w1,-1,Movs: 7-12 16x7 3x12 20-16 11-15 16x7 15x22 27x18 13x22 21-17 4x11 17-13 9x18 32-28 8-12 28-24 11-15 29-26 22x29 31-28 5-10 23-20 18-21 20x11 10-14 25x18 14x21 11-7 21-25 7-4 29-15 4-7 2-6 7x16 15-19 16-20 19x32 20x2 25-29 2-9 1-5 9x2 29-25 2-15 25-29 15-8 32-23 30-26 29x15 8x19x28,Q: -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000,π: 0.300 1.000 1.000 0.863 0.938 1.000 0.988 1.000 0.550 0.963 1.000 0.988 1.000 1.000 0.500 0.988 0.962 0.988 1.000 0.988 0.688 0.975 0.975 0.988 1.000 1.000 1.000 0.988 1.000 0.975 1.000 0.200 0.975 1.000 1.000 0.988 1.000 1.000 0.975 0.338 1.000 1.000 0.988 0.988 1.000 0.950 0.975 0.900 0.412 1.000,Retro: Q+=30371 Q-=27850 depth_max=40 depth_avg=11.1,Start: 2026-01-18T07:09:14.410968,End: 2026-01-18T07:11:13.317792,Duración: 0:01:58.906824

...

w1,-1,Movs: 13-17 31-28 17x26 30x21 11-14 19x10 5x14 21-17 7-12 16x7 4x11 17-13 9x18 29-26 14-19 23x14x7 3x12 27-22 18x27 28-24 12-15 20x11 27-31 26-22 31x18x7 32-28 7-21 25x18 8-12 18-14 1-5 14-11 12-16 28-23 16-20 24x15 2-6 11x2 5-10 23-19 10-14 19x10,Q: -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000,π: 0.387 0.638 1.000 0.625 0.788 1.000 1.000 0.988 0.888 1.000 0.950 0.975 1.000 0.588 0.975 1.000 1.000 0.975 1.000 0.850 0.613 1.000 0.938 0.963 0.500 0.762 0.988 1.000 0.438 0.925 0.950 0.963 0.812 0.988 0.425 0.663 0.387 1.000 0.750 0.625 0.950 1.000,Retro: Q+=29841 Q-=28342 depth_max=55 depth_avg=13.4,Start: 2026-01-19T14:32:58.368101,End: 2026-01-19T14:34:03.832981,Duración: 0:01:05.464880



