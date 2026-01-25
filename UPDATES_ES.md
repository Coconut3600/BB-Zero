## 18 de enero de 2026 — Prueba de Entrenamiento con Mini‑Cerebro

Antes de comenzar el entrenamiento a largo plazo con la red de tamaño completo, creé una versión de “mini‑cerebro” de BB‑Zero para validar todo el sistema de entrenamiento. Un proyecto de referencia en damas inglesas mostró que una red muy pequeña puede aprender rápidamente, así que este experimento ayuda a confirmar si mi arquitectura, el bucle MCTS y la generación del dataset están funcionando correctamente.

El plan es ejecutar esta red reducida durante 2–3 días y monitorear todos los registros y métricas. Si aprende, restauraré la red de tamaño completo para el entrenamiento a largo plazo. Si no aprende, inspeccionaré el código en busca de problemas estructurales.

---

## 20 de enero de 2026 — Resultados del Mini‑Cerebro, Arreglos y Próximos Pasos

Después de dos días de pruebas, la red reducida (“small‑brain”) no mostró aprendizaje.  
Compararla con el proyecto de referencia AlphaCheckers‑Zero de MadrasLe  
(https://github.com/MadrasLe/AlphaCheckers-Zero) ayudó a revelar varios problemas estructurales en mi programa.  
También doy crédito a MadrasLe por dos ideas que mejoraron significativamente BB‑Zero:  
el mapeo de política basado en ORIGIN y el uso de una mapa de movimientos legales, que mi programa no incluía originalmente.

A diferencia de las damas inglesas, las damas españolas son mucho más complejas (cadenas largas de captura, capturas obligatorias estrictas, múltiples casillas de coronación, reglas de tablas de 20 y 12 movimientos, detección completa de repeticiones, repetición ABABAB y un sistema de legalidad mucho más profundo).  
Esta complejidad requiere más datos de entrenamiento y una red más grande.

Para comparar de manera justa, reduje temporalmente mi red al tamaño del proyecto de referencia.  
Esto expuso varios problemas, incluyendo propagación de Q‑values, asignación de priors, mapa de movimientos legales, estructura interna del estado h[x] y el mapeo de política ORIGIN.  
Todos estos problemas ya han sido corregidos.

Debido a que las damas españolas requieren mayor capacidad, regresaré a la red de tamaño completo y la entrenaré con más partidas que el proyecto de referencia.  
Antes de comenzar el entrenamiento de partidas completas, ejecutaré una última prueba: una sesión de entrenamiento de final de damas‑vs‑damas para verificar estabilidad y comportamiento.

Un nuevo folder, `technical_data/`, almacenará partidas de ejemplo, métricas, registros, notas técnicas e imágenes para documentar la evolución de BB‑Zero conforme la tubería de entrenamiento quede completamente validada.
