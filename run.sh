#!/bin/bash

# Please enter your experiment type. Available experiments:
# 48_benchmark, main_unsolvable, known_monitor, mbie_eb_solvable, mbie_eb_unsolvable, pess_mbie_eb_solvable,
# pess_mbie_eb_unsolvable.

echo "Make sure your venv is activated! And Gym-Grid is installed"

branch=$1
echo "You selected: $branch."

x=0

if [ "$branch" == "48_benchmark" ]; then
  x=1
elif [ "$branch" == "main_unsolvable" ]; then
  x=2
elif [ "$branch" == "known_monitor" ]; then
  x=3
elif [ "$branch" == "mbie_eb_solvable" ]; then
  x=4
elif [ "$branch" == "mbie_eb_unsolvable" ]; then
  x=5
elif [ "$branch" == "pess_mbie_eb_solvable" ]; then
  x=6
elif [ "$branch" == "pess_mbie_eb_unsolvable" ]; then
  x=7
else
  echo "invalid branch $branch."
  exit
fi

if [$2 != ]

if [ $x == 1 ]; then

cd Mon-MBIE-EB || exit
git checkout -f "$branch"

if test -d data; then
  rm -rf data
fi

echo "***Mon-MBIE-EB started at $(date).***"
../dee_venv/bin/python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 30)" >/dev/null
echo "***Mon-MBIE-EB done at $(date).***"

cd ../mon_mdp_neurips24 || exit
git checkout -f "$branch"


echo "***Directed-E^2 started at $(date).***"
../dee_venv/bin/python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 30)" agent="$2" 2>&1
echo "***Directed-E^2 done at $(date).***"


cd ../Mon-MBIE-EB || exit
../dee_venv/bin/python simple_plot.py

cp -r figs ../

elif [ $x == 2 ]; then

cd Mon-MBIE-EB || exit
git checkout -f "$branch"

if test -d data; then
  rm -rf data
fi

echo "***Mon-MBIE-EB started at $(date).***"
../venv/bin/python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 30)" >/dev/null
echo "***Mon-MBIE-EB done at $(date).***"

cd ../mon_mdp_neurips24 || exit
git checkout -f "$branch"


echo "***Directed-E^2 started at $(date).***"
../venv/bin/python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 30)" agent="$2" >/dev/null 2>&1
echo "***Directed-E^2 done at $(date).***"


cd ../Mon-MBIE-EB || exit
../venv/bin/python simple_plot.py

cp -r figs ../

elif [ $x == 3 ]; then
    cd Mon-MBIE-EB || exit
git checkout -f "$branch"

if test -d data; then
  rm -rf data
fi

echo "***$branch started at $(date).***"
../venv/bin/python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 30)" >/dev/null
echo "***$branch done at $(date).***"

git checkout -f main_unsolvable

echo "***Mon-MBIE-EB started at $(date).***"
../venv/bin/python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 30)" >/dev/null
echo "***Mon-MBIE-EB done at $(date).***"

cd ../mon_mdp_neurips24 || exit
git checkout -f main_unsolvable


echo "***Directed-E^2 started at $(date).***"
../venv/bin/python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 30)" agent="$2" >/dev/null 2>&1
echo "***Directed-E^2 done at $(date).***"

cd ../Mon-MBIE-EB || exit
git checkout -f "$branch"
../venv/bin/python simple_plot.py

cp -r figs ../

elif [ $x == 4 ] || [ $x == 5 ] || [ $x == 6 ] || [ $x == 7 ]; then
    cd Mon-MBIE-EB || exit
git checkout -f "$branch"

if test -d data; then
  rm -rf data
fi

echo "$branch started at $(date).***"
../venv/bin/python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 30)" >/dev/null
echo "$branch done at $(date).***"

git checkout -f main_unsolvable
echo "***Mon-MBIE-EB started at $(date).***"
../venv/bin/python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 30)" >/dev/null
echo "***Mon-MBIE-EB done at $(date).***"

git checkout -f "$branch"
../venv/bin/python simple_plot.py

cp -r figs ../
fi
