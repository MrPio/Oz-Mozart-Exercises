% Define a Ordered Binary (Unbalanced) tree.
% S, C -> OBTree>::=leaf|tree(<OValue> <Value> <Tree1> <Tree2>)
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
    [] lead then nil
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