declare E2 S2
fun {NewStack} nil end
fun {Push S E} E|S end
proc {Pop S ?E ?S1} S=E|S1 end

S={NewStack}
{Browse S}
S1={Push S pippo}
{Browse S1}
{Pop S1 E2 S2}
{Browse [E2 S2]}

declare S
fun lazy {Push S E} E|S end

{Browse {Push S pippo}.2.2}