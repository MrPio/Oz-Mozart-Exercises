% Dato un albero binario T con nodi rappresentati come node(value:<val> left:<lt> right:<rt>) scrivere una funzione {Leaves T} che restituisca una lista contenente i valori delle foglie dell’albero (ovvero di tutti quei nodi che hanno sottoalberi sinistro e destro nulli) ordinate da sinistra a destra.

declare
fun {Leaves T}
    case T of nil then nil
    [] node(value:V left:nil right:nil) then [V]
    [] node(value:_ left:LT right:RT) then
        {Append {Leaves LT} {Leaves RT}}
    end
end
% OK!

T=node(value:0 left:node(value:~5 left:nil right:nil) right:node(value:3 left:node(value:2 left:nil right:nil) right:nil))
{Show {Leaves T}}