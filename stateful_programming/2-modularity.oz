declare
fun {MF}
    fun {F} 1 end
    fun {G} 2 end
in
 'export'(f:F g:G)
end

M={MF}
{Show M}