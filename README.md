# ConfLayers

This code is built on top of the SWIFT framework: https://github.com/hemingkx/SWIFT.git.

## Steps to run AMD MI300X with ROCm 6.4.1
```
conda env create -f environment.yml
conda activate conflayers
pip3 install torch torchvision --index-url https://download.pytorch.org/whl/rocm6.4
chmod +x eval.sh
hf auth login
```
