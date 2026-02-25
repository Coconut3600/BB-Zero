#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="/mnt/c/python"
PYFILE="brain1.py"

WORKERS=14
SIMS=40
GAMES_PER_WORKER=4
LOOPS=179   # 56 × 179 ≈ 10,000 partidas

cd "$PROJECT_DIR"

CYCLE=1

while true; do
    START=$(date +%s)

    echo "=============================================="
    echo "[CICLO $CYCLE] Generando ~10,000 partidas..."
    echo "=============================================="

    for ((i=1; i<=LOOPS; i++)); do
        echo "[CICLO $CYCLE] [LOOP $i/$LOOPS] Ejecutando $WORKERS workers..."
        python3 "$PYFILE" $WORKERS $SIMS $GAMES_PER_WORKER
    done

    echo "[CICLO $CYCLE] Entrenando..."

    # Fecha actual
    FECHA=$(date '+%Y-%m-%d %H:%M:%S')

    # Encabezado en training.txt
    echo "===== CICLO $CYCLE | $FECHA =====" >> training.txt

    # Entrenamiento (append)
    python3 "$PYFILE" 0 | tee -a training.txt

    # Calcular duración del ciclo
    END=$(date +%s)
    DURACION=$((END - START))
    H=$((DURACION / 3600))
    M=$(((DURACION % 3600) / 60))
    S=$((DURACION % 60))

    echo "Duración del ciclo: ${H}h ${M}m ${S}s" >> training.txt
    echo "" >> training.txt

    echo "[CICLO $CYCLE] COMPLETADO. Duración: ${H}h ${M}m ${S}s"
    echo "Esperando 5 segundos antes del siguiente ciclo..."
    sleep 5

    CYCLE=$((CYCLE + 1))
done
