## January 18, 2026 — Mini-Brain Training Test

Before starting long-term training with the full-size network, I decided to run one final experiment. I recently found a Spanish-checkers project on GitHub that reached a surprisingly good level in only a few hours by training a very small neural network.

Since BB-Zero’s main network is much larger and will take a long time to learn, I created a small-brain version of my engine to test whether my training pipeline is correct. If a tiny network can learn to play well, then I know the architecture, MCTS loop, and training logic are working properly.

Starting tomorrow, I will run this mini-brain continuously for 2–3 days and monitor all logs and metrics to see if it actually learns. If it fails to learn, I will need to inspect the code for errors or missing logic. If it succeeds, I will restore the full-size network and begin long-term training until enough examples accumulate for real learning.

This experiment will help me confirm that BB-Zero is ready for the next phase.
