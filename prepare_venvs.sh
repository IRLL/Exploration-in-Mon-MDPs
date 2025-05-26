#!/bin/bash

python3 -m venv de2_venv # For experiments involving Directed-E^2
python3 -m venv venv # For other experiments

source de2_venv/bin/activate
pip install -r requirtments.txt
cd Directed_E2
git checkout 48_benchmark
cd src/gym-grid
pip install -e .
deactivate

cd ../../..
source venv/bin/activate
pip install -r requirtments.txt
cd Mon-MBIE-EB
git checkout main
cd src/gym-grid
pip install -e .
cd ../../..

# To back up
tar -czvf ../de2_venv.tar.gz de2_venv
tar -czvf ../venv.tar.gz venv