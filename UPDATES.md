## January 18, 2026 — Mini‑Brain Training Test

Before starting long‑term training with the full-size network, I created a small‑brain version of BB‑Zero to validate the entire training pipeline. A reference project in English checkers showed that a tiny network can learn quickly, so this experiment helps confirm whether my architecture, MCTS loop, and dataset generation are functioning correctly.

The plan is to run this reduced network for 2–3 days and monitor all logs and metrics. If it learns, the full-size network will be restored for long-term training. If not, I will inspect the code for structural issues.

---

## January 20, 2026 — Small‑Brain Results and Critical Fixes

After two days of testing, the small‑brain network showed no learning. Comparing it with MadrasLe’s AlphaCheckers‑Zero (English checkers) helped reveal several deep issues in my pipeline. Spanish checkers is far more complex, and this exposed bugs that a simpler variant would hide.

Key fixes included:
- Q‑value propagation  
- Priors assignment inside MCTS nodes  
- Legal‑moves mask  
- Internal state structure (`h[x]`)  
- ORIGIN‑based policy mapping  
- Depth handling, repetition detection, policy normalization, and dataset generation  

With these corrections applied, I will repeat the experiment to confirm real learning. The previous lack of strength confirmed that the problem was in the infrastructure, not the architecture. Now the pipeline is repaired and ready for validation.
