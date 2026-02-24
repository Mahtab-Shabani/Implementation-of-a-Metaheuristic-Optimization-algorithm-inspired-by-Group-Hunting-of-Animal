# Implementation-of-a-Metaheuristic-Optimization-algorithm-inspired-by-Group-Hunting-of-Animal

This repository is a MATLAB implementation of the Hunting Search (HS) algorithm, a population-based metaheuristic inspired by group hunting of animals.

The implementation follows the method proposed in:

```R. Oftadeh et al., “A novel meta-heuristic optimization algorithm inspired by group hunting of animals: Hunting Search.” ```
<br />

Overview
===========
Hunting Search simulates the collective behavior of hunters, where:
* A leader hunter guides the population toward promising regions.
Hunters update their positions based on:
* Leader attraction (exploitation)
* Group communication (information sharing)
* Random exploration
A convergence mechanism is triggered when diversity decreases.
<br />

⚙️ Files
===========

* ```hunting_search.m``` — Main script for running the algorithm
* ```objj.m``` — Objective function definition
<br />

▶️ How to Run
===========
**1. Select the desired objective function:**

```
% function1
Z=(X-Y).^2+((X+Y-10)/3).^2;

% function2
Z=(X.^2+Y.^2);

% function3
Z=100*(X.^2-Y)+(X-1).^2;
```
Also update the same function inside ```objj.m```.
<br />

**2. Run the main script:** <br />
```
hunting_search.m
```
<br />

🔧 Parameters
===========
Key parameters used in the algorithm:
* `num_hunter` — Population size
* `max_iter` — Maximum iterations
* `MML` — Movement toward leader
* `HGCR` — Harmony/group communication rate
* `alpha`, `beta` — Convergence control parameters
* `Ramin`, `Ramax` — Step size range
<br />

📊 Output
===========
The code generates: <br />
•	3D surface plot of the objective function <br />
•	Best solution found (marked on surface) <br />
•	Convergence curves over multiple runs <br />
•	Statistical results: <br />
* Average best value
* Best / Worst performance

**Function1**

<img width="498" height="368" alt="image" src="https://github.com/user-attachments/assets/a42f234a-3698-4297-a24a-65379728d1ec" />

**Function2**

<img width="493" height="367" alt="image" src="https://github.com/user-attachments/assets/72333c7b-56e3-4a80-848b-abdf0c71f825" />

**Function3**

<img width="500" alt="image" src="https://github.com/user-attachments/assets/fa1c41a9-47c1-4d40-8157-8abf0fc0fac0" />
