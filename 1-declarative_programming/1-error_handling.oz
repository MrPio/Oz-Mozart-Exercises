declare
fun {Eval E}
if {IsNumber E} then E
else
case E
of plus(X Y) 
then {Eval X}+{Eval Y}
[] times(X Y)
then {Eval X}*{Eval Y}
else raise illFormExpr(E) end
end
end
end

try
{Browse {Eval plus(5 6) }}
{Browse {Eval plus(times(5 5) 6) }}
{Browse {Eval plus(minus(5 5) 6) }}
catch illFormExpr(X) then
{Browse ’**** espressione errata ****’#X#’ ****’}
end