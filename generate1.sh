#!/usr/bin/env bash
# ================================================================
# GENERATE7.SH — BB-ZERO TRAINING PIPELINE (brain105 only)
# ================================================================

set -euo pipefail

PROJECT_DIR="/mnt/c/python"
cd "$PROJECT_DIR"

# Self-play configuration
WORKERS=10
SIMS=800
GAMES_PER_WORKER=10     # 10 × 10 = 100 new games per cycle

TOTAL_CYCLES=100000

for ((CYCLE=1; CYCLE<=TOTAL_CYCLES; CYCLE++)); do
    START=$(date +%s)

    echo "=============================================================="
    echo "[CYCLE $CYCLE / $TOTAL_CYCLES] BB-ZERO hybrid training"
    echo "=============================================================="

    # ------------------------------------------------------------
    # 1. SELF-PLAY (~100 new games)
    # ------------------------------------------------------------
    echo "[CYCLE $CYCLE] Generating ~100 new games... (time: $(date +"%H:%M:%S"))"
    python3 brain105.py $WORKERS $SIMS $GAMES_PER_WORKER

    # ------------------------------------------------------------
    # 2. NETWORK BACKUP
    # ------------------------------------------------------------
    TIMESTAMP=$(date +"%Y_%m_%d_%H_%M_%S")
    if [ -f /mnt/c/bb/la_marioneta.h5 ]; then
        cp /mnt/c/bb/la_marioneta.h5 la_marioneta_$TIMESTAMP.h5
        echo "[CYCLE $CYCLE] Backup created: la_marioneta_$TIMESTAMP.h5" | tee -a training.txt
    else
        echo "[CYCLE $CYCLE] WARNING: la_marioneta.h5 not found for backup" | tee -a training.txt
    fi

    # ------------------------------------------------------------
    # 3. PHASE A — 25 TRAINING PASSES
    # ------------------------------------------------------------
    for ((I=1; I<=25; I++)); do
        echo "[A:$I/25] Training brain105 (-4)... (time: $(date +"%H:%M:%S"))"
        python3 brain105.py -4
    done

    # ------------------------------------------------------------
    # 4. LOGGED TRAINING PASS (one log per cycle)
    # ------------------------------------------------------------
    echo "[LOG] Cycle training pass... (time: $(date +"%H:%M:%S"))" | tee -a training.txt
    python3 brain105.py -4 | tee -a training.txt

    # ------------------------------------------------------------
    # 5. CYCLE DURATION LOG
    # ------------------------------------------------------------
    END=$(date +%s)
    DURATION=$((END - START))
    H=$((DURATION / 3600))
    M=$(((DURATION % 3600) / 60))
    S=$((DURATION % 60))

    echo "[CYCLE $CYCLE] COMPLETED at $(date +"%H:%M:%S"). Duration: ${H}h ${M}m ${S}s" | tee -a training.txt
    echo "" | tee -a training.txt

    echo "[CYCLE $CYCLE] Waiting 5 seconds before next cycle..."
    sleep 5
done

echo "=============================================================="
echo "ALL $TOTAL_CYCLES COMPLETED."
echo "=============================================================="
