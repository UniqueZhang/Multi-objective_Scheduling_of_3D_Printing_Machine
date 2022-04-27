function [ Winner ] = TournamentSelection_nsga2( Pop, WinnerNum )
%TOURNAMENTSELECTION aims at performing the tournament selection and output
% the champion individual. 
% ** This function can work only on the sorted Pop, i.e., Pop(i) is better than Pop(i+1)

%% Inputs
% Pop: The matrix of the population's chromosome
%    - Pop(i,:) is the chromosome of the i-th individual in the population
% WinnerNum: The number of individuals to be selected in total

%% Default parameter

TournamentSize = 2;       % Tournament size, i.e., number of individuals in each round of competition

%% Algorithm

PopSize = size(Pop,1);
I_winner = zeros(WinnerNum,1);

for i=1:WinnerNum
    
    I_candidate = datasample(1:PopSize,TournamentSize,'Replace',false);
    I_winner(i,1) = min(I_candidate);
  
end

Winner = Pop(I_winner);

end

