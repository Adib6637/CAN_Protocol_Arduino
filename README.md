# Readme

This repository is where I put my UPPAAL model of Non preemtive protocol (NPP).


## General Information

Some aspect related to the model

1. Notation
    - All notation are decribed in the the declaration file inside the UPPAL model
2. Interupt Mode
    - Interrupt is enabled by default but can be change in declaration file inside the UPPAL model
3. NPP integration
    - The model is by default integrated with NPP but can be disable in declaration file inside the UPPAL model
4. Number of task
    - By defult, number of task is 3 and can be increased. If you want to add more task, make sure the arrival time, completion time and the nominal priority is assign properly to make sure all the task schedulable!!!.

## Simulation

- You can try to play with the simulation (by disabling or eanabling the interrrupt and NPP). 
- Compare the number of fail of each task and longest blocking time expereience by a task in all possible mode.
- Have fun with the simulation!!!


## Copyright
- This model is fully design by me and you are allowed to copy it.
