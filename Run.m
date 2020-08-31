clearvars; %Clear workspace
clc; clear; close all; 
global Parameters

for Function_No=1:15
    
    switch Function_No
       case 1  , Function_Name= 'Cap71';    Parameters.D= 16;     Parameters.N=  16;    Parameters.Optimum =  932615.75;
       case 2  , Function_Name= 'Cap72';    Parameters.D= 16;     Parameters.N=  16;    Parameters.Optimum =  977799.40;
       case 3  , Function_Name= 'Cap73';    Parameters.D= 16;     Parameters.N=  16;    Parameters.Optimum = 1010641.45;
       case 4  , Function_Name= 'Cap74';    Parameters.D= 16;     Parameters.N=  16;    Parameters.Optimum = 1034976.975;%1034976.98;
       case 5  , Function_Name= 'Cap101';   Parameters.D= 25;     Parameters.N=  25;    Parameters.Optimum =  796648.4375;%796648.44;
       case 6  , Function_Name= 'Cap102';   Parameters.D= 25;     Parameters.N=  25;    Parameters.Optimum =  854704.20;
       case 7  , Function_Name= 'Cap103';   Parameters.D= 25;     Parameters.N=  25;    Parameters.Optimum =  893782.1125;%893782.11;
       case 8  , Function_Name= 'Cap104';   Parameters.D= 25;     Parameters.N=  25;    Parameters.Optimum =  928941.75;
       case 9  , Function_Name= 'Cap131';   Parameters.D= 50;     Parameters.N=  50;    Parameters.Optimum =  793439.5625;%793439.56;
       case 10 , Function_Name= 'Cap132';   Parameters.D= 50;     Parameters.N=  50;    Parameters.Optimum =  851495.325;%851495.33;
       case 11 , Function_Name= 'Cap133';   Parameters.D= 50;     Parameters.N=  50;    Parameters.Optimum =  893076.7125;%893076.71;
       case 12 , Function_Name= 'Cap134';   Parameters.D= 50;     Parameters.N=  50;    Parameters.Optimum =  928941.75;%e-10
       case 13 , Function_Name= 'CapA';     Parameters.D= 100;    Parameters.N=  100;   Parameters.Optimum =17156454.4783;%17156454.48;
       case 14 , Function_Name= 'CapB';     Parameters.D= 100;    Parameters.N=  100;   Parameters.Optimum =12979071.58143;%12979071.58;
       case 15 , Function_Name= 'CapC';     Parameters.D= 100;    Parameters.N=  100;   Parameters.Optimum =11505594.33;
       otherwise , fprintf('HATA\n');
    end
    
    Parameters.N=  40;
    Parameters.Convergence=1;
    Parameters.MaxFuncEval = 80000;      
    
    Nr = 30;

    OBJ_BEST_fits = zeros(1,Nr);
    
    for r=1:1:Nr
        tic; %Reset the timer
        
        for o=1:8
            [Function{Function_No}.Convergence{o}.data(r,:) , Function{Function_No}.F_RUNS(o,r) , Function{Function_No}.OBJ_BEST_fits(o,r) , Function{Function_No}.BestSolution{o}.data(r,:)] = BABC(Function_Name, o);
        end
        
        Total_Time(r) = toc;
        F_GAPs(Function_No,r)= (Function{Function_No}.F_RUNS(o,r)-Parameters.Optimum)/Parameters.Optimum*100;
        %fprintf('Run = %d opt = %2.2f OBJ_BEST_fit=%d F_GAP=%2.2f \n', r, F_RUNS(r),OBJ_BEST_fits(r),F_GAPs(r));
    end 
    figure()
    for o=8:8
            plot( mean(Function{Function_No}.Convergence{o}.data)); 
            hold on
    end
    
    %%Draw
    
end