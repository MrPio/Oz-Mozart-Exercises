declare
local
    fun {StackObject S}
        fun {Push X} {StackObject X|S} end
        fun {Pop ?E} case S of X|S1 then E=X {StackObject S1} end end
        fun {IsEmpty} S==nil end
    in stack(push:Push pop:Pop isEmpty:IsEmpty) end
in
    fun {NewStack} {StackObject nil} end
end

declare
fun {StackObject2 S}
    fun {Push X} {StackObject2 X|S} end
    fun {Pop ?E} case S of X|S1 then E=X {StackObject2 S1} end end
    fun {IsEmpty} S==nil end
in stack(push:Push pop:Pop isEmpty:IsEmpty) end

local S1 S2 E in
    S1={NewStack}
    S2={S1.push init}
    _={S2.pop E} {Show E}
end

local S1 S2 E in
    S1={StackObject2 nil}
    S2={S1.push init}
    _={S2.pop E} {Show E}
end