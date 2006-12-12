NB. plot init
NB.
NB. Data   data
NB. Shape  shape

Data=: ''
Shape=: ''

NB. =========================================================
create=: 3 : 0
coinsert locP=: COCREATOR
NAME=: 'Pl',":#Plots
Plots__locRW=: Plots,coname''
)

NB. =========================================================
add=: 3 : 0
dat=. 1!:1 :: _1: <filename y
assert. -. dat -: _1
ndx=. dat i. LF
hdr=. ndx {. dat
dat=. (ndx+1) }. dat
hdr=. <;._2 hdr
Shape=: |. 0 ". 0 pick hdr
fnt=. <;._2 [ 1 pick hdr
rep=. i. 0 2
for_f. fnt do.
  x=. fontffi > f
  n=. f_index + 1
  if. x ~: n do.
    rep=. rep,('BT /F',(":n),' ');'BT /F',(":x),' '
  end.
end.
if. rep do.
  dat=. dat rplc rep
end.
Data=: dat
)

NB. =========================================================
draw=: 3 : 'Data'

