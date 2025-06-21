declare
Root = node(left:X1 right:X2 value:0)
X1 = node(left:X3 right:X4 value:1)
X2 = node(left:X5 right:X6 value:2)
X3 = node(left:nil right:nil value:3)
X4 = node(left:nil right:nil value:4)
X5 = node(left:nil right:nil value:5)
X6 = node(left:nil right:nil value:6)

{Show Root}

declare
proc {Preorder X}
   if X \= nil then
      {Show X.value}
      {Preorder X.left}
      {Preorder X.right}
   end
end

{Preorder Root}
