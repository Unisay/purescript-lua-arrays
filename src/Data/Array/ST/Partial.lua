return {peekImpl = (function(i, xs) return xs[i + 1] end), pokeImpl = (function(i, a, xs) xs[i + 1] = a end)}
