% Implement the queue ADT using a stateful class
declare
    class Queue
    attr width:0 body tail
    meth init 
        X in body<-X tail<-X
    end
    meth enqueue(E) 
        width<-@width+1
        X in @tail=E|X tail<-X 
    end
    meth dequeue(?E)
        width<-@width-1
        case @body of H|T then body<-T E=H end
    end
    meth print() {Show @body} end
end

declare
Q={New Queue init}
{Q enqueue(1)}
{Q enqueue(2)}
{Q enqueue(3)}
{Q print}
E in {Q dequeue(E)} {Show E}
{Q print}
