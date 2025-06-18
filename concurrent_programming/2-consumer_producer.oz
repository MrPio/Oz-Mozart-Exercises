% Data-driven
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

% Demand driven ============================
declare
proc {Produce N Xs}
    {Delay DelayAmount}
    case Xs of H|T then H=N {Produce N+1 T}
    [] nil then skip end
end
fun {Consume ?Xs Acc Limit}
    if Limit>1 then
        H T in Xs=H|T {Consume T H+Acc Limit-1}
    else Xs=nil Acc end
end
% OK!

declare Stream Result Xs
thread {Produce 1 Xs} end
thread Result={Consume Xs 0 10} end
{Browse Result}

% Lazy Evaluation ==============
declare
fun lazy {Produce N}
    {Delay 100}
    N|{Produce N+1}
end
fun {Consume Xs Acc Limit}
    if Limit=<1 then Acc
    else H T in Xs=H|T {Consume T Acc + H Limit-1}
    end
end

declare Result Xs
Xs= {Produce 1}
thread Result={Consume Xs 0 10} end
{Browse Result}