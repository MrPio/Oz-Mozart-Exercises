% Codificare una funzione {RemK L K}, con L lista e K intero, che restituisca una lista contenente gli elementi che compaiono in L meno di K volte.
%  {RemK [1 3 3 6 3 3 10 10 1] 4} -> [1 6 10 10 1]

declare
fun {Counter L}
    local 
    fun {F S H}
        {AdjoinAt S H if {HasFeature S H} then S.H +1 else 1 end}
    end
    in
    {FoldL L F {MakeRecord d nil}}
    end
end
fun {RemK L K}
    local 
        fun {F L K Counts}
            case L of H|T then 
                if Counts.H<K then H|{F T K Counts} else {F T K Counts} end
                else nil
            end
        end
        C={Counter L}
    in
        {Show C}
        {F L K C}
    end
end
% OK!

L=[1 3 3 6 3 3 10 10 1]
{Show {RemK L 4}}