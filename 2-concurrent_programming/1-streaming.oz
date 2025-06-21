declare
fun {Double Xs}
    case Xs of nil then nil
    [] X|Xr then 
        {Show 2*X}
        2*X|{Double Xr}
    end
end

declare X Y X1 X2
Y={Double X}
{Show Y}

% Feed Line
X=1|2|X1

% Feed Line
X1=3|4|5|X2

% Feed Line
X2=nil