function [Convergence , Best_Obj , Best_Fit ,Best_Sol] = BABC(Function_Name, opCode)
    global Bees FuncEval Parameters
    problem=strcat('text/',Function_Name,'.txt');
    global matris
    Parameters.Counters = ones(1,7);
    Parameters.phiMax = 0.9;
    Parameters.phiMin = 0.5;
    Parameters.qStart = 0.3;
    Parameters.qEnd = 0.1;
    
    matris=dosya2mat(problem);
    CostFunction= @(bees) objective(bees);     % Cost Function
    Convergence = [];
    
    NB = Parameters.N/2;
    limit = (NB*Parameters.D)*2.5;
    
    
    for i=1:NB
        Bees(i).Solution = GenerateRandomSolution(Parameters.D);
        Bees(i).Cost = CostFunction(Bees(i));
        Bees(i).Fitness = CalculateFitness(Bees(i).Cost);
        Bees(i).Trial = 0;
    end
    
    FuncEval = Parameters.N;
    GlobalBestCost = min([Bees.Cost]);
    Parameters.maxIter = Parameters.MaxFuncEval/NB;
    Convergence(1) = GlobalBestCost;
while FuncEval < Parameters.MaxFuncEval
    Parameters.t = FuncEval/Parameters.N;
    Parameters.dim = rand()*4 + exp(-4*(Parameters.t/Parameters.maxIter)*(0.1*Parameters.D)+1);
    [Parameters.dim]
    for i=1:NB
        neighbor = tournement_selection(Bees);
        while neighbor==i
            neighbor = tournement_selection(Bees);
        end
        [opC, NewSolution.Solution] = ApplyNeighborhood(i,neighbor,opCode);
        NewCost = CostFunction(NewSolution);
        if NewCost >= Bees(i).Cost
            Bees(i).Trial=Bees(i).Trial+1;
            Parameters.Counters(opC) =  max(1,Parameters.Counters(opC)-1);
            
        else
            Bees(i).Solution = NewSolution.Solution;
            Bees(i).Cost = NewCost;
            Bees(i).Fitness = CalculateFitness(Bees(i).Cost);
            Bees(i).Trial=0;
            Parameters.Counters(opC) = Parameters.Counters(opC)+1;
        end
    end
    Probs = [Bees.Fitness] ./ sum([Bees.Trial]+1+0.1);
    maxFit = max(Probs);
    probs = (Probs.* 0.9)/maxFit+0.1;
    i=1;
    t=0;
    while t<NB
        if rand<probs(i)
            t=t+1;
            neighbor = tournement_selection(Bees);
            while neighbor==i
                neighbor = tournement_selection(Bees);
            end
            [opC, NewSolution.Solution] = ApplyNeighborhood(i,neighbor,opCode);
            NewCost = CostFunction(NewSolution);
            if NewCost >= Bees(i).Cost
                Bees(i).Trial=Bees(i).Trial+1;
                Parameters.Counters(opC) = max(1,Parameters.Counters(opC)-1);
            else
                Bees(i).Solution = NewSolution.Solution;
                Bees(i).Cost = NewCost;
                Bees(i).Fitness = CalculateFitness(Bees(i).Cost);
                Bees(i).Trial=0;
                Parameters.Counters(opC) = Parameters.Counters(opC)+1;
            end
        end
        i=i+1;
        if i>NB
            i=1;
        end
    end
    for i=1:NB
        if Bees(i).Trial>limit
            Bees(i).Solution = GenerateRandomSolution(Parameters.D);
            Bees(i).Cost = CostFunction(Bees(i));
            Bees(i).Fitness = CalculateFitness(Bees(i).Cost);
            Bees(i).Trial = 0;
            break;
        end
    end
    BestCost = min([Bees.Cost]);
   	if GlobalBestCost>BestCost
        GlobalBestCost=BestCost;
    end
    FuncEval = FuncEval+ Parameters.N;
    fprintf('iter: %d Cost: %f GAP:%f \n',FuncEval/Parameters.N,GlobalBestCost,Parameters.Optimum-GlobalBestCost);
    Convergence(FuncEval/Parameters.N) = GlobalBestCost;
end
    Best_Obj = GlobalBestCost;
    Best_Fit = 0;
    Best_Sol=0;
end