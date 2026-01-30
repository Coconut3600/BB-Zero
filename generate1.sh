#!/usr/bin/env bash
#review xpartida = GAMES_PER_MOVE x WORKERS
set -euo pipefail

PROJECT_DIR="/mnt/c/python"
PYFILE="brain1.py"

OUTER_LOOPS=200       
GAMES_PER_WORKER=6   #partidas 
SIMS=40               
WORKERS=8             

cd "$PROJECT_DIR"

echo "[INFO] Initializing training..."
echo "[INFO] $OUTER_LOOPS episodes | $GAMES_PER_WORKER partidas | $SIMS simulations"

for ((episode=1; episode<=OUTER_LOOPS; episode++)); do
  echo "=============================="
  echo "[EPISODE $episode/$OUTER_LOOPS]"

  # Self-play con workers
  python3 "$PYFILE" $WORKERS $SIMS $GAMES_PER_WORKER

  # training (1 epoch)
  python3 "$PYFILE" 0

  echo "[EPISODE $episode] Complete."
done

echo "=============================="
echo "[DONE] Training completed."

#arena  python3 "$PYFILE" -2 
