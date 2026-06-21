# ConfLayers: Adaptive Confidence-based Layer Skipping for Self-Speculative Decoding

## Installation

```
conda env create -f environment.yml
conda activate conflayers
pip3 install torch torchvision --index-url https://download.pytorch.org/whl/rocm6.4
```

## Inference

Run command lines in `eval.sh`, the results will be stored in `outputs/.../model_answer/`.

```
chmod +x eval.sh
hf auth login
./eval.sh
```

> For quick start with cached layer configuration in skip_layers.json, uncomment `--cache-hit` in `eval.sh`.
>

## Acknowledgments

This codebase is built on [Swift](https://github.com/hemingkx/SWIFT.git).

