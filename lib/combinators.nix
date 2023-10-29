# Self explanatory.
let id = x: x

# Just swap the arguments around.
; swap = f: a: b: f b a

# Composition combinator.
; comp = f: g: x: f ( g x )

# Call the function f with the argument v
; call = f: v: (f v)

# Apply one argument to a funcion.
; apply = swap call

# BlackBird combinator `f ( g x y )` eg compose f with g when g has two arguments.
; bb = comp comp comp

# Takes a list of arguments `vs` and successively apply them to the initial function`f`.
; apply_all = vs: f: __foldl' (call) f vs

# Takes a list of functions `vs` and successively apply them to the initial function`f`.
; call_all = bb __foldl' call

; in { inherit id call apply comp swap bb apply_all call_all; 
}
