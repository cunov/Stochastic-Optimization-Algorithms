function iSelected = TournamentSelect(fitness, pTournament, tournamentSize)
   populationSize = length(fitness);
   
   individuals = zeros(tournamentSize,2); % matrix where each row is [index fitness(index)]
   numIndividualsChosen = 0;
   while numIndividualsChosen < tournamentSize
       iRand = randi(populationSize);
       if ~ismember(iRand,individuals(:,1))
           numIndividualsChosen = numIndividualsChosen + 1;
           individuals(numIndividualsChosen,:) = [iRand fitness(iRand)];
       end
   end
   individuals = flip(sortrows(individuals,2)); % [index fitness(index)] sorted in descending order of fitness
   
   iSelected = 0;
   while iSelected == 0
       if rand() < pTournament
           iSelected = individuals(1,1);
       else
           individuals(1,:) = []; % top individual lost, gets eliminated
       end
       if size(individuals,1) == 1 % if we only have one contender left
           iSelected = individuals(1,1);
       end
   end
end

