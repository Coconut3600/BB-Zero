## January 18, 2026 — Mini‑Brain Training Test

Before starting long‑term training with the full-size network, I created a small‑brain version of BB‑Zero to validate the entire training pipeline. A reference project in English checkers showed that a tiny network can learn quickly, so this experiment helps confirm whether my architecture, MCTS loop, and dataset generation are functioning correctly.

The plan is to run this reduced network for 2–3 days and monitor all logs and metrics. If it learns, the full-size network will be restored for long-term training. If not, I will inspect the code for structural issues.

---

## January 20, 2026 — Small‑Brain Results, Fixes, and Next Steps

After two days of testing, the reduced “small‑brain” network showed no learning.  
Comparing it with the reference project AlphaCheckers‑Zero by MadrasLe  
(https://github.com/MadrasLe/AlphaCheckers-Zero) helped reveal several issues in my pipeline.

It is important to note that MadrasLe trains English checkers, a much simpler variant.  
BB‑Zero implements full Spanish checkers, which includes long multi‑capture chains, strict forced‑capture rules, multiple promotion squares, 20‑move and 12‑move draw rules, full repetition detection, ABABAB repetition, and a much more complex legality system.  
This additional complexity requires more training data and a larger network.

To make a fair comparison, I temporarily reduced my network to match the size of the reference project.  
This exposed several problems in my pipeline, including:

- Q‑value propagation  
- Priors assignment inside MCTS nodes  
- Legal‑moves mask  
- Internal state structure (h[x])  
- ORIGIN‑based policy mapping  
- Depth handling, repetition detection, policy normalization, and dataset generation  

All of these issues have now been fixed.

Because Spanish checkers is significantly more complex, I will return to the **full‑size network** and train it with **more games than the reference project**.  
Before starting full game training, I will run one final test: a **damas‑vs‑damas endgame training session** to verify stability, behavior, and learning patterns.

A new folder, `technical_data/`, will store detailed information such as:
- sample games  
- metrics  
- logs  
- technical notes  
- images and analysis  

This will help document BB‑Zero’s evolution as the training pipeline becomes fully validated.

