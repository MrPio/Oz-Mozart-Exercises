% My solution. Easier to understand the solution validation part.○
declare
fun {MakePos MaxN N}c
    fun {Pos N} 
        if N==1 then 1
        else choice N [] {Pos N-1} end end 
    end
in
    if N=<0 then nil 
    else 
        Col={Pos MaxN}
        DiagLR=N+Col-1
        DiagRL=MaxN-N+Col+1
    in (Col#DiagLR#DiagRL)|{MakePos MaxN N-1} end
end
% Given the data structure C#D1#D2, C is the column, D1 is the left diagonal, and D2 is the right diagonal.
% A solution is valid if all columns, left diagonals, and right diagonals are unique.
fun {ValidateSol S Cs D1s D2s}
    case S of nil then true
    [] (C#D1#D2)|T then
        if {Member C Cs} orelse {Member D1 D1s} orelse {Member D2 D2s} then false
        else {ValidateSol T C|Cs D1|D1s D2|D2s} end
    end
end
fun {Queens N}
    Sol={MakePos N N} in
    if {Not {ValidateSol Sol nil nil nil}} then fail end
    {Map Sol fun {$ E} case E of C#D1#D2 then C end end}
end

% Professor's solution. Only valid for N=4.
declare
fun {Queens4}
    local
    fun {Pos} choice 1 [] 2 [] 3 [] 4 end end
        Sol=[{Pos} {Pos} {Pos} {Pos}]
    in
        if {Not {CheckCols Sol}} then fail end
        if {Not {CheckDiags Sol}} then fail end
        Sol
    end
end
fun {CheckCols L}
    case L of nil then true
    [] H|T then {Not {Member H T}} andthen {CheckCols T}
    end
end
fun {CheckDiags L}
    fun {CheckSingDiag Sl R}
        case Sl of _|nil then true
        [] H|H1|T then
            (H-R<1 orelse H1\=H-R) andthen
            (H+R>4 orelse H1\=H+R) andthen
            {CheckSingDiag H|T R+1}
        end
    end
in  
    case L of nil then true
    [] _|T then {CheckSingDiag L 1} andthen {CheckDiags T}
    end
end

N=4
Sols={Search.base.all proc {$ ?X} X={Queens N} end}
{Show Sols}
{Show {Length Sols}}