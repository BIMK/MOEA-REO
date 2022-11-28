function obj = subobjective(weight, ind, idealpoint, method)
    if (nargin == 2)
        obj = ws(weight, ind);
    elseif (nargin == 3)
        obj = te(weight, ind, idealpoint);
    else
        if strcmp(method, 'ws')
            obj = ws(weight, ind);
        elseif strcmp(method, 'te')
            obj = te(weight, ind, idealpoint);
        elseif strcmp(method, 'i_te')
            obj = i_te(weight, ind, idealpoint);
        elseif strcmp(method, 'ASF')
            obj = ASF(weight, ind, idealpoint);
        elseif strcmp(method, 'pbi')
            obj = pbi(weight, ind, idealpoint);
        elseif strcmp(method, 'n_pbi')
            obj = n_pbi(weight, ind, idealpoint);
        elseif  strcmp(method, 'bip')
            [obj, d] = bip(weight, ind, idealpoint);
        elseif  strcmp(method, 'n_bip')
            [obj, d] = n_bip(weight, ind, idealpoint);
        elseif  strcmp(method, 'n_bip2')
            obj = n_bip2(weight, ind, idealpoint);
        elseif  strcmp(method, 'n_bip3')
            obj = n_bip3(weight, ind, idealpoint);
        elseif strcmp(method, 'nc')
            [obj, d] = nc(weight, ind, idealpoint, normal_direction);
        else
            obj = te(weight, ind, idealpoint);
        end
    end
end

function obj = ws(weight, ind)
    obj = (weight' * ind)';
end

% Tchebycheff approach
function obj = te(weight, ind, idealpoint)

    weight((weight == 0)) = 10^-6;
        
    indsize = size(ind, 1);
    
    if indsize == 1
        diff        = abs(ind - idealpoint);
        diff_matrix = diff(ones(1, size(weight, 1)), :);
        obj         = max(weight .* diff_matrix, [], 2);
    else
        idealp_matrix = idealpoint(ones(1, indsize), :);
        diff_matrix   = abs(ind - idealp_matrix);
        obj           = max(weight .* diff_matrix, [], 2);
    end
    
end

% Modified Tchebycheff approach (direction-based)
function obj = i_te(weight, ind, idealpoint)

     weight((weight == 0)) = 10^-6;
    indsize     = size(ind, 1);
    
    if indsize == 1

        diff        = abs(ind - idealpoint);
        diff_matrix = diff(ones(1, size(weight, 1)), :);
        diff_matrix = ind(ones(1, size(weight, 1)), :);
        obj         = max(diff_matrix ./ weight, [], 2);

    else
        
        idealp_matrix = idealpoint(ones(1, indsize), :);
        diff_matrix   = abs(ind - idealp_matrix);
        diff_matrix = ind(ones(1, size(weight, 1)), :);
        obj           = max(diff_matrix ./ weight, [], 2);

    end

end

% Achievement Scalarization function
function obj = ASF(weight, ind, idealpoint)

    indsize               = size(ind, 1);
    weight((weight == 0)) = 10^-6;
    weight_matrix         = weight(ones(1, indsize), :);
    
    idealp_matrix = idealpoint(ones(1, indsize), :);
    diff_matrix   = abs(ind - idealp_matrix);
    obj           = max(diff_matrix ./ weight_matrix, [], 2);

end

% Penalty-based Boundary Intersection
function obj = pbi(weight, ind, idealpoint)
    % This function is written based on the equation provided by TEVC'07 paper.
    % However, its equation might be wrong.

    theta       = 5;
    indsize     = size(ind, 1);
    weight_size = size(weight, 1);
    
    if indsize == 1
        diff        = ind - idealpoint;
        diff_matrix = diff(ones(1, weight_size), :);
        temp1       = sum(weight .* diff_matrix, 2); 
        d1          = sqrt(temp1) ./ sqrt(sum(weight .* weight, 2));
        temp2       = ind(ones(1, weight_size), :) - idealpoint(ones(1, weight_size), :) - d1(:, ones(size(weight, 2), 1)) .* weight;
        d2          = sqrt(sum(temp2 .* temp2, 2));
    else
        diff_matrix = ind - idealpoint(ones(1, weight_size), :);
        temp1       = sum(weight .* diff_matrix, 2);
        d1          = sqrt(temp1) ./ sqrt(sum(weight .* weight, 2));
        temp2       = ind - idealpoint(ones(1, weight_size), :) - d1(:, ones(size(weight, 2), 1)) .* weight;
        d2          = sqrt(sum(temp2 .* temp2, 2));
    end
    obj = d1 + theta * d2;
    
end

% Penalty-based Boundary Intersection (normalized version)
function obj = n_pbi(weight, ind, idealpoint)
    % This function is written based on the equation provided by TEVC'07 paper.
    % However, its equation might be wrong.

    theta       = 5;
    indsize     = size(ind, 1);
    weight_size = size(weight, 1);

    normalized_weight = normr(weight);
    
    if indsize == 1
        diff        = ind - idealpoint;
        diff_matrix = diff(ones(1, weight_size), :);
        temp1       = sum(normalized_weight .* diff_matrix, 2); 
        d1          = sqrt(temp1);
        temp2       = ind(ones(1, weight_size), :) - idealpoint(ones(1, weight_size), :) - d1(:, ones(size(normalized_weight, 2), 1)) .* normalized_weight;
        d2          = sqrt(sum(temp2 .* temp2, 2));
    else
        diff_matrix = ind - idealpoint(ones(1, weight_size), :);
        temp1       = sum(normalized_weight .* diff_matrix, 2); 
        d1          = sqrt(temp1);
        temp2       = ind - idealpoint(ones(1, weight_size), :) - d1(:, ones(size(normalized_weight, 2), 1)) .* normalized_weight;
        d2          = sqrt(sum(temp2 .* temp2, 2));
    end
    obj = d1 + theta * d2;

end

% Tesing code for bip
function [obj, d2] = bip(weight, ind, idealpoint)
    % This function is based on the equation provided by myself.

    theta       = 5;
    ind_size    = size(ind, 1);
    weight_size = size(weight, 1);

    if ind_size == 1
        diff        = ind - idealpoint;
        diff_matrix = diff(ones(1, weight_size), :);
        temp1       = sum(weight .* diff_matrix, 2) ./ sum(weight .* weight, 2);
        temp1       = temp1(:, ones(1, size(weight, 2)));
        proj_matrix = temp1 .* weight;
        d1          = sqrt(sum(proj_matrix .* proj_matrix, 2));

        temp2       = ind(ones(1, weight_size), :) - idealpoint(ones(1, weight_size), :) - d1(:, ones(size(weight, 2), 1)) .* weight;
        d2          = sqrt(sum(temp2 .* temp2, 2));
    else
        diff_matrix = ind - idealpoint(ones(1, weight_size), :);
        temp1       = sum(weight .* diff_matrix, 2) ./ sum(weight .* weight, 2);
        temp1       = temp1(:, ones(1, size(weight, 2)));
        proj_matrix = temp1 .* weight;
        d1          = sqrt(sum(proj_matrix .* proj_matrix, 2));

        temp2       = ind - idealpoint(ones(1, weight_size), :) - d1(:, ones(size(weight, 2), 1)) .* weight;
        d2          = sqrt(sum(temp2 .* temp2, 2));
    end
    obj = d1 + theta * d2;

end

% Tesing code for bip (normalized weight matrix version)
function [obj, d2] = n_bip(weight, ind, idealpoint)
    % This function is based on the equation provided by myself.

    theta       = 5;
    ind_size    = size(ind, 1);
    weight_size = size(weight, 1);

    % Normalize the weight matrix
    normalized_weight = normr(weight);
    
    if ind_size == 1
        diff        = ind - idealpoint;
        diff_matrix = diff(ones(1, weight_size), :);
        temp1       = sum(weight .* diff_matrix, 2) ./ sum(weight .* weight, 2);
        temp1       = temp1(:, ones(1, size(weight, 2)));
        proj_matrix = temp1 .* weight;
        d1          = sqrt(sum(proj_matrix .* proj_matrix, 2));

        temp2       = ind(ones(1, weight_size), :) - idealpoint(ones(1, weight_size), :) - d1(:, ones(size(normalized_weight, 2), 1)) .* normalized_weight;
        d2          = sqrt(sum(temp2 .* temp2, 2));
    else
        diff_matrix = ind - idealpoint(ones(1, weight_size), :);
        temp1       = sum(weight .* diff_matrix, 2) ./ sum(weight .* weight, 2);
        temp1       = temp1(:, ones(1, size(weight, 2)));
        proj_matrix = temp1 .* weight;
        d1          = sqrt(sum(proj_matrix .* proj_matrix, 2));

        temp2       = ind - idealpoint(ones(1, weight_size), :) - d1(:, ones(size(normalized_weight, 2), 1)) .* normalized_weight;
        d2          = sqrt(sum(temp2 .* temp2, 2));
    end
    obj = d1 + theta * d2;
end

% Tesing code for bip (normalized weight matrix version)
function obj = n_bip2(weight, ind, idealpoint)
    % This function is based on the equation provided by myself.

    theta       = 5;
    ind_size    = size(ind, 1);
    weight_size = size(weight, 1);

    % Normalize the weight matrix
    normalized_weight = normr(weight);
    
    if ind_size == 1
        diff        = ind - idealpoint;
        diff_matrix = diff(ones(1, weight_size), :);
        temp1       = sum(normalized_weight .* diff_matrix, 2) ./ sum(normalized_weight .* normalized_weight, 2);
        temp1       = temp1(:, ones(1, size(weight, 2)));
        proj_matrix = temp1 .* normalized_weight;
        d1          = sqrt(sum(proj_matrix .* proj_matrix, 2));

        temp2       = ind(ones(1, weight_size), :) - idealpoint(ones(1, weight_size), :) - proj_matrix;
        d2          = sqrt(sum(temp2 .* temp2, 2));
    else
        diff_matrix = ind - idealpoint(ones(1, weight_size), :);
        temp1       = sum(normalized_weight .* diff_matrix, 2) ./ sum(normalized_weight .* normalized_weight, 2);
        temp1       = temp1(:, ones(1, size(weight, 2)));
        proj_matrix = temp1 .* normalized_weight;
        d1          = sqrt(sum(proj_matrix .* proj_matrix, 2));

        temp2       = ind(ones(1, weight_size), :) - idealpoint(ones(1, weight_size), :) - proj_matrix;
        d2          = sqrt(sum(temp2 .* temp2, 2));        
    end
    obj = d1 + theta * d2;

end

% Tesing code for bip (normalized weight matrix version)
function obj = n_bip3(weight, ind, idealpoint)
    % This function is based on the equation provided by myself.

    theta       = 5;
    ind_size    = size(ind, 1);
    weight_size = size(weight, 1);
    
    if ind_size == 1
        diff        = ind - idealpoint;
        diff_matrix = diff(ones(1, weight_size), :);
        temp1       = sum(weight .* diff_matrix, 2);
        temp1       = temp1(:, ones(1, size(weight, 2)));
        proj_matrix = temp1 .* weight;
        d1          = sqrt(sum(proj_matrix .* proj_matrix, 2));

        temp2       = ind(ones(1, weight_size), :) - idealpoint(ones(1, weight_size), :) - proj_matrix;
        d2          = sqrt(sum(temp2 .* temp2, 2));
    else
        diff_matrix = ind - idealpoint(ones(1, weight_size), :);
        temp1       = sum(weight .* diff_matrix, 2);
        temp1       = temp1(:, ones(1, size(weight, 2)));
        proj_matrix = temp1 .* weight;
        d1          = sqrt(sum(proj_matrix .* proj_matrix, 2));

        temp2       = ind(ones(1, weight_size), :) - idealpoint(ones(1, weight_size), :) - proj_matrix;
        d2          = sqrt(sum(temp2 .* temp2, 2));
    end
    obj = d1 + theta * d2;

end

% Penalty-based Normal Constraint
function [obj, d1] = nc(weight, ind, idealpoint, normal_direction)

    theta = 5;  % Penalty factor
    
    ind_size       = size(ind, 1);
    weight_size    = size(weight, 1);
    
    normal_direction = normal_direction';
    normal_matrix    = normal_direction(ones(1, weight_size), :);
    if ind_size == 1
        diff        = ind - idealpoint;
        diff_matrix = diff(ones(1, weight_size), :);
        temp1       = diff_matrix - weight;
        temp2       = normal_matrix .* temp1;
        proj_matrix = temp2(:, ones(size(weight, 2), 1)) .* normal_matrix;
        temp3       = temp1 - proj_matrix;
    else
        diff_matrix = ind - idealpoint(ones(1, weight_size), :);
        temp1       = diff_matrix - weight;
        temp2       = normal_matrix .* temp1;
        proj_matrix = temp2(:, ones(size(weight, 2), 1)) .* normal_matrix;
        temp3       = temp1 - proj_matrix;
    end

    d1 = sqrt(sum(proj_matrix .* proj_matrix, 2));
    d2 = sqrt(sum(temp3 .* temp3, 2));
    
    obj = d1 + theta * d2;

end