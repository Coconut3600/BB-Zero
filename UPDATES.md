## January 18 – February 12, 2026 — Summary

Between January 18 and February 12, I validated the full BB‑Zero training pipeline using a reduced “mini‑brain” network. This test revealed several structural issues, which were corrected by comparing with [**AlphaCheckers‑Zero by MadrasLe**](https://github.com/MadrasLe/AlphaCheckers-Zero). After fixing the pipeline, I returned to the full‑size network, since Spanish checkers requires higher complexity.

Controlled endgame experiments confirmed that MCTS, dataset generation, and neural training are functioning correctly.The **ORIGIN-based policy mapping** and **legal‑moves mask**—ideas credited to MadrasLe—remain essential.

Although I am a very weak Spanish checkers player, BB‑Zero already defeats me consistently (image below). However, it still cannot beat **Matilde**, a stable medium‑strength engine documented on  [**Spanish Checkers Programs by Herson P. Guier**](https://damasclasicas.blogspot.com/), which will remain the primary benchmark.

![BB-Zero vs me](https://github.com/Coconut3600/BB-Zero/blob/main/images/bb_zero_vs_me.jpg?raw=true)

### Cycle 4 — High‑simulation test vs Matilde
During Cycle 4, I tested BB‑Zero at **300+ simulations per move** against Matilde. The engine reached a **drawn endgame**, but eventually lost due to weak king‑handling and limited endgame knowledge. This confirmed that the network was not damaged; it simply lacks endgame understanding at this stage.

**Game (Matilde vs BB‑Zero):**  
1.10-13, 21-17; 2.13-18, 22x13; 3.09x18, 26-21; 4.12-15, 21x14; 5.11x18, 29-26; 6.05-10, 23-20; 7.07-11, 28-23; 8.10-14, 17-13; 9.01-05, 13-09; 10.05-10, 27-22; 11.18x27, 31x22; 12.10-13, 26-21; 13.03-07, 21-17; 14.06-10, 09-05; 15.02x09, 20-16; 16.08-12, 25-21; 17.13-18, 22x13x06; 18.14-19, 23x14; 19.11x18x25, 06-02; 20.15-19, 30-27; 21.25-29, 02-05; 22.12-15, 05x23; 23.09-13, 17x10; 24.15-19, 23x14; 25.07-12, 16x07; 26.04x11x18, 10-05; 27.18-21, 27-23; 28.29-12, 23-19; 29.12x22, 05-01; 30.21-26, 01-05; 31.26-30, 05-09; 32.22-08 (Note: 32.22-08, 09-18 loses; correct move was 9-31.)
25

### Additional progress
During this period I also implemented **horizontal mirror symmetries** directly in Keras/TensorFlow, doubling the effective training volume at zero cost.This improvement replaced earlier attempts at curriculum endgame datasets, which proved destabilizing.

I also completed a short video demonstrating the BB‑Zero GUI:  

https://www.youtube.com/watch?v=9LgB3CJ3WV4

### Long‑term plan
From this point forward, BB‑Zero will follow a stable long‑term plan:
- 40 simulations per move  
- Training every 10,000 self‑play games  
- Horizontal mirror fully enabled  
- Origin encoding + legal mask  

The long‑term objective remains unchanged: to eventually challenge **Profound**, the strongest Spanish Checkers engine.

![Profound](https://github.com/Coconut3600/BB-Zero/blob/main/images/Profound.png?raw=true)

```text
Imagen extraída del blog "Damas Clásicas" de Herson P. Guier (https://damasclasicas.blogspot.com).


As BB‑Zero continues to improve, I will publish a full BB‑Zero vs. Matilde game to document its progress, along with a video for Spanish Checkers enthusiasts. After the engine eventually manages to defeat Matilde, I will also make it available for live games on PlayOK so fans of the game can play against it directly.





