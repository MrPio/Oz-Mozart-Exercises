% Given a list of floats, return the mean value
% 
% Example:
%   [2.0 5.0] -> 3.5

declare
Numbers = [1.0 2.0 3.0 4.0]

% Without FoldL ===============================
fun {Average Ls}
    fun {CPair Ls} % Note: Implicit local
        case Ls of nil then 0.0#0.0
            [] X|Xs then 
                case {CPair Xs} of S#L then (S+X)#(L+1.0) end
        end
    end
    in
        case {CPair Ls} of S#L then S/L end
end
{Browse {Average Numbers}}
% OK

% Using FoldL =================================
fun {Average2 Ls}
    fun {F S#L H} (S+H)#(L+1.0) end
    in case {FoldL Ls F 0.0#0.0} of S#L then S/L end
end
{Browse {Average2 Numbers}}
% OK