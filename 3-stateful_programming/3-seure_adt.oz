% Open - Stateless - Unbundled ====================================
declare NewStack Push Pop IsEmpty
fun {NewStack} nil end
fun {Push S E} E|S end
fun {Pop S ?E} case S of H|T then E=H T end end
fun {IsEmpty S} S==nil end

local S1 S2 E in
    S1={NewStack}
    S2={Push S1 a}
    _={Pop S2 E} 
    {Show S2#E}
end


% Secure - Stateless - Unbundled ==================================
proc {Wrapper ?Wrap ?Unwrap}
    Key={NewName}
in
    fun {Wrap X}
        fun{$ K} if K==Key then X else raise notAllowed end end end
    end
    fun {Unwrap W} {W Key} end
end

declare NewStack Push Pop IsEmpty
local
    Wrap Unwrap
    {Wrapper Wrap Unwrap}
in
    fun {NewStack} {Wrap nil} end
    fun {Push S E} {Wrap E|{Unwrap S}} end
    fun {Pop S ?E} case {Unwrap S} of H|T then E=H {Wrap T} end end
    fun {IsEmpty S} {Unwrap S}==nil end
end

local S1 S2 E in
    S1={NewStack}
    S2={Push S1 a}
    _={Pop S2 E} 
    {Show S2#E}
end


% Secure - Stateless - Bundled ==================================
declare NewStack Push Pop IsEmpty
local StackObj
    fun {StackObj S}
        local
            fun {Push E} {StackObj E|S} end
            fun {Pop ?E} case S of H|T then E=H {StackObj T} end end
            fun {IsEmpty} S==nil end
        in stack(isEmpty:IsEmpty push:Push pop:Pop) end
    end
in
    fun {NewStack} {StackObj nil} end % Factory method
end

local S1 S2 E in
    S1={NewStack}
    S2={S1.push a}
    _={S2.pop E} 
    {Show S2#E}
end


% Secure - Stateful - Unbundled ==================================
% ⛔⛔⛔ Wrap the cell, not the content of the cell ⛔⛔⛔
declare NewStack Push Pop IsEmpty
local
    Wrap Unwrap
    {Wrapper Wrap Unwrap}
in
    fun {NewStack} {Wrap {NewCell nil}} end
    proc {Push S E} C={Unwrap S} in C:=E|@C end
    proc {Pop S ?E} C={Unwrap S} in case @C of H|T then E=H C:=T end end
    fun {IsEmpty S} @{Unwrap S}==nil end
end

local S E in
    S={NewStack}
    {Push S a}
    {Pop S E} 
    {Show S#E}
end


% Secure - Stateful - Bundled ==================================
declare NewStack Push Pop IsEmpty
fun {StackObj}
    local
        S={NewCell nil}
        proc {Push E} S:=E|@S end
        proc {Pop ?E} case @S of H|T then E=H S:=T end end
        fun {IsEmpty} @S==nil end
    in stack(isEmpty:IsEmpty push:Push pop:Pop) end
end

local S E in
    S={StackObj}
    {S.push a}
    {S.pop E} 
    {Show S#E}
end