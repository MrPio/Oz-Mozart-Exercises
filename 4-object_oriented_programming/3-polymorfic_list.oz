% Define a polimorfic list using three classes:
% AbsList and two concretes, namely NilList and ConsList
declare
class AbsList
    meth isNil(_) raise undefinedMethod end end
    meth append(_ _) raise undefinedMethod end end
    meth display raise undefinedMethod end end
end

class NilList from AbsList
    meth init skip end
    meth isNil(B) B=true end
    meth append(Oth ?L) L=Oth end
    meth display {Show nil} end
end

class ConsList from AbsList
    attr val next
    meth init(Val Next)
        val<-Val next<-Next
    end
    meth isNil(B) B=false end
    meth append(Oth ?L)
        L1 in {@next append(Oth L1)}
        {New ConsList init(@val L1)}
    end
    meth display
        {Show @val}
        {@next display}
    end
end

L1={New ConsList init(1 {New ConsList init(2 {New NilList init})})}
{L1 display}

L2={New ConsList init(3 {New NilList init})}
{L2 display}

L3 in {L1 append(L2 L3)} {L3 display}
