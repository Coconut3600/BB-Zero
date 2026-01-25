## January 18, 2026 — Mini‑Brain Training Test

Before starting long‑term training with the full-size network, I created a small‑brain version of BB‑Zero to validate the entire training pipeline. A reference project in English checkers showed that a tiny network can learn quickly, so this experiment helps confirm whether my architecture, MCTS loop, and dataset generation are functioning correctly.

The plan is to run this reduced network for 2–3 days and monitor all logs and metrics. If it learns, the full-size network will be restored for long-term training. If not, I will inspect the code for structural issues.

---

## January 20, 2026 — Small‑Brain Results, Fixes, and Next Steps

After two days of testing, the reduced “small‑brain” network showed no learning. Comparing it with the reference project AlphaCheckers‑Zero by MadrasLe (https://github.com/MadrasLe/AlphaCheckers-Zero) helped reveal several structural issues in my pipeline. I also credit MadrasLe for two ideas that improved BB‑Zero significantly: the ORIGIN‑based policy mapping and the use of a legal‑moves mask, which my program did not originally include.

Unlike English checkers, Spanish checkers is far more complex (long capture chains, strict forced captures, multiple promotion squares, 20‑move and 12‑move draw rules, full repetition detection, ABABAB repetition, and a deeper legality system). This complexity requires more training data and a larger network.

To compare fairly, I temporarily reduced my network to match the reference project. This exposed several problems, including Q‑value propagation, priors assignment, legality masking, internal state structure, and policy mapping.  All of these issues have now been fixed.

## January 25, 2026 — Preparation for Full Training

Because Spanish checkers demands more capacity, I will return to the full‑size network and train it with more games than the reference project. Before starting full game training, I will run one final test: a damas‑vs‑damas endgame training session to verify stability and behavior.

A new folder, `technical_data/`, will store sample games, metrics, logs, technical notes, and images to document BB‑Zero’s evolution as the training process becomes fully validated.

