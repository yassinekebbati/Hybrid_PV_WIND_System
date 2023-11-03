function out = PSO_PV_WIND_func(problem, params)
    tic
    %%Problem Definition

    CostFunction = problem.CostFunction;  % Cost Function

    nVar = problem.nVar;     % Number of Unknown (Decision) Variables

    VarSize = [1 nVar];    %Matrix Size of Decision Variables

    Kp_Min = problem.Kp_Min;          %Lower Bound of Decision Variables
    Kp_Max = problem.Kp_Max;          %Upper Bound of Decision Variables
    Ki_Min = problem.Ki_Min;          %Lower Bound of Decision Variables
    Ki_Max = problem.Ki_Max;          %Upper Bound of Decision Variables
   

    VarMin = [Kp_Min Ki_Min ];
    VarMax = [Kp_Max Ki_Max ];


    %%Parameters of PSO


    MaxIt = params.MaxIt;     %Maximum Number of Iterations

    nPop = params.nPop;       %Population size (swarm size)

    w = params.w;           % inertia coefficient
    w_max = params.w_max;           % maximum inertia coefficient
    w_min = params.w_min;           % minimum inertia coefficient
    c1 = params.c1;          %Personal acceleration coefficient
    c2 = params.c2;          %social acceleration coefficient

    ShowIterationInfo = params.ShowIterInfo;    %the Flag for Showing interation information

    MaxVelocity = 0.2*(VarMax-VarMin);
    MinVelocity = -MaxVelocity; 
    

    %%Initialization

    % The Particle Template
    empty_particle.Position = [];
    empty_particle.Velocity = [];
    empty_particle.Cost = [];
    empty_particle.Best.Position = [];
    empty_particle.Best.Cost = [];


    %Create Population Array
    particle = repmat(empty_particle, nPop, 1);



    % Initialize Global Best
    GlobalBest.Cost = inf;



        %Initialize Population Members
        for  i = 1:nPop

            % Generate Random Solution
            kp = unifrnd(Kp_Min,Kp_Max); 
            ki = unifrnd(Ki_Min,Ki_Max); 



            %particle(i).Position = [a N Nc Np Qy R];
            particle(i).Position = [kp ki];


            % Initialize Velocity
            particle(i).Velocity = zeros(VarSize);

            % Evaluation
            particle(i).Cost = CostFunction(particle(i).Position);

            %Update the Personal Best
            particle(i).Best.Position = particle(i).Position;
            particle(i).Best.Cost = particle(i).Cost;

            %Update Global Best
            if particle(i).Best.Cost < GlobalBest.Cost
                GlobalBest = particle(i).Best;
            end


        end


        % Array to Hold Best Cost Value on Each Iteration
        BestCosts = zeros(MaxIt,1);

        


            %%Main Loop of PSO

            for it=1:MaxIt
                it

                for i=1:nPop

                    %Update Velocity
                    particle(i).Velocity = w*particle(i).Velocity...
                        + c1*rand(VarSize).*(particle(i).Best.Position - particle(i).Position)...
                        + c2*rand(VarSize).*(GlobalBest.Position - particle(i).Position);

                    % Apply Velocity Limits
                    particle(i).Velocity = max(particle(i).Velocity, MinVelocity);
                    particle(i).Velocity = min(particle(i).Velocity, MaxVelocity); 
                    %particle(i).Velocity

                    % Update Position
                    particle(i).Position = particle(i).Position + particle(i).Velocity;

                    %Apply Lower and Upper Bound Limits
                    particle(i).Position = max(particle(i).Position, VarMin);
                    particle(i).Position = min(particle(i).Position, VarMax);          


                    % Evaluation
                    particle(i).Cost = CostFunction(particle(i).Position);

                    % Update Personal Besy
                    if particle(i).Cost < particle(i).Best.Cost

                        particle(i).Best.Position = particle(i).Position;
                        particle(i).Best.Cost = particle(i).Cost;

                        %Update Global Best
                        if particle(i).Best.Cost < GlobalBest.Cost
                            GlobalBest = particle(i).Best;
                        end

                    end

                end

                %Store the Best Cost Value
                BestCosts(it) = GlobalBest.Cost;

                %Display Iteration Information
                if ShowIterationInfo
                    disp(['Iteration ' num2str(it) ' : Best Cost = ' num2str(BestCosts(it))]);
                end


                %To be modified
                %acceleration Coeffecients

                if i <= round(0.3*MaxIt)
                    c1 = c1 + 0.085;
                    c2 = c2 - 0.0425;
                elseif i <= round(0.6*MaxIt)
                    c1 = c1 + 0.0425;
                    c2 = c2 - 0.085;
                elseif i <= round(0.85*MaxIt)
                    c1 = c1 - 0.025;
                    c2 = c2 + 0.05;
                else
                    c1 = c1 - 0.0025;
                    c2 = c2 + 0.0025;
                end


                w = w_min + exp((w_max - it*30*(w_max+w_min)/MaxIt))/3;


            out.pop = particle;
            out.BestSol = GlobalBest;
            out.BestCosts = BestCosts; 
            runtime = toc   

            end
end

