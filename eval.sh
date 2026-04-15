MODEL_PATH="meta-llama/Llama-2-13b-hf"
MODEL_NAME="llama-2-13b"
TEMP=0.0 # 0.2 for general tasks and 0.6 for code generation
TOP_P=0.85 # 0.85 for general tasks and 0.95 for code generation
DATA_NUM=100
SEED=2024
GPU_DEVICES=0
MAX_NEW_TOKENS=512
torch_dtype="float16" # ["float32", "float64", "float16", "bfloat16"]
TASK_NAME="gsm8k"

# Dynamic Hyperparameters
OPT_INTERVAL=1
BAYES_INTERVAL=30
MAX_OPT_ITER=100
MAX_TOLERANCE_ITER=300
MAX_SCORE=0.95
CONTEXT_WINDOW=100
SKIP_RATIO=0.4
LAMBDA=0.25
OPT_METHOD="dynamic"

CUDA_VISIBLE_DEVICES=${GPU_DEVICES} python -m evaluation.inference_conflayer --model-path $MODEL_PATH --model-id ${MODEL_NAME} --temperature $TEMP --top-p ${TOP_P} --dtype $torch_dtype --task-name ${TASK_NAME} --data-num ${DATA_NUM} --max-new-tokens ${MAX_NEW_TOKENS} --seed $SEED --context-window ${CONTEXT_WINDOW} --opt-interval ${OPT_INTERVAL} --bayes-interval ${BAYES_INTERVAL} --max-opt-iter ${MAX_OPT_ITER} --max-tolerance-iter ${MAX_TOLERANCE_ITER} --max-score ${MAX_SCORE} --skip-ratio ${SKIP_RATIO} --optimization ${OPT_METHOD} --bayes --lam ${LAMBDA} --cache-hit &> logs/conflayers.out


# SWIFT Hyperparameters
SWIFT_OPT_INTERVAL=1
SWIFT_BAYES_INTERVAL=25
SWIFT_MAX_OPT_ITER=1000
SWIFT_MAX_TOLERANCE_ITER=300
SWIFT_MAX_SCORE=0.95
SWIFT_CONTEXT_WINDOW=32
SWIFT_SKIP_RATIO=0.45
OPT_METHOD="swift"

CUDA_VISIBLE_DEVICES=${GPU_DEVICES} python -m evaluation.inference_baseline --model-path $MODEL_PATH --model-id ${MODEL_NAME} --max-new-tokens ${MAX_NEW_TOKENS} --task-name ${TASK_NAME} --data-num ${DATA_NUM} --temperature $TEMP --top-p ${TOP_P} --seed ${SEED} --dtype $torch_dtype &> logs/vanilla.out

CUDA_VISIBLE_DEVICES=${GPU_DEVICES} python -m evaluation.inference_conflayer --model-path $MODEL_PATH --model-id ${MODEL_NAME}  --temperature $TEMP --top-p ${TOP_P} --dtype $torch_dtype --task-name ${TASK_NAME} --data-num ${DATA_NUM} --max-new-tokens ${MAX_NEW_TOKENS} --seed $SEED --context-window ${SWIFT_CONTEXT_WINDOW} --opt-interval ${SWIFT_OPT_INTERVAL} --bayes-interval ${SWIFT_BAYES_INTERVAL} --max-opt-iter ${SWIFT_MAX_OPT_ITER} --max-tolerance-iter ${SWIFT_MAX_TOLERANCE_ITER} --max-score ${SWIFT_MAX_SCORE} --skip-ratio ${SWIFT_SKIP_RATIO} --optimization ${OPT_METHOD} --bayes --cache-hit &> logs/swift.out

