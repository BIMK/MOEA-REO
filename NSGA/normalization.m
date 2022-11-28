function normalized_objs = normalization(mixed_objs, popsize, idealpoint)
    % This function normalizes the objective value of the mixed population
    %
    % mixed_objs : the objective values of the mixed population
    % popsize    : the population size
    % idealpoint : ideal point

    nadir_point     = max(mixed_objs);

    max_objs        = nadir_point(ones(popsize, 1), :);
    min_objs        = idealpoint(ones(popsize, 1), :);
    normalized_objs = (mixed_objs - min_objs) ./ (max_objs -  min_objs);
end