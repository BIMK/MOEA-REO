function [parent_pop, parent_objs] = selection(mixed_pop, mixed_objs, subproblems,idealpoint)
  
    size_objs   = size(mixed_objs, 1);
    size_subp   = size(subproblems, 1);
    sol_matrix  = zeros(size_objs, size_subp);
    subp_matrix = zeros(size_subp, size_objs);
   
    % Normalized the objective values of the mixed_pop into some limited range
    normalized_objs = normalization(mixed_objs, size_objs, idealpoint);
    
    % Calculate the subproblem matrix and solution matrix
    for i = 1 : size_objs
        fitness           = subobjective(subproblems, mixed_objs(i, :), idealpoint,'i_te' );% ,'i_te'
        sol_matrix(i, :)  = distance(normalized_objs(i, :), subproblems);
        subp_matrix(:, i) = fitness;
    end
    
    % Sort the value matrix to get the preference rank matrix
    [~, sol_matrix]  = sort(sol_matrix, 2);
    [~, subp_matrix] = sort(subp_matrix, 2);
        
    accept_flag      = zeros(1, size_subp);
    reject_times     = ones(1, size_subp);
    
    count            = 0;
    fixed_index      = 1 : 1 : size_subp;
    
    while count ~= size_subp
              
        matching            = subp_matrix(sub2ind(size(subp_matrix), fixed_index, reject_times));
        process_array       = zeros(1, size_subp);
        process_array_index = 1;
        
        for i = 1 : size_subp
           
            if sum(process_array == i) ~= 0
                continue; 
            else
                [~, temp_index] = find(matching == matching(i));
                if size(temp_index) == 1
                    process_array(process_array_index) = temp_index;
                    process_array_index                = process_array_index + 1;
                    accept_flag(temp_index)            = 1;
                else
                    process_array(process_array_index : process_array_index + length(temp_index) - 1)  = temp_index;
                    process_array_index                      = process_array_index + length(temp_index);
                    subp_current                             = sol_matrix(matching(i), :);
                    [~, subp_index, ~]                       = intersect(subp_current, temp_index);
                    optimal_index                            = min(subp_index);
                    accept_flag(temp_index)                  = 0;
                    accept_flag(subp_current(optimal_index)) = 1;
                end
            end
            
        end
     
        count        = sum(accept_flag == 1);
        reject_times = reject_times + (accept_flag == 0);
               
    end
    
    matching    = subp_matrix(sub2ind(size(subp_matrix), fixed_index, reject_times));
    parent_pop  = mixed_pop(matching, :);
    parent_objs = mixed_objs(matching, :);
    
end