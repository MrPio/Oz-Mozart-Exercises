% Take the first N elements of a given list L.
%
% Example:
%   {Take [1 2 3 4] 2} = [1 2]

declare
L=[1 2 3 4]
N=2

fun {Take L N}
    if N=<0 then nil
    else 
        case L of nil then nil
        [] H|T then H|{Take T N-1} end
    end
end
fun {TakeTailRec L N Acc}
    if N=<0 then {Reverse Acc}
    else 
        case L of nil then {Reverse Acc}
        [] H|T then {TakeTailRec T N-1 H|Acc} end
    end
end
{Show {TakeTailRec L N nil}}
% OK!

% Drop the first N elements of a given list L.
%
% Example:
%   {Drop [1 2 3 4] 2} = [3 4]

fun {Drop L N}
    if N=<0 then L
    else 
        case L of nil then nil
        [] _|T then {Drop T N-1} end
    end
end
{Show {Drop L N}}
% OK!