# Python

## download miniconda

```bash
brew install miniconda
```

## create vm env

```bash
conda create -n DataCalculation python=3.10
```

## download Third party package

```bash 
python3 -m pip install -U pip
python3 -m pip install --pre torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/nightly/cpu
python3 -m pip install -U numpy pandas sympy scipy statsmodels opencv-python pillow pyecharts matplotlib scikit-learn jupyterlab blaze plotly
```

## referer
- https://www.zybuluo.com/Rays/note/2291566
- https://github.com/rasbt/machine-learning-notes/tree/main/benchmark/pytorch-m1-gpu

