% Utilizzando tecniche di programmazione relazionale generare tutte le liste di lunghezza 4 i cui elementi siano atomi di valore a o b e che contengano un numero di a maggiore del numero di b ([a a a b] [b a a a] [a b a a] …).

declare
N=4
fun {Sol N}
    if N==0 then nil
    else (choice a [] b end) | {Sol N-1} end
end
fun {ValidSol S}
    C={Count S} in
    C.a>C.b
end
fun {Count L}?
    {FoldL L fun {$ S H} {AdjoinAt S H S.H+1} end c(a:0 b:0)}
end

{Show {Search.base.all 
proc {$ ?X} 
    X={Sol N} 
    if {Not {ValidSol X}} then fail end 
end
}}