## January 18, 2026 — Mini-Brain Training Test

Before starting long-term training with the full-size network, I decided to run one final experiment. I recently found a English-checkers project on GitHub that reached a surprisingly good level in only a few hours by training a very small neural network.

Since BB-Zero’s main network is much larger and will take a long time to learn, I created a small-brain version of my engine to test whether my training pipeline is correct. If a tiny network can learn to play well, then I know the architecture, MCTS loop, and training logic are working properly.

Starting tomorrow, I will run this mini-brain continuously for 2–3 days and monitor all logs and metrics to see if it actually learns. If it fails to learn, I will need to inspect the code for errors or missing logic. If it succeeds, I will restore the full-size network and begin long-term training until enough examples accumulate for real learning.

This experiment will help me confirm that BB-Zero is ready for the next phase.

## January 20, 2026 — Results of the Small‑Brain Experiment and Critical Fixes

After running the “small‑brain” experiment for two days, I confirmed that the reduced network was not learning anything at all. This was surprising, because a reference project — **AlphaCheckers‑Zero by MadrasLe** (https://github.com/MadrasLe/AlphaCheckers-Zero) — reaches amateur‑level play in just a few hours using a very small neural network. That contrast helped me identify several deep issues in my own training pipeline.

It is important to note that MadrasLe trains **English checkers**, a much simpler variant: basic forced captures, direct promotions, short capture chains, and minimal draw rules. In contrast, BB‑Zero implements **full Spanish draughts**, which is significantly more complex, including:
- long multi‑capture chains,
- strict forced‑capture rules,
- promotion rules with multiple landing squares,
- 20‑move and 12‑move draw rules,
- full position repetition detection,
- ABABAB repetition,
- and a much more detailed legality system.

MadrasLe simplified many rules to speed up learning; I did the opposite and implemented the complete official rule set.

To make a fair comparison, I temporarily reduced my network to the **same size as his**. This revealed several problems in my pipeline:
- incorrect propagation of Q‑values,
- misassigned priors inside MCTS nodes,
- errors in the legal‑moves mask,
- inconsistencies in the internal `h[x]` state structure,
- and a critical bug preventing the ORIGIN‑based policy from being mapped correctly to the generated children.

I also fixed dynamic depth handling, repetition detection, policy normalization, and dataset generation.

Unlike the reference project, my engine normally uses a **large AlphaZero‑style network**, implemented in **Keras + CUDA on an RTX GPU**, which naturally requires much more training time to show improvement. That is why the small‑brain test was essential to validate the pipeline before returning to the full model.

With all these corrections applied, I will repeat the experiment over the next two days to verify whether the engine finally learns as expected. Before these fixes, the playing strength was so low that I could beat it easily, which confirmed that the issue was in the infrastructure, not the architecture. Now that the pipeline is repaired, I will begin a new self‑play run to validate real learning.

Samples

Worker,Result,Moves,Q,π,Backprop,Start,End,Duration

w1,-1,Movs: 7-12 16x7 3x12 20-16 11-15 16x7 15x22 27x18 13x22 21-17 4x11 17-13 9x18 32-28 8-12 28-24 11-15 29-26 22x29 31-28 5-10 23-20 18-21 20x11 10-14 25x18 14x21 11-7 21-25 7-4 29-15 4-7 2-6 7x16 15-19 16-20 19x32 20x2 25-29 2-9 1-5 9x2 29-25 2-15 25-29 15-8 32-23 30-26 29x15 8x19x28,Q: -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000,π: 0.300 1.000 1.000 0.863 0.938 1.000 0.988 1.000 0.550 0.963 1.000 0.988 1.000 1.000 0.500 0.988 0.962 0.988 1.000 0.988 0.688 0.975 0.975 0.988 1.000 1.000 1.000 0.988 1.000 0.975 1.000 0.200 0.975 1.000 1.000 0.988 1.000 1.000 0.975 0.338 1.000 1.000 0.988 0.988 1.000 0.950 0.975 0.900 0.412 1.000,Retro: Q+=30371 Q-=27850 depth_max=40 depth_avg=11.1,Start: 2026-01-18T07:09:14.410968,End: 2026-01-18T07:11:13.317792,Duración: 0:01:58.906824

...

w1,-1,Movs: 13-17 31-28 17x26 30x21 11-14 19x10 5x14 21-17 7-12 16x7 4x11 17-13 9x18 29-26 14-19 23x14x7 3x12 27-22 18x27 28-24 12-15 20x11 27-31 26-22 31x18x7 32-28 7-21 25x18 8-12 18-14 1-5 14-11 12-16 28-23 16-20 24x15 2-6 11x2 5-10 23-19 10-14 19x10,Q: -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000 -1.000 1.000,π: 0.387 0.638 1.000 0.625 0.788 1.000 1.000 0.988 0.888 1.000 0.950 0.975 1.000 0.588 0.975 1.000 1.000 0.975 1.000 0.850 0.613 1.000 0.938 0.963 0.500 0.762 0.988 1.000 0.438 0.925 0.950 0.963 0.812 0.988 0.425 0.663 0.387 1.000 0.750 0.625 0.950 1.000,Retro: Q+=29841 Q-=28342 depth_max=55 depth_avg=13.4,Start: 2026-01-19T14:32:58.368101,End: 2026-01-19T14:34:03.832981,Duración: 0:01:05.464880


