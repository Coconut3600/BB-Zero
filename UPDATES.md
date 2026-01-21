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
