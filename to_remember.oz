for I in L..H do
    ...
end

for I in Xs do
    ...
end

{ForAll List Proc}

fun {Counter L}
    fun {F S H}
        {AdjoinAt S H if {HasFeature S H} then S.H +1 else 1 end}
    end
    in {FoldL L F {MakeRecord d nil}}
end