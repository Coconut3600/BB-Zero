## January 18, 2026 — Mini‑Brain Training Test

Before starting long‑term training with the full-size network, I created a small‑brain version of BB‑Zero to validate the entire training pipeline. A reference project in English checkers showed that a tiny network can learn quickly, so this experiment helps confirm whether my architecture, MCTS loop, and dataset generation are functioning correctly.

The plan is to run this reduced network for 2–3 days and monitor all logs and metrics. If it learns, the full-size network will be restored for long-term training. If not, I will inspect the code for structural issues.

---

## January 20, 2026 — Small‑Brain Results, Fixes, and Next Steps

After two days of testing, the reduced “small‑brain” network showed no learning. Comparing it with the reference project AlphaCheckers‑Zero by MadrasLe (https://github.com/MadrasLe/AlphaCheckers-Zero) helped reveal several structural issues in my pipeline. I also credit MadrasLe for two ideas that improved BB‑Zero significantly: the ORIGIN‑based policy mapping and the use of a legal‑moves mask, which my program did not originally include.

Unlike English checkers, Spanish checkers is far more complex (long capture chains, strict forced captures, multiple promotion squares, 20‑move and 12‑move draw rules, full repetition detection, ABABAB repetition, and a deeper legality system). This complexity requires more training data and a larger network.

To compare fairly, I temporarily reduced my network to match the reference project. This exposed several problems, including Q‑value propagation, priors assignment, legality masking, internal state structure, and policy mapping.  All of these issues have now been fixed.

## January 25, 2026 — Preparation for Full Training

Because Spanish checkers demands more capacity, I will return to the full‑size network and train it with more games than the reference project. Before starting full game training, I will run one final test: a king‑vs‑king endgame training session to verify stability and behavior.

A new folder, `technical_data/`, will store sample games, metrics, logs, technical notes, and images to document BB‑Zero’s evolution as the training process becomes fully validated.

## January 30, 2026 — Preparing BB‑Zero for the Impossible

Today marks a turning point. I ran two controlled endgame experiments to stress‑test the entire engine under real, slow, unforgiving conditions. Even though BB‑Zero runs in pure Python, on a single machine, without the raw speed of a C++ engine, the system held up beautifully. Parallelism, batched neural inference, and carefully optimized list‑based functions do their part. Slow… but solid.

Those two endgames were enough to prove that the entire pipeline is healthy: MCTS, the neural network, dataset generation, and training. Even with low simulation counts, BB‑Zero learned real tactical patterns. That gave me the confidence to design a training plan that can survive my hardware limitations.

The ORIGIN idea (inspired by MadrasLe) turned out to be a huge advantage. It gives structure and context to moves — something the network alone cannot infer in Spanish checkers. And with a 15 MB convolutional brain, BB‑Zero has the capacity to learn long‑range plans, complex endings, and its own style of play.

The final goal is ambitious: to face Profound, the absolute monster, the “Stockfish” of Spanish checkers. A handcrafted C++ engine with decades of tuning and raw speed. If BB‑Zero can compete — even a little — it will be a massive achievement. A true David vs. Goliath moment, built with one computer, homemade datasets, and stubborn scientific determination.

BB‑Zero is ready. Now begins the brutal training phase: months of discipline, consistency, and almost obsessive persistence. No shortcuts, no miracles. Just a slow python program, a 15 MB brain, and the will to challenge Profound, the giant of giants. From this moment on, the long battle begins… the training starts without stopping.

![Profound](images/profound.png)

## Training Plan (Feb–Jun 2026)

**February 2026**  
• 40 simulations per move  
• 200,000 self‑play games  
• Train every 10,000 games  
• Goal: build global intuition and basic pattern recognition

**March 2026**  
• 80 simulations per move  
• 100,000 self‑play games  
• Train every 5,000 games  
• Goal: refine defensive structures and stabilize play

**April 2026**  
• 800 simulations per move  
• 10,000 self‑play games  
• Train every 500 games  
• Goal: tactical precision, deeper calculation, stronger endings

**May 2026**  
• 1,600 simulations per move  
• 5,000 self‑play games  
• Train every 250 games  
• Goal: final polish, style consolidation, tournament readiness

**June 2026**  
• Final evaluation  
• Full match: **BB‑Zero vs. Profound**  
• Goal: measure the true strength of the engine after months of training


