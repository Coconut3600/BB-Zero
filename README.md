## BB‑Zero — Project Overview

BB‑Zero is an AlphaZero‑style engine for Spanish checkers, using PUCT, Monte Carlo Tree Search, Dirichlet noise, temperature, and pure self‑play reinforcement learning with no heuristics. The first full version of the program was completed on January 16, 2026. The next phase now begins: generating all training datasets from scratch and documenting the entire process as the project evolves.

The engine is written 100% in Python as a single .py file and is compatible with both Linux and Windows. BB‑Zero includes three integrated modes: Play Mode, Dataset Creation Mode, and Training Mode.

My long‑term goal is clear: **to challenge and eventually defeat Profound**, one of the strongest Spanish checkers engines documented on **Herson P. Guier’s Spanish Checkers Programs** page:  
https://damasclasicas.blogspot.com/

The project is estimated to be completed around **June 2026**.

---

## Current Status

During the early months of 2026, I continued refining and validating the full BB‑Zero training pipeline. In June, I identified and corrected two critical issues that had silently affected the quality of self‑play data: a faulty shuffle operation that misaligned training examples, and a legacy set of statistics (N/W/Q) that were still being read from an older engine instead of the new structure. Both issues were fully resolved on June 18.

With these fixes in place, BB‑Zero now produces clean self‑play data, consistent policy targets, and stable training behavior. I will restart training from scratch this Saturday, using a 20,000‑game sliding window, 600 simulations per move, and a continuous schedule where every 180 new games replace the oldest 180. This setup will be used throughout the remainder of June to rebuild a healthy dataset and allow the network to converge properly.

In parallel, I have developed a structure similar to AlphaZero’s persistent tree, but significantly faster and more memory‑efficient. This design is now fully integrated into the engine.

By the end of June, once the new network has gained strength, I will run a series of evaluation matches against Matilde from Checkersboard to measure progress.


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
