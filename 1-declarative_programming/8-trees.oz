% Define a Ordered Binary (Unbalanced) tree.
% S, C -> <OBTree>::=leaf|tree(<OValue> <Value> <Tree1> <Tree2>)
% F -> Lookup/3, Insert/4, Delete/3
declare
fun {NewTree} leaf end

% <OValue> x <Tree> -> notfound|found(<Value>)
fun {Lookup K T}
    case T of leaf then notfound
    [] tree(Key Value Tl Tr) then 
        if K==Key then found(Value)
        elseif K<Key then {Lookup Key Tl}
        else {Lookup Key Tr} end
    end
end
% OK!

% <OValue> x <Value> x <Tree> -> <Tree>
fun {Insert K V T}
    case T of leaf then tree(K V leaf leaf)
    [] tree(Key Value Tl Tr) then
        if K==Key then tree(K V Tl Tr)
        elseif K<Key then tree(Key Value {Insert K V Tl} Tr)
        else tree(Key Value Tl {Insert K V Tr}) end
    end
end
% OK!

% <OValue> x <Tree> -> <Tree>
fun {Delete K T}
    case T of leaf then leaf
    [] tree(Key Value Tl Tr) then
        if Key==K then % The root has to be removed
            if Tl==leaf then Tr
            elseif Tr==leaf then Tl
            else 
                Key2 Value2 = {Smallest Tr} in
                tree(Key2 Value2 Tl {Delete Key2 Tr})
            end
        elseif K<Key then tree(Key Value {Delete K Tl} Tr) % Look on left
        elseif K>Key then tree(Key Value Tl {Delete K Tr}) % Look on right
        end
    end
end
% <Tree> -> <OValue>#<Value>|nil
fun {Smallest T}
    case T of tree(K V leaf Tr) then K#V
    [] leaf then nil
    [] tree(_ _ Tl _) then {Smallest Tl} end
end
% OK! The only difference with teacher's is when Key==K and Tl==leaf. This returns Tr, while the teacher's moves the smallest of Tr to the root and sets the new right subtree as Tr removed from the smallest. I think my is better because it's symmetric between Tl==leaf and Tr==leaf, so it doesn't harm the balance of the tree.
%    (K)    
%   /   \   
% ( )  (Tr)

T={NewTree}
T1={Insert 1 a T}
T2={Insert 3 c T1}
T3={Insert 2 b T2}
T4={Insert 17 d T3}
T5={Insert ~5 a T4}
{Show T5}
{Show {Delete 2 T5}}
{Show {Delete 17 T5}}
{Show {Delete ~5 T5}}

% <Tree> -> <List<OValue#Value>>
% Using inorder DFS navigation
fun {DFS T}
    case T of leaf then nil
    [] tree(K V Tl Tr) then
        {Append {DFS Tl} K#V|{DFS Tr}}
    end
end
% OK!

{Show 'DFS='#{DFS T5}}

% from 2-stack_and_queue.oz
declare
fun {NewQueue} X in q(0 X X) end
fun {Enqueue q(N S E1) E} E2 in E1=E|E2 q(N+1 S E2) end
fun {Dequeue q(N Hs|Ts E)} Hs#q(N-1 Ts E) end
fun {IsEmpty q(N _ _)} N==0 end

% <Tree> -> <List<OValue#Value>>
% Using BFS navigation
fun {BFS Q Acc}
    if {IsEmpty Q} then Acc
    else
        T Q1 in T#Q1={Dequeue Q}
        case T of leaf then 
            {BFS Q1 Acc}
        [] tree(K V Tl Tr) then 
            {BFS {Enqueue {Enqueue Q1 Tl} Tr} {Enqueue Acc K#V}} 
        end
    end
end
% OK!

{Show 'BFS='#{BFS {Enqueue {NewQueue} T5} {NewQueue}}}