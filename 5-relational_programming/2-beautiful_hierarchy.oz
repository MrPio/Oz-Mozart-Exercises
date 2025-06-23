declare
% Axioms
proc {Parent P C}
    choice P=eric C=angela
    [] P=eric C=felicia
    [] P=eric C=kristen
    [] P=eric C=thorne
    [] P=eric C=eric_jr
    [] P=stephanie C=angela
    [] P=stephanie C=felicia
    [] P=stephanie C=kristen
    % ...
    end
end
proc {Husband H W}
    choice H=eric W=stephanie
    [] H=eric W=brooke
    [] H=eric W=sheila
    [] H=eric W=donna
    [] H=massimo W=stephanie
    [] H=massimo W=jacqueline
    [] H=james W=sheila
    [] H=thorne W=brooke
    % ...
    end
end

% Predicates
proc {Spouse X Y}
    choice {Husband X Y} [] {Husband Y X} end
end
proc {Nephew X Y}
    choice Z in {Parent Z X} {Parent Y Z} end
end
fun {Unique L}
    case L of nil then nil
    [] H|T then if {Member H T} then {Unique T} else H|{Unique T} end
    end
end
fun {Unique2 L}
    {FoldL L fun{$ S H} if {Member H S} then S else H|S end end nil}
end

X = {Unique2 {Search.base.all proc {$ ?X} N G in {Nephew N G} X=N#G end}}

proc {StepChildren X Y}
    choice Z in 
        {Parent Y Z}
        {Spouse Z Y}
        {NotP proc{$ _} {Parent Y X} end}
    end
end

proc {NotP P}
    {Search.base.one proc {$ ?X} {P} X=unit end}=nil % 👈🏻 ✅
end
% Predicates are procedures.