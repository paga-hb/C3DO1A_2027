#!/bin/bash

source "$(conda info --base)/etc/profile.d/conda.sh"

conda create -y -p ./.conda python=3.12
conda activate ./.conda
python -m pip install --upgrade pip
pip install ipykernel jupyter