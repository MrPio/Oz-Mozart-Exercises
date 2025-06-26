% Data-driven (Eager) ============================
declare DelayAmount=100
fun {Produce N Limit}
    {Delay DelayAmount}
    if N<Limit then N|{Produce N+1 Limit}
    else nil end
end
fun {Consume Xs Acc}
    case Xs of H|T then {Consume T H+Acc} 
    [] nil then Acc end
end
% OK!

declare Stream Result 
thread Stream={Produce 1 10} end
thread Result={Consume Stream 0} end
{Browse Result}

% Demand driven (Lazy) ============================
declare
proc {Produce N Xs}
    {Delay DelayAmount}
    case Xs of H|T then H=N {Produce N+1 T}
    [] nil then skip end
end
fun {Consume ?Xs Acc Limit}
    if Limit=<1 then Xs=nil Acc
    else H T in Xs=H|T {Consume T H+Acc Limit-1} end
end
% OK!

declare Stream Result Xs
thread {Produce 1 Xs} end
thread Result={Consume Xs 0 10} end
{Browse Result}

% Lazy Evaluation (Lazy) ============================
declare
fun lazy {Produce N}
    {Delay DelayAmount}
    N|{Produce N+1}
end
fun {Consume Xs Acc Limit}
    if Limit=<1 then Acc
    else H T in Xs=H|T {Consume T Acc + H Limit-1} end
end
% OK!

declare Result Xs
Xs={Produce 1}
thread Result={Consume Xs 0 10} end
{Browse Result}

% Demand driven Buffered (Lazy) ============================
declare
proc {Produce N Xs} 
    {Delay DelayAmount} 
    case Xs of H|T then H=N {Produce N+1 T} end
end
proc {Buffer N Xs Ys}
    fun {Init N ?Xs}
        if N==0 then Xs
        else Xs2 in Xs=_|Xs2 {Init N-1 Xs2} end
    end
    proc {AddSlot Xs Ys Xend}
        case Ys of H|T then 
            Xs2 Xend2 in
            Xs=H|Xs2 Xend=_|Xend2 {AddSlot Xs2 T Xend2} end
    end
    Xend={Init N Xs}
in  {AddSlot Xs Ys Xend}
end
% ⚠️ Uno stream vuole l'assenza di "nil" ma una coda unbound. Se fai {List.make N} hai nil.
fun {Consume Ys Limit Acc}
    if Limit==0 then Acc
    else H T in Ys=H|T {Consume T Limit-1 Acc+H} end
end
% OK!!

declare Xs Ys Result
thread {Produce 1 Xs} end
thread {Buffer 5 Xs Ys} end
thread Result={Consume Ys 10 0} end
{Browse Result}
