NB. master.ijs
NB.
NB. This is an ordinary script file.
NB.
NB. Publish defines publishload as the same as load, except that it
NB. uses the master file directory, if no directory is given.
publishload 'plot.ijs'
publishload 'table.ijs'

NB. =========================================================
NB.*isotimestamp v format time stamps as:  2000-05-23 16:06:39.268
NB. y is one or more time stamps in 6!:0 format
isotimestamp=: 3 : 0
r=. }: $y
t=. _6 [\ , 6 {."1 y
d=. '--b::' 4 7 10 13 16 }"1 [ 4 3 3 3 3 3 ": <.t
d=. d ,. }."1 [ 0j3 ": ,. 1 | {:"1 t
c=. {: $d
d=. ,d
d=. '0' (I. d=' ')} d
d=. ' ' (I. d='b')} d
(r,c) $ d
)