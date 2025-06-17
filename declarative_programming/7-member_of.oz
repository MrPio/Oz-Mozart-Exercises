% Determine whether an element E belongs to a list L
%
% Example:
% {MemberOf [1 a 4] b}=false

declare
L=[1 a 4]
E=a

fun {MemberOf L E}
    case L of nil then false
    [] H|T then E==H orelse {MemberOf T E}
    end
end

fun {MemberOfFoldL L E} 
    F=fun {$ S H} S orelse E==H end 
in
    {FoldL L F false}
end

{Show {MemberOf L E}}
{Show {MemberOfFoldL L E}}
% OK!