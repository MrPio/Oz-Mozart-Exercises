declare
fun {Init N ?Xs}
  if N==0 then Xs
  else Xs2 in Xs=_|Xs2 {Init N-1 Xs2} end
end

Xs End in
  End={Init 3 Xs}
  {Show Xs#End}