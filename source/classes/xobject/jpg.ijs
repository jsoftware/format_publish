NB. jpg

NB. =========================================================
readjpg=: 3 : 0
dat=. 1!:1 boxxopen y
assert. 255 216 255 224 -: a.i.4{.dat
dat
)

NB. =========================================================
readjpgshape=: 3 : 0
ff=. 255{a.
sf=. a. {~ 192 + (i.16) -. 4 8 12
dat=. 4 }. y
while. 1 do.
  ndx=. dat i. ff
  assert. ndx < _10 + #dat
  sel=. (ndx+1) { dat
  if. sel=ff do. dat=. }. dat continue. end.
  if. sel e. sf do. break. end.
  len=. 256 #. a.i.(ndx+2 3) { dat
  dat=. (ndx+len+2) }. dat
end.
256 #. a.i. _2 [\ 5 6 7 8 { dat
)
