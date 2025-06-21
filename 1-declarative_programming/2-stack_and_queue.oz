declare
% Stack ADT
% The stack (LIFO) can be easily implemented with a list
fun {NewStack} nil end
fun {Push S E} E|S end
proc {Pop S ?E ?S1} S=E|S1 end

% Queue ADT
% The queue is FIFO
% queue(NumElements Body Queue)
fun {NewQueue} X in queue(0 X X) end
fun {Insert queue(N S E1) E} 
    E2 in E1=E|E2 queue(N+1 S E2)
end
fun {Delete queue(N Hs|Ts E)} Hs#queue(N-1 Ts E) end
fun {IsEmpty queue(N _ _)} N==0 end


% queue(0 _ _)
% queue(1 [a _] _)
% queue(2 [a b _] _)
X={NewQueue}
{Show X}
X1={Insert X 1}
{Show X1}
X2={Insert X1 2}
{Show X2}
X3={Delete X2}
{Show X3}