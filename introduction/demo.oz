declare X=r(a X) % Eager
{Browse X}

{Browse [X a]==[1 b]}

% 'Max' and 'C' cannot be Free, but must instead be Bound!
local Max C in % This makes it so that 'Max' and 'C' are not free, even though they're not bound
    proc {Max X Y ?Z}
        if X>Y then Z=X else Z=Y end
    end
    {Max 15 22 C}
    {Browse C}
end

% La 2nd local è necessaria per ricreare il legame dinamico ID-VAR
local X in
    X=1
    {Browse X}
    local X in
        X=2
        {Browse X}
    end
end

{Browse "Hello World"}
{Browse 'Hello World'}

local L1 in
    L1=[[1 2 3]]
    {Browse L1.1.2.1}
end