clc;clear;close all;


% tic
%%Problem Definition
problem.CostFunction = @(x) PV_WIND_param(x);  % Cost Function
problem.nVar = 2;           % Number of Unknown (Decision) Variables
problem.Kp_Min = 0.5;    %exp(-3);          %Lower Bound of Decision Variables
problem.Kp_Max = 10 ;    %1-exp(-3);          %Upper Bound of Decision Variables
problem.Ki_Min = 2;          %Lower Bound of Decision Variables
problem.Ki_Max = 20;         %Upper Bound of Decision Variables







%%Parameters of PSO


params.MaxIt = 10;     %Maximum Number of Iterations
params.nPop = 20;       %Population size (swarm size)
params.w = 1;           % inertia coefficient
params.w_max = 0.99;           % maximum inertia coefficient
params.w_min = 0.1;           % minimum coefficient
params.c1 = 2.2;          %Personal acceleration coefficient
params.c2 = 2.2;          %social acceleration coefficient
params.ShowIterInfo = true;  %Flag for showing Iteration
 



k=1;

%% Calling PSO
       

out = PSO_PV_WIND_func(problem,params);

BestSol = out.BestSol;
BestCosts = out.BestCosts;


kp = out.BestSol.Position(1)
ki = out.BestSol.Position(2)







