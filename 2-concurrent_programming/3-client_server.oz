% Peer2Peer
declare
fun {NewAgent P}
    Port Stream
in
    Port={NewPort Stream}
    thread {ForAll Stream P} end
    Port
end

fun {NewPlayer Me Others}
    {NewAgent 
    proc{$ ball}
        Rand 
    in  Rand={OS.rand} mod {Width Others}+1
        {Show Me#' got the ball!'}
        {Delay 1}
        {Send Others.Rand ball}
    end}
end

declare P1 P2 P3
P1={NewPlayer 1 others(P2 P3)}
P2={NewPlayer 2 others(P3 P1)}
P3={NewPlayer 3 others(P1 P2)}

{Send P1 ball}
{Show 'Starting game...'}