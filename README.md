BB‑Zero is an AlphaZero‑style neural network for Spanish checkers, using PUCT, Monte Carlo Tree Search, Dirichlet noise, temperature, and pure self‑play reinforcement learning with no heuristics.
The first version of the program was completed on January 16, 2026, and the next phase now begins: building all training datasets from scratch. I will document this entire process in this blog as the project evolves.
In the future, once BB‑Zero becomes more stable and mature, I plan to release the full source code so others can study it, reproduce it, or build upon it.

The engine is written 100% in Python as a single .py program with no external modules or sub‑packages. It runs on both Linux and Windows, and it is fully bilingual (Spanish and English).
BB‑Zero includes three integrated modes:

Play Mode

Dataset Creation Mode

Training Mode

Special thanks to Herson P. Guier, my consultant and rule expert, whose deep knowledge of Spanish checkers has been essential to this project.

**Alberto Cervantes**  
Creator of BB‑Zero, an experimental AlphaZero‑style engine for Spanish checkers.

**Herson P. Guier (Costa Rica)**  
Analyst & Technical Advisor

## GUI Preview

Below is an screenshots of the current GUI:

### Gameplay Mode
![Gameplay Mode](Screenshot%202026-01-16%20235855.png)




