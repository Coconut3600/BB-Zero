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
