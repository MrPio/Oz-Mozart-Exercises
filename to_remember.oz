for I in L..H do
    ...
end

for I in Xs do
    ...
end

{ForAll List Proc}


% Using FoldL =================================
% L - The list to fold
% F - The function to be applied to each element
% S - The partial result updated at each step
fun {FoldL L F S}
    case L of nil then S
    [] H|T then {FoldL T F {F S H}}
    end
end

fun {Counter L}
    fun {F S H}
        {AdjoinAt S H if {HasFeature S H} then S.H +1 else 1 end}
    end
    in {FoldL L F {MakeRecord d nil}}
end