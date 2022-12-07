  %% Generate offspring population
        function Offspring = Variation(FunctionValue,Parent,nOffspring,operator,para)
        %Variation - Generate offspring population
        %
        %   O = obj.Variation(P) generates the offspring population by the
        %   default operator function obj.operator with parents P. And the
        %   number of evaluations obj.evaluated will be increased by
        %   length(O).
        %
        %   O = obj.Variation(P,N) returns only the first N offsprings at
        %   most.
        %
        %   O = obj.Variation(P,N,Fcn) generates the offspring population
        %   by the operator function Fcn.
        %
        %   O = obj.Variation(P,N,Fcn,Para) generates the offspring
        %   population by Fcn with the parameters specified by Para.
        %
        %   Example:
        %       Offspring = obj.Variation(Population)
        %       Offspring = obj.Variation(Population,1,@DE,{1,1,1,20})

            % Save the original parameters of the operator
            if nargin > 4
                field = func2str(operator);
                if isfield(FunctionValue.parameter,field)
                    oldPara = FunctionValue.parameter.(field);
                    specified                        = cellfun(@(S)~isempty(S),para);
                    FunctionValue.parameter.(field)(specified) = para(specified);
                else
                    oldPara = [];
                    FunctionValue.parameter.(field) = para;
                end
            end
            % Generate offsprings
            if nargin > 3
                Offspring = operator(FunctionValue,Parent);
            else
                Offspring = FunctionValue.operator(FunctionValue,Parent);
            end
            % Truncate the offsprings
            if nargin > 2
                FunctionValue.evaluated = FunctionValue.evaluated - max(0,length(Offspring)-nOffspring);
                Offspring     = Offspring(1:min(length(Offspring),nOffspring));
            end
            % Recover the original parameters of the operator
            if nargin > 4
                if ~isempty(oldPara)
                    FunctionValue.parameter.(field) = oldPara;
                else
                    FunctionValue.parameter = rmfield(FunctionValue.parameter,field);
                end
            end
        end