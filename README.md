Source code of the paper [Model-Based Exploration in Truthful Monitored Markov Decision
Processes](https://arxiv.org/abs/2502.16772).

<p align="center">
  <img src="banner/Treasure_Hunt_Uncertainty.png" width="30%">
  <img src="banner/Treasure_Hunt_Cautious.png" width="30%">
  <img src="banner/Treasure_Hunt_Counterfactual.png" width="30%">
</p>

# Download
Don't forget the **`--recursive`** argument when cloning the project.
```bash
git clone --recursive git@github.com:IRLL/Exploration-in-Mon-MDPs.git
```
# Structure's Logic
The paper includes eight types of experiments. We have included
the source code of [Directed-E<sup>2</sup>](https://github.com/AmiiThinks/mon_mdp_neurips24)
([with our additional changes](https://github.com/alirezakazemipour/mon_mdp_neurips24)) and Monitor MBIE-EB-EB
(Mon-MBIE-EB) as git submodules. To reproduce the result of each experiment's type, we should `checkout` to the corresponding 
branch that contains the experiments code. The experiments and corresponding branch name:

|                      Experiment                      |      Branch name       |
|:----------------------------------------------------:|:----------------------:|
|                48 benchmarks (Fig. 6)                |     `48_benchamrk`     |
|  Unsolvable Mon-MDPs (Fig. 4.b, 4.c, 5, 9, and 10)   |   `main_unsolvable`    |
|               Known Monitor (Fig. 11)                |    `known_monitor`     |
|       MBIE-EB in solvable Mon-MDPs (Fig. 12.a)       |    `mbie_solvable`     |
|      MBIE-EB in unsolvable Mon-MDPs (Fig. 12.b)      |   `mbie_unsolvable`    |
| Pessimistic MBIE-EB in solvable Mon-MDPs (Fig. 13.a) |  `pess_mbie_solvable`  |
| Pessimistic MBIE-EB in solvable Mon-MDPs (Fig. 13.b) | `pess_mbie_unsolvable` |

## Virtual Environments
To run the experiments, we need two virtual environments: one for benchmarks' implementation of Directed-E<sup>2</sup>
and one for our implementation of Bottleneck. Because we want to compare the Mon-MBIE-EB's performance
against Directed-E<sup>2</sup> **on benchmarks that Directed-E<sup>2</sup> was originally test on**, we need one virtual
environment that contains the original benchmarks' implementations. Therefore, if you want to reproduce the 48 benchmark
results, you need to create a virtual environment and name it `de2_venv`, then run `pip install -r requirments.txt` in 
the root directory, change your working directory to Directed-E<sup>2</sup> submodule, run `git checkout 48_benchmark` 
and:
```bash
cd src/gym-grid
pip install -e .
```
which installs the 48 benchmark environments.

For other experiments we will use our own environment implementations. Repeat the above the procedure, but instead, name
your virtual environment to `venv`, change your working
directory to Mon-MBIE-EB submodule and remain in the main branch and:
```bash
cd src/gym-grid
pip install -e .
```
To Avoid confusions, you can take a look at `prepare_venvs.sh` to see how the above procedure is done.

## Running the Code
To run the code, we need to use `run.sh`. This script accepts the branch name and initialization mode of experiments
that involve Directed-E<sup>2</sup>, and it returns the `figs` folder that would contain the plots.
For example, `./run.sh 48_benchamrk default` will run the 48 benchmarks experiments where the default initialization of 
Directed-E<sup>2</sup> is used, and `./run.sh 48_benchamrk pessimistic_init` will run the 48 benchmarks experiments
where the pessimistic initialization of Directed-E<sup>2</sup> is used.

If you're using a SLURM-based cluster, you can take a look at `submit.sh` to see how we run the experiments given the
virtual environments were prepared. 
