## BB‑Zero — Project Overview

BB‑Zero is an AlphaZero‑style engine for Spanish checkers, using PUCT, Monte Carlo Tree Search, Dirichlet noise, temperature, and pure self‑play reinforcement learning with no heuristics. The first full prototype was completed on January 16, 2026, and after months of optimization, the engine is now complete and entering large‑scale training.

Originally written 100% in Python, BB‑Zero has evolved into a **hybrid Python + C++ bitboard architecture**, significantly increasing speed while remaining compatible with both Linux and Windows. At its core, it uses a custom **persistent tree structure (`tt3`)** that separates lightweight search statistics from heavy board states and recycles memory instead of wasting it. This saves a massive amount of **RAM and CPU**, allowing a standard gaming laptop to run hundreds of workers in parallel, each building its own persistent tree simultaneously. To be completely honest, when I first saw how little RAM and CPU it used, I briefly thought I had invented something brand new that outperformed Leela Zero's tree. After researching further, I realized that while my implementation is my own, I had independently arrived at something very similar to a classic 1970s memory layout called **Structure of Arrays (SoA)**, which achieves a very similar level of memory efficiency. BB‑Zero includes three integrated modes: Play Mode, Dataset Creation Mode, and Training Mode.

My goal is clear: **to challenge and eventually defeat Profound** — widely considered the "Stockfish" of Spanish checkers — documented on **Herson P. Guier’s Spanish Checkers Programs** page:  
https://damasclasicas.blogspot.com/

The project is estimated to be completed around **January 2027**.

---

## Current Status

During 2026, I refined and debugged the entire BB‑Zero training pipeline. A critical breakthrough was identifying and fixing an incomplete sign‑inversion bug during player‑perspective board transformations that had previously stalled learning. Immediately after this fix, a short test run of just **25,000 self‑play games** achieved a draw against an expert‑level engine—a result that had been impossible even after 80,000 games prior to the fix.

On November 1, 2026, I also expanded the network output to a unified **1024‑action policy space** with strict legal‑move masking across inference, MCTS, and training, removing legacy code from earlier versions.

Thanks to the speed and low RAM/CPU footprint of the new C++ bitboard core and the **`tt3` search architecture**, the engine now scales from 4–8 workers up to **512–1,024 simultaneous workers** on an RTX 4060 (16 GB RAM) while keeping memory low and stable. Because of this massive speedup, what previously required months can now be completed in **a couple of weeks**.

### Training Plan (Starting This Sunday)

Full‑scale training begins **this Sunday, November 22, 2026,** using a **200,000‑game sliding window** (automatically purging older games as new ones accumulate) and running **512 concurrent workers 24/7** to maintain optimal thermal stability:

1. **Experiment 1 — Small Network (~7 MB, *La Marioneta*):** Running non‑stop for **1 week** of pure self‑play to maximize game volume and validate scaling.
2. **Experiment 2 — Large Network (~30 MB, *La MarionetaG*):** Pre‑trained on a database of classical Spanish checkers games played by top engines and grandmasters—converted via my custom **`txt2npz`** tool (adapted from *verifikator*)—followed by **2 weeks** of uninterrupted self‑play.

Once training concludes, BB‑Zero will be tested in evaluation matches against expert engines (including *Matilde* from CheckerBoard) to determine if it is ready to face **Profound**.

---

## GUI Video

A short demonstration of the BB‑Zero GUI is available here: (Please note: the neural network shown here has not been trained correctly yet.)

https://www.youtube.com/watch?v=9LgB3CJ3WV4

---

## Release Plan

Once training is completed, the source code for the **BB‑Zero GUI** and the **C++ bitboard engine** will be released so anyone can compile and play it, with the trained small neural network (*La_Marioneta*, ~7 MB) included.

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
