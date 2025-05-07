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

if [ $x == 1 ] || [ $x == 2 ]; then

cd Mon-MBIE-EB || exit
git checkout $branch

if test -d data; then
  rm -rf data
fi

../venv/bin/python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 2)" #>/dev/null

cd ../mon_mdp_neurips24 || exit
git checkout "$branch"
../venv/bin/python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 2)" #>/dev/null

cd ../Mon-MBIE-EB || exit
../venv/bin/python simple_plot.py

cp -r figs ../

elif [ $x == 3 ]; then
    cd Mon-MBIE-EB || exit
git checkout "$branch"

if test -d data; then
  rm -rf data
fi

python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 30)" >/dev/null

git checkout main_unsolvable
python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 30)" >/dev/null

cd ../mon_mdp_neurips24 || exit
git checkout main_unsolvable
python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 30)" >/dev/null

cd ../Mon-MBIE-EB || exit
git checkout "$branch"
python simple_plot.py

cp -r figs ../

elif [ $x == 4 ] || [ $x == 5 ] || [ $x == 6 ] || [ $x == 7 ]; then
    cd Mon-MBIE-EB || exit
git checkout "$branch"

if test -d data; then
  rm -rf data
fi

python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 30)" >/dev/null

git checkout main_unsolvable
python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 30)" >/dev/null

git checkout "$branch"
python simple_plot.py

cp -r figs ../
fi
