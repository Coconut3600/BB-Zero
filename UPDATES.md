## January 18, 2026 — Mini‑Brain Training Test

Before starting long‑term training with the full-size network, I created a mini‑brain version of BB‑Zero to validate the entire training pipeline. A reference project in English checkers showed that a tiny network can learn quickly, so this experiment helps confirm whether my architecture, MCTS loop, and dataset generation are functioning correctly.

The plan is to run this reduced network for 2–3 days and monitor all logs and metrics. If it learns, the full-size network will be restored for long-term training. If not, I will inspect the code for structural issues.

---

## January 20, 2026 — Mini‑Brain Results, Fixes, and Next Steps

After two days of testing, the reduced “mini‑brain” network showed no learning. Comparing it with the reference project AlphaCheckers‑Zero by MadrasLe (https://github.com/MadrasLe/AlphaCheckers-Zero) helped reveal several structural issues in my pipeline. I also credit MadrasLe for two ideas that improved BB‑Zero significantly: the ORIGIN‑based policy mapping and the use of a legal‑moves mask, which my program did not originally include.

Unlike English checkers, Spanish checkers is far more complex (long capture chains, strict forced captures, multiple promotion squares, draw rules, full repetition detection, and a deeper legality system). This complexity requires more training data and a larger network.

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

![Profound](https://github.com/Coconut3600/BB-Zero/blob/main/images/Profound.png?raw=true)


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

## February 5, 2026 — Training

BB‑Zero has now reached its fourth training cycle. I haven’t tested games against the brains from cycle 2 or cycle 3 yet, but I did play several games against the brain produced in cycle 1.

In the first test that brain beat me, although I was tired and didn’t play well. The next day I tried again, this time with 80 simulations, and managed to get a draw, but it was difficult. Today I faced the same cycle‑1 brain again, also at 80 simulations, trying to play as well as I could… and it beat me again. I’m sharing the photo and the full game below.

![BB-Zero vs me](https://github.com/Coconut3600/BB-Zero/blob/main/images/bb_zero_vs_me.jpg?raw=true)

I also talked with my consultant Herson, and we might soon play a game on the PlayOK platform to offer some friendly matches with BB‑Zero for fans of the game. His page is an excellent resource on Spanish Checkers: it documents the best programs, computer‑vs‑computer matches, and games against grandmasters: https://damasclasicas.blogspot.com/

**Game played (0–1):**  
1.11-15, 21-18; 2.15-19, 22x15; 3.12x19, 23x14; 4.10x19, 27-23; 5.06-10, 23x14; 6.10x19, 31-27; 7.05-10, 27-23; 8.02-05, 23x14; 9.10x19, 25-21; 10.05-10, 28-23; 11.19x28, 32x23; 12.07-11, 23-19; 13.08-12, 26-22; 14.12-16, 21-17; 15.04-08, 30-27; 16.08-12, 29-26; 17.11-15, 27-23; 18.16-20, 23x16x07; 19.03x12, 26-21; 20.12-16, 19x12; 21.01-05, 22-19; 22.09-13, 18x09x02; 23.10-13, 17x10; 24.16-20, 24x15; 0–1



## February 8, 2026 — Cycle 4: crisis, learning, and new direction

I’m not an AI engineer; I’m learning as I go. I’m also not a strong Spanish checkers player, which is why I use *Matilde* (a medium/expert engine) as my reference. In this cycle BB‑Zero started giving away pieces, almost like it was getting frustrated when it couldn’t beat me. I thought I had damaged the neural network with overtraining.

To verify, I increased simulations to 300 and tested BB‑Zero against Matilde. Surprisingly, it reached a drawn endgame, but eventually lost because it doesn’t know how to maintain the king in technical endings. This confirmed the real issue: the brain isn’t broken — **it simply doesn’t understand endgames**.

Without endgame patterns, the engine:
- mis-evaluates positions  
- falls into traps  
- fails to convert winning positions  
- and would need millions of self‑play games to learn these concepts naturally

So I’m pausing general training and creating a **curriculum of endgames** — small “vitamins” for the artificial brain. I’ll train key endings (king handling, draw techniques, traps, races) with symmetry and color inversion. After generating these datasets, I’ll mix them with normal self‑play and resume long‑term training for several months.


### Game -

1.10-13, 21-17; 2.13-18, 22x13; 3.09x18, 26-21; 4.12-15, 21x14;
5.11x18, 29-26; 6.05-10, 23-20; 7.07-11, 28-23; 8.10-14, 17-13;
9.01-05, 13-09; 10.05-10, 27-22; 11.18x27, 31x22; 12.10-13, 26-21;
13.03-07, 21-17; 14.06-10, 09-05; 15.02x09, 20-16; 16.08-12, 25-21;
17.13-18, 22x13x06; 18.14-19, 23x14; 19.11x18x25, 06-02; 20.15-19, 30-27;
21.25-29, 02-05; 22.12-15, 05x23; 23.09-13, 17x10; 24.15-19, 23x14;
25.07-12, 16x07; 26.04x11x18, 10-05; 27.18-21, 27-23; 28.29-12, 23-19;
29.12x22, 05-01; 30.21-26, 01-05; 31.26-30, 05-09; 32.22-08

### Matilde vs BB-Zero (Black)

![bbzero_matilde](https://github.com/Coconut3600/BB-Zero/blob/main/images/bbzero_matilde.png)

Note: 32.22-08, 09-18 loses.  It should be 9-31.



## February 12, 2026 — New Training Direction & Horizontal Mirror Symmetries

After experimenting with endgame datasets, I realized that curriculum learning was destabilizing the brain. Forcing endings or adding artificial examples created rigidity and inconsistent behavior, while the last 40,000 self‑play games showed that BB‑Zero learns much better through stability, discipline, and natural intuition. Some endgames are already being handled correctly without ever being taught, which confirms that the brain is learning on its own. Because of this, I am stopping the creation of endgame datasets for now. Even though I lost almost a week that could have been used to generate more data, implementing the horizontal mirror (symmetries) is a major breakthrough that more than compensates for that time. The mirror is applied directly in Keras/TensorFlow, takes no extra time, and instantly duplicates the effective training volume.

From today forward, training will continue with a simple and stable plan: fixed 40 simulations per move, cycles of 10,000 self‑play games, the horizontal mirror fully enabled, and the origin+mask architecture to keep the action space clean. This will be a long‑term experiment over the next four months to see whether consistency, patience, and intuition can shape BB‑Zero into an expert‑level Spanish Checkers engine capable of drawing and eventually defeating strong programs.

I also finished a small video showcasing the BB‑Zero GUI, and I’m sharing it here to document the project’s progress: https://www.youtube.com/watch?v=9LgB3CJ3WV4



## February 18, 2026 — Cycle 7: stability, symmetries, and the beginning of real learning

After an intense week of continuous training, BB‑Zero has completed its seventh cycle, reaching 70,000 self‑play games at 40 simulations per move. This cycle marks an important moment in the project: for the first time, the metrics show a clear and consistent improvement, a sign that the brain is beginning to learn real patterns of play.

### The impact of the horizontal mirror

In Cycle 5 I fully enabled the horizontal mirror, a symmetry applied directly in Keras/TensorFlow that duplicates every training position at zero additional cost.  
This means:

• Even though each cycle generates 10,000 real games  
• The training pipeline receives the equivalent of 20,000 positions thanks to the mirror  

Cycle 5 introduced noise — completely expected — because the network had to reorganize itself to integrate the new symmetry.  
But now, in Cycles 6 and 7, that noise has transformed into stability and better generalization.

### Cycle 7: the best cycle so far

Cycle 7 shows the first solid signs of real learning:

• total_loss dropped to 1.6887  
• policy_loss dropped to 1.5088  
• value_loss dropped to 0.1844  
• ratio increased to 8.18 (greater internal stability)

These improvements indicate:

• A more coherent policy  
• A more stable and accurate value head  
• Less internal noise  
• A better understanding of who is winning or losing in typical positions  

Without a doubt, this is the strongest cycle in the project so far.

### Important correction: measuring progress against Matilde, not against myself

In a previous update I mentioned that BB‑Zero had beaten me in a game.  
That was a misinterpretation: I am a very weak Spanish Checkers player, so using myself as a reference has no scientific value.

From now on, the only valid benchmark will be matches against **Matilde**, the medium‑strength engine included in Checkersboard.  
Matilde is stable, consistent, and perfect for measuring real progress.

### New evaluation protocol

Starting this Friday, I will begin a weekly ritual:

**Every Friday: a 3‑round match (switching colors) against Matilde.**

I will publish:

• The full games  
• Comments  
• Typical mistakes  
• Signs of improvement or regression  

The goal is to observe whether BB‑Zero continues to get crushed or if it begins to show resistance.

### Continuous training plan

Training will continue with the same discipline:

• 40 simulations per move  
• Training every 10,000 games  
• Horizontal mirror enabled  
• Origin encoding + legal mask to keep the action space clean  

When BB‑Zero manages to:

• Consistently draw full games against Matilde  
• Or achieve its first real victory  

Then I will increase training to **60 simulations per move**.

### A baby taking its first steps

I got excited when BB‑Zero beat me and when it almost drew against Matilde.  
But the truth is that it is still a baby: it makes serious mistakes, loses simple endings, and still doesn’t understand how to handle a king properly.

Even so, Cycle 7 shows that:

• Consistency  
• Discipline  
• Stability  
• And patience  

are enough for a small engine, written in Python and trained on a single computer, to begin learning for real.

The final goal remains unchanged: to challenge **Profound**, the absolute giant of Spanish Checkers.

There is still a long road ahead, but for the first time, the path looks clear.

This Friday we will publish a 3‑round match (switching colors) against Matilde to see whether BB‑Zero continues to take a beating.




