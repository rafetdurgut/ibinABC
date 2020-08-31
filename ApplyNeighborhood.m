function [opc,solution] = ApplyNeighborhood(Xi,Xk, opCode)
    opc=opCode;
    switch(opCode)
        case 1
           solution= XorBased(Xi,Xk);
        case 2
           solution= Dissimiliarity(Xi,Xk);
       case 3
           solution= TwoPointCrossOver(Xi,Xk);
        case 4
           solution= Swap(Xi,Xk);
        case 5
           solution= Insertion(Xi,Xk);
       case 6
           solution= Reversion(Xi,Xk);
        case 7
            solution = ebinABC(Xi,Xk);
        case 8
            [opc,solution]= vbo(Xi,Xk);            
    end
end