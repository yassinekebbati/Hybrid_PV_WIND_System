# Hybrid_PV_WIND_System

This is the implementation of the work published in the following article "Design, modeling and control of a hybrid grid-connected photovoltaic-wind system for the region of Adrar, Algeria".
The paper is freely accessible at this link:(https://link.springer.com/article/10.1007/s13762-022-04426-y) 

## Steps to run the code:

This implementation requires MATLAB 2018b or a more recent version.

-  # Hybrid_PV_Wind:
   ## This part is the implementation of the Hybrid Grid-connected Pv_Wind system in Simulink (with wind and solar data for January and August, case of Adrar city in Algeria).

   1. You only need to open the main slx model file and run the simulation (it takes a while to finish).
   2. Data files are included in the folder for weather, solar irradiation, cost and cash flow of the system, etc...
        

-  # PSO_PI:
   ## This code is used to optimize the PI controller gain using an improved PSO algorithm.

   1. To start the optimization run the script 'PSO_PV_WIND_APP.m.
   2. The script sets up the optimization problem through the script "PV_WIND_param.m", and executes the optimization through the script "PSO_PV_WIND_func.m".
   3. The code simulates a lighter version of the model found in "PVWIND.slx" to optimize the controller parameters by minimizing the cost function defined in "PV_WIND_param.m". 
      
- # System_Components:
  - This folder contains different implementations of the components of the system, for more details you can refer to the main paper referenced above.          



## If you find this work useful or use it in your work, please cite the main paper:
#### APA:
Kebbati, Y., & Baghli, L. (2023). Design, modeling and control of a hybrid grid-connected photovoltaic-wind system for the region of Adrar, Algeria. International Journal of Environmental Science and Technology, 20(6), 6531-6558.

#### BibTeX:
@article{kebbati2023design,
  title={Design, modeling and control of a hybrid grid-connected photovoltaic-wind system for the region of Adrar, Algeria},
  author={Kebbati, Yassine and Baghli, L},
  journal={International Journal of Environmental Science and Technology},
  volume={20},
  number={6},
  pages={6531--6558},
  year={2023},
  publisher={Springer}
}
