declare

fun {Take L N Start}
    case L of nil then nil
    [] H|T then if Start==0 then H|{Take L N-1 0} else {Take L N Start-1} end
end

proc {Sudoku Puzzle ?Sol}
    Sol={List.make 9}
    {List.forAll Sol proc {$ ?X} X={FD.list 9 1#9}end}
    
    % Row constraint
    for I in 1..9 do
        {FD.distinct {Nth Sol I}}
    end

    % Column constraint
    for I in 1..9 do
        Col={Map Sol fun {$ Row} {Nth Row I} end} in
        {FD.distinct Col}
    end

    % Block constraint
    for I in 0..2 do
        for J in 0..2 do
            Rows={Take Sol 3 I*3}
            Block={Map Rows fun {$ Row} {Take Row 3 J*3} end}
        in  {FD.distinct {List.flatten Block}}
        end
    end

    % Initial values contraint
    for I in 1..9 do
        for J in 1..9 do
            PuzzleItem={Nth {Nth Puzzle I} J}
            Var={Nth {Nth Sol I} J}
        in  if {Not {IsFree PuzzleItem}} then Var::PuzzleItem end
        end
    end

    {FD.distribute ff {List.flatten Grid}}
end

Puzzle=[
    [5 3 _ 8 _ _ _ 1 _]
    [_ _ _ 1 _ 5 _ _ _]
    [_ 9 8 _ _ _ _ 6 _]
    [8 _ _ _ 6 _ _ _ 3]
    [4 _ _ 5 _ 3 _ _ 1]
    [7 _ _ _ _ _ _ _ _]
    [_ 6 _ _ _ _ 2 8 _]
    [_ _ _ 4 _ 9 _ _ 5]
    [_ _ _ _ _ _ _ 7 9]
]
{Show {Search.base.all proc {$ ?X} {Sudoku Puzzle X} end}}