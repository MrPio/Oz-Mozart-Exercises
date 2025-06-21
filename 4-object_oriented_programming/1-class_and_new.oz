% Define the class and the new operator using HOP
declare

% Class definition
local
    proc {Init M S} init(Val)=M in (S.a):=Val end
    proc {MethA M S} meth_a(Val)=M in (S.a):=Val end
    proc {MethB _ S} {Show @(S.a)} end
    % ...
in
    ClassA=c(attrs:[a] meths:m(init:Init meth_a:MethA meth_b:MethB))
end

% Class instantiation
fun {New Cls InitMeth}
    local
        % State initialization
        Cells={Map Cls.attrs fun{$ Att} Att#{NewCell _} end}
        S={List.toRecord state Cells}

        proc {Obj M}
            {Cls.meths.{Label M} M S}
        end
    in
        {Obj InitMeth}
        Obj
    end
end

Obj={New ClassA init(5)}
{Obj meth_b()}
{Obj meth_a(17)}
{Obj meth_b()}