## 18 de enero – 12 de febrero de 2026 — Resumen

Entre el 18 de enero y el 12 de febrero validé todo el pipeline de entrenamiento de BB‑Zero utilizando una versión reducida del modelo (“mini‑brain”). Esta prueba reveló varios problemas estructurales que fueron corregidos comparando con [**AlphaCheckers‑Zero by MadrasLe**](https://github.com/MadrasLe/AlphaCheckers-Zero). Una vez corregido el pipeline, regresé al modelo completo, ya que las damas españolas requieren mayor complejidad.

Las pruebas de finales confirmaron que MCTS, la generación de datos y el entrenamiento neuronal funcionan correctamente. Las ideas de **ORIGIN** y **legal‑moves mask**, tomadas de MadrasLe, siguen siendo componentes esenciales.

Aunque soy un jugador muy débil, BB‑Zero ya me derrota de forma consistente (imagen abajo). Sin embargo, todavía no puede vencer a **Matilde**, un motor de fuerza media documentado en [**Programas de Damas Clásicas by Herson P. Guier**](https://damasclasicas.blogspot.com/), que seguirá siendo la referencia principal.

![BB-Zero vs me](https://github.com/Coconut3600/BB-Zero/blob/main/images/bb_zero_vs_me.jpg?raw=true)

### Ciclo 4 — Prueba de alta simulación contra Matilde
En el Ciclo 4 probé BB‑Zero con **más de 300 simulaciones por movimiento** contra Matilde. El motor alcanzó un **final teóricamente de tablas**, pero terminó perdiendo por falta de técnica con la dama. Esto confirmó que la red no estaba dañada; simplemente aún no comprende los finales.

**Partida (Matilde vs BB‑Zero):** 1.10-13, 21-17; 2.13-18, 22x13; 3.09x18, 26-21; 4.12-15, 21x14; 5.11x18, 29-26; 6.05-10, 23-20; 7.07-11, 28-23; 8.10-14, 17-13; 9.01-05, 13-09; 10.05-10, 27-22; 11.18x27, 31x22; 12.10-13, 26-21; 13.03-07, 21-17; 14.06-10, 09-05; 15.02x09, 20-16; 16.08-12, 25-21; 17.13-18, 22x13x06; 18.14-19, 23x14; 19.11x18x25, 06-02; 20.15-19, 30-27; 21.25-29, 02-05; 22.12-15, 05x23; 23.09-13, 17x10; 24.15-19, 23x14; 25.07-12, 16x07; 26.04x11x18, 10-05; 27.18-21, 27-23; 28.29-12, 23-19; 29.12x22, 05-01; 30.21-26, 01-05; 31.26-30, 05-09; 32.22-08 (Nota: 32.22-08, 09-18 pierde; la jugada correcta era 9-31.)


### Avances adicionales
Durante este periodo implementé **simetrías horizontales** directamente en Keras/TensorFlow, duplicando el volumen efectivo de entrenamiento sin costo adicional. Este avance reemplazó intentos previos de crear datasets de finales, los cuales resultaron inestables.

También preparé un video corto mostrando la interfaz gráfica de BB‑Zero: https://www.youtube.com/watch?v=9LgB3CJ3WV4

### Plan a largo plazo
A partir de aquí, BB‑Zero seguirá un plan estable:
- 40 simulaciones por movimiento  
- Entrenamiento cada 10,000 partidas de autoplays  
- Simetría horizontal activada  
- ORIGIN + máscara de legalidad  

El objetivo final se mantiene: desafiar a **Profound**, el motor más fuerte de damas españolas.

![Profound](https://github.com/Coconut3600/BB-Zero/blob/main/images/Profound.png?raw=true)
**Imagen extraída del blog "Damas Clásicas" de Herson P. Guier** 


A medida que BB‑Zero continúe mejorando, publicaré una partida completa de BB‑Zero vs. Matilde para documentar su progreso, junto con un video para los aficionados a las damas clásicas. Después de que el motor logre finalmente vencer a Matilde, también estará disponible para jugar partidas en vivo en PlayOK, de modo que la comunidad pueda enfrentarse directamente a él.

