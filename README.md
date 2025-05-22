Source code of the paper [Model-Based Exploration in Truthful Monitored Markov Decision
Processes](https://arxiv.org/abs/2502.16772).

<p align="center">
  <img src="banner/Treasure_Hunt_Uncertainty.png" width="30%">
  <img src="banner/Treasure_Hunt_Counterfactual.png" width="30%">
  <img src="banner/Treasure_Hunt_Cautious.png" width="30%">
</p>

# Structure's Logic
The paper includes eight types of experiments. We have included
the source code of [Directed-E<sup>2</sup>](https://github.com/AmiiThinks/mon_mdp_neurips24) and Monitor MBIE-EB-EB
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

# Running the code

# TODO
The README will be completed gradually soon.


