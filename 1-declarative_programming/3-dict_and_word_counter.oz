% Given a list of atoms, return a dict of atom frequencies.
% 
% Example:
%   {CountWords [a a b a c c]} = d(a:3 b:1 c:2)

declare
Words=[apple orange apple banana apple banana 2 true]

fun{DictMember D F} {HasFeature D F} end
fun{DictAccess D F} {CondSelect D F err} end
fun{DictAdJoin D F X} {AdjoinAt D F X} end
fun{EmptyDict} {MakeRecord d nil} end

% Without FoldL ===============================
fun {CountWords L Acc}
    case L 
    of nil then Acc
    [] H|T then 
        {CountWords T {DictAdJoin Acc H if {DictMember Acc H} then {DictAccess Acc H}+1 else 1 end}}
    end
end

{Browse {CountWords Words {EmptyDict}}}
% OK!

% Using FoldL =================================
% L - The list to fold
% F - The function to be applied to each element
% S - The partial result updated at each step
fun {FoldL L F S}
    case L of nil then S
    [] H|T then {FoldL T F {F S H}}
    end
end

fun {CountWords2 L}
    local fun {F S H}
            {DictAdJoin S H if {DictMember S H} then {DictAccess S H}+1 else 1 end}
        end
    in
        {FoldL L F {EmptyDict}}
    end
end
{Browse {CountWords2 Words}}
% OK!