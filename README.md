## BB‑Zero — Project Overview

BB‑Zero is an AlphaZero‑style engine for Spanish checkers, using PUCT, Monte Carlo Tree Search, Dirichlet noise, temperature, and pure self‑play reinforcement learning with no heuristics. The first full version of the program was completed on January 16, 2026. The next phase now begins: generating all training datasets from scratch and documenting the entire process as the project evolves.

The engine is written 100% in Python as a single .py file and is compatible with both Linux and Windows. BB‑Zero includes three integrated modes: Play Mode, Dataset Creation Mode, and Training Mode.

My long‑term goal is clear: **to challenge and eventually defeat Profound**, one of the strongest Spanish checkers engines documented on **Herson P. Guier’s Spanish Checkers Programs** page:  
https://damasclasicas.blogspot.com/

The project is estimated to be completed around **January 2027**.

---

## Current Status

During early 2026, I continued refining and validating the full BB‑Zero training pipeline. In June, I resolved two silent but critical issues affecting self‑play quality: a faulty shuffle operation that misaligned training examples, and legacy N/W/Q statistics still being read from an older engine instead of the new structure. Both issues were fully fixed on June 18.

With these corrections in place, BB‑Zero now produces clean self‑play data, consistent policy targets, and stable training behavior. Training will continue from the current point (approximately 30,000 self‑play games), now using a 50,000‑game sliding window and 800 simulations per move. Due to limited computational resources and the engine’s current slow learning rate, this long‑term schedule will run for roughly six months — until January 2027 — to accumulate the volume of games required for meaningful improvement.

In parallel, I have developed a structure similar to AlphaZero’s persistent tree but significantly faster and more memory‑efficient, and it is now fully integrated into the engine.

Once the new network reaches sufficient strength, I will run evaluation matches against Matilde from Checkersboard to measure progress.

---

## GUI Video

A short demonstration of the BB‑Zero GUI is available here: (Please note: the neural network shown here has not been trained correctly yet.)

https://www.youtube.com/watch?v=9LgB3CJ3WV4

---

## Release Plan

Once training is completed, BB‑Zero will be released as a Windows executable (~180 MB) together with its neural network *La_Marioneta* (~15 MB), allowing anyone to play with it.

---

## Acknowledgments

Special thanks to **Herson P. Guier**, my consultant and rule expert, whose deep knowledge of Spanish checkers has been essential to this project.

**Author:** Alberto Cervantes  
**Keywords:** Spanish checkers, Spanish draughts, classical draughts, Spanish draughts engine, AlphaZero, AI, Monte Carlo, reinforcement learning, PUCT, neural networks.

---

## GUI Preview

Below is a screenshot of the current GUI: (Please note: the neural network shown here has not been trained correctly yet.)

### Gameplay Mode
![Gameplay Mode](images/gameplay_en2.png)
