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
git checkout -f "$branch"

if test -d data; then
  rm -rf data
fi

echo "Mon-MBIE-EB started."
../venv/bin/python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 30)" >/dev/null
echo "Mon-MBIE-EB done."

cd ../mon_mdp_neurips24 || exit
git checkout -f "$branch"

echo "Directed-E^2 started."
../venv/bin/python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 30)" >/dev/null
echo "Directed-E^2 done."


cd ../Mon-MBIE-EB || exit
../venv/bin/python simple_plot.py

cp -r figs ../

elif [ $x == 3 ]; then
    cd Mon-MBIE-EB || exit
git checkout -f "$branch"

if test -d data; then
  rm -rf data
fi

echo "$branch started."
../venv/bin/python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 30)" >/dev/null
echo "$branch done."

git checkout -f main_unsolvable
echo "Mon-MBIE-EB started."
../venv/bin/python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 30)" >/dev/null
echo "Mon-MBIE-EB done."

cd ../mon_mdp_neurips24 || exit
git checkout -f main_unsolvable

echo "Directed-E^2 started."
../venv/bin/python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 30)" >/dev/null
echo "Directed-E^2 done."

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

echo "$branch started."
../venv/bin/python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 30)" >/dev/null
echo "$branch done."

git checkout -f main_unsolvable
echo "Mon-MBIE-EB started."
../venv/bin/python main.py -m hydra/launcher=joblib hydra/sweeper=manual_sweeper experiment.rng_seed="range(0, 30)" >/dev/null
echo "Mon-MBIE-EB done."

git checkout -f "$branch"
../venv/bin/python simple_plot.py

cp -r figs ../
fi
