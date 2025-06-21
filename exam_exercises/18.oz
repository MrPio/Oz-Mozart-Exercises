% Codificare una classe Tree, che rappresenta un albero binario. La classe possiede tre attributi value, left e right. left e right sono valorizzati con istanze della classe Tree, mentre value è il valore contenuto nella radice dell’albero. Implementare i seguenti metodi della classe: 
% • init(Value), che assega alla radice dell’albero il valore Value, e definisce come vuoti i sottoalberi destro e sinistro;
% • setLeft(LT) e setRight(RT) che assegnano, rispettivamente, il sottoalbero sinistro e destro alla radice;
% • nodes(L) che restituisce in L la lista dei valori contenuti nell’albero

declare
class Tree
    attr value left right
    meth init(Value) value<-Value left<-leaf right<-leaf end
    meth setLeft(T) left<-T end
    meth setRight(T) right<-T end
    meth nodes(?L)
        LL LR in
            if @left==leaf then LL=nil else {@left nodes(LL)} end
            if @right==leaf then LR=nil else {@right nodes(LR)} end
            {Append LL @value|LR L}
    end
end
% OK!

T={New Tree init(1)}
{T setLeft({New Tree init(~5)})}
T1={New Tree init(3)}
{T1 setLeft({New Tree init(2)})}
{T setRight(T1)}
declare L
{T nodes(L)}
{Show L}