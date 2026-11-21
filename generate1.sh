#!/usr/bin/env bash
# ================================================================
# GENERATE12.SH — HYBRID C++ / GPU TRAINING PIPELINE (BB-ZERO v12)
# ================================================================
# PIPELINE COMPONENTS:
#   - selfplay12.cpp / libselfplay12.so  -> C++ parallel self-play engine (up to 2,048 workers)
#   - run_selfplay12.py                  -> Python/GPU bridge feeding batch inference to C++
#   - brain12.py                         -> Unified neural network (SMALL & LARGE) + training (-4)
#   - antorcha.cpp / antorcha.so         -> C++ bitboard legal move generator
#   - /mnt/c/bb/la_marioneta.pth         -> SMALL BRAIN weights (6x128  ~7.6 MB)
#   - /mnt/c/bb/la_marionetaG.pth        -> LARGE BRAIN weights (10x192 ~27.5 MB)
#   - ~/bb/datasets/*.npz                -> Generated self-play games (stored in WSL for fast I/O)
#
# SETUP ENVIRONMENT IN WSL:
#   source <your_venv>/bin/activate && cd /mnt/c/python
#   chmod +x generate12.sh
#
# USAGE (PARAMETERS):
#   ./generate12.sh [WORKERS] [SIMS] [GAMES_PER_WORKER] [MODE]
#   1) WORKERS          : Parallel C++ workers              (default: 512, max: 2048)
#   2) SIMS             : MCTS simulations per move         (default: 800)
#   3) GAMES_PER_WORKER : Games per worker in each cycle    (default: 1)
#   4) MODE             : C / CHICO / SMALL (default) or G / GRANDE / LARGE
#
# QUICK EXAMPLES:
#   ./generate12.sh                     -> 512 workers, 800 sims, 1 game, SMALL BRAIN
#   ./generate12.sh 1024                -> 1024 workers, 800 sims, 1 game, SMALL BRAIN
#   ./generate12.sh 512 800 1 G         -> 512 workers, 800 sims, 1 game, LARGE BRAIN
#   ./generate12.sh 1024 800 1 LARGE    -> 1024 workers, 800 sims, 1 game, LARGE BRAIN
#   kill -9 %1                          -> Terminate background process
#
# DATASET MANAGEMENT (.npz) IN WSL (~/bb/datasets):
#   - Count .npz files:                  ls ~/bb/datasets/*.npz | wc -l
#   - Inspect latest 10 files & sizes:   ls -lh ~/bb/datasets/*.npz | tail -n 10
#   - Check total disk usage:            du -sh ~/bb/datasets
#   - DELETE ALL (fresh experiment):     rm -f ~/bb/datasets/*.npz
#   - BACKUP instead of deleting:        mkdir -p ~/bb/datasets_backup && mv ~/bb/datasets/*.npz ~/bb/datasets_backup/
#
# RECOMPILE C++ ENGINES IN WSL (if .cpp files are modified):
#   g++ -O3 -march=native -shared -fPIC -o antorcha.so antorcha.cpp
#   g++ -O3 -march=native -std=c++20 -shared -fPIC -pthread -o libselfplay12.so selfplay12.cpp
# ================================================================

set -euo pipefail

PROJECT_DIR="/mnt/c/python"
cd "$PROJECT_DIR"

# CLI arguments (with defaults)
WORKERS=${1:-512}
SIMS=${2:-800}
GAMES_PER_WORKER=${3:-1}
MODE_RAW=${4:-CHICO}
MODE_UPPER=$(echo "$MODE_RAW" | tr '[:lower:]' '[:upper:]')

# Automatic brain architecture selection (SMALL vs LARGE)
if [[ "$MODE_UPPER" == "G" || "$MODE_UPPER" == "GRANDE" || "$MODE_UPPER" == "--GRANDE" || "$MODE_UPPER" == "-G" || "$MODE_UPPER" == "LARGE" ]]; then
    export BB_BRAIN_MODE="GRANDE"
    MODEL_BASE="la_marionetaG"
    BRAIN_FLAG="--grande"
    BRAIN_DESC="LARGE BRAIN (10x192 ~27.5 MB)"
else
    export BB_BRAIN_MODE="CHICO"
    MODEL_BASE="la_marioneta"
    BRAIN_FLAG=""
    BRAIN_DESC="SMALL BRAIN (6x128 ~7.6 MB)"
fi

MODEL_PATH="/mnt/c/bb/${MODEL_BASE}.pth"

TRAIN_STEPS=12           # With 512 games/cycle, can be increased to 24 to preserve a 5:1 ratio
TOTAL_CYCLES=100000

NEW_GAMES=$((WORKERS * GAMES_PER_WORKER))
ACCUMULATED_GAMES=0
BACKUP_THRESHOLD=20000

echo "=============================================================="
echo "  BB-ZERO v12 — STARTING PIPELINE"
echo "  MODE    : $BRAIN_DESC"
echo "  MODEL   : $MODEL_PATH"
echo "  CONFIG  : $WORKERS workers | $SIMS sims | $GAMES_PER_WORKER game(s)/worker"
echo "=============================================================="

for ((CYCLE=1; CYCLE<=TOTAL_CYCLES; CYCLE++)); do
    START=$(date +%s)

    echo "=============================================================="
    echo "[CYCLE $CYCLE / $TOTAL_CYCLES] BB-ZERO v12 [$BB_BRAIN_MODE] ($NEW_GAMES games | $WORKERS workers | $TRAIN_STEPS GPU passes)"
    echo "=============================================================="

    # 1. PARALLEL C++ SELF-PLAY (libselfplay12.so — up to 2,048 workers)
    echo "[CYCLE $CYCLE] Generating $NEW_GAMES games in C++ ($WORKERS workers, $SIMS sims, mode $BB_BRAIN_MODE)... (time: $(date +"%H:%M:%S"))"
    python3 run_selfplay12.py "$WORKERS" "$SIMS" "$GAMES_PER_WORKER"

    ACCUMULATED_GAMES=$((ACCUMULATED_GAMES + NEW_GAMES))
    echo "[CYCLE $CYCLE] Accumulated games toward next backup: $ACCUMULATED_GAMES / $BACKUP_THRESHOLD"

    # 2. MILESTONE CHECKPOINT BACKUP (Every ~20,000 games)
    if [ "$ACCUMULATED_GAMES" -ge "$BACKUP_THRESHOLD" ]; then
        TIMESTAMP=$(date +"%Y_%m_%d_%H_%M_%S")
        if [ -f "$MODEL_PATH" ]; then
            cp "$MODEL_PATH" "/mnt/c/bb/${MODEL_BASE}_${TIMESTAMP}.pth"
            echo "[CYCLE $CYCLE] MILESTONE REACHED! Backup saved: ${MODEL_BASE}_${TIMESTAMP}.pth" | tee -a training.txt
            ACCUMULATED_GAMES=0
        else
            echo "[CYCLE $CYCLE] WARNING: $MODEL_PATH not found for backup" | tee -a training.txt
        fi
    fi

    # 3. CONTINUOUS HYBRID GPU TRAINING (-4 with $TRAIN_STEPS passes in a single session)
    echo "[CYCLE $CYCLE] Training brain12.py [$BB_BRAIN_MODE] (-4 $TRAIN_STEPS continuous passes)... (time: $(date +"%H:%M:%S"))" | tee -a training.txt
    if [ -n "$BRAIN_FLAG" ]; then
        python3 brain12.py -4 "$TRAIN_STEPS" "$BRAIN_FLAG" | tee -a training.txt
    else
        python3 brain12.py -4 "$TRAIN_STEPS" | tee -a training.txt
    fi

    # 4. CYCLE DURATION SUMMARY
    END=$(date +%s)
    DURATION=$((END - START))
    H=$((DURATION / 3600))
    M=$(((DURATION % 3600) / 60))
    S=$((DURATION % 60))

    echo "[CYCLE $CYCLE] COMPLETED at $(date +"%H:%M:%S"). Duration: ${H}h ${M}m ${S}s" | tee -a training.txt
    echo "" | tee -a training.txt
    sleep 2
done
