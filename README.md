# exploring-parameters-simple-garage-beat-generator
A GUI implementation for exploring parameter spaces of a simple garage beat generator</br>
This repo contains a practical implementation of the algorithm for perceptual parameters space exploration presented in
https://github.com/musikinformatik/exploring-parameters .
The explored algorithm is a 16 steps beat generator of garage which is a simplified version of one presented in Collins (2003)
"Algorithmic Composition Methods for Breakbeat Science". The algorithm have 5 changing parameters (~p1, ..., ~p5). The GUI
allows for two exploration modes: Randon and Manual.
The random mode creates a random pattern out of all the possible patterns in the space.
The manual mode allows the user to manually select the value for each parameter.
In the experiments we found that random mode is useful when the space of parameters small. For higher dimensional spaces it is better to start from a seed in the manual mode and explore the space in the different directions, performing gradual changes in the parameters and returning to the original seed after exploring each parameter. For each parameters combination, the user perceptual evaluation is salved. The system allows to have as much classes as desired.
Each classification corresponds with a specific aural property of the outputs selected by the user.
The rule extraction button perform the compaction process of the algorithm. Print rules shows the rules produced by the differnet permutations of the data.
Bag of rules print the rules. Combinations of parameters with free parameters.
Select rule and play rule allow to play the different rules contained in "bag of rules"
