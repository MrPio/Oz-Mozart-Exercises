declare
class LinkedList
    attr val next
    meth init(Val<=none Next<=none)
        val<-Val next<-Next
    end
    meth add(E)
        next:= {New LinkedList init(E @next)}
    end
    meth display
        {Show @val}
        if @next\=none then
            {@next display}
        end
    end
end

L1={New LinkedList init(1)}
{L1 add(2)} {L1 add(3)} {L1 display}