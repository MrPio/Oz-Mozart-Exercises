declare
proc {Rectangle ?Sol}
    [X Y] = Sol
in
    X::1#999 Y::1#999 % Basic Constraints
    X+Y=:10 X*Y=:24 X=<:Y % Propagator
    {FD.distribute ff Sol}
end

{Show {Search.base.all Rectangle}}
% [[4 6]]