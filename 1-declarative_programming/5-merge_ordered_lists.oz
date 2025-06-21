% Given two ordered lists of numbers, merge them so that the resulting list is still ordered.
% 
% Example:
%   {OrdMerge [1 3 4] [2 3 9 11]} = [1 2 3 3 4 9 11]

declare
L1=[1 3 44]
L2=[2 3 9 11]

% Attempt 1 =====================================
fun {OrdMerge H1|T1 H2|T2}
    if H1<H2 then 
        if T1==nil then H1|H2|T2 % H1 is the last element of L1
        else H1|{OrdMerge T1 H2|T2} end
    else 
        if T2==nil then H2|H1|T1 % H2 is the last element of L2
        else H2|{OrdMerge H1|T1 T2} end
    end
end

{Show {OrdMerge L1 L2}}
% OK, but it doesn't work if I pass an empty list as one of the two parameters.

% Attempt 2 =====================================
fun {OrdMerge2 L1 L2}
    case L1#L2
        of nil#_ then L2
        [] _#nil then L1
        else 
            L1=H1|T1
            L2=H2|T2
        in 
            if H1<H2 then H1|{OrdMerge T1 L2}
            else H2|{OrdMerge L1 T2} end
    end
end
{Show {OrdMerge2 L1 L2}}
% OK!