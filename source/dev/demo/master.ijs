NB. master.ijs
NB.
NB. This is an ordinary script file.
NB.
NB. Publish defines publishload as the same as load, except that it
NB. uses the master file directory, if no directory is given.

NB. =========================================================
maketable=: 3 : 0
'rws cls style'=. y
dat=. ": each (style{100 10000)+1+i.rws,cls
ndx=. <?rws,cls
dat=. (<'<br/>second<br/>third',~ndx pick dat) ndx} dat
dat=. ;([: < LF , ;) "1 dat ,each ' '
r=. '<table><col>'
r=. r,}.;(' col',":) each 1+i.cls
r=. r,'</col><row>'
r=. r,}.;(' row',":) each 1+i.rws
r=. r,'</row><data>'
r=. r,,dat
r=. r,LF,'</data></table>'
)

NB. =========================================================
maketext=: 3 : 0
'par style'=. y
if. style=0 do.
  r=. 'The King and Queen of Hearts were seated on their throne when'
  r=. r,' they arrived, with a great crowd assembled about them -- all'
  r=. r,' sorts of little birds and beasts, as well as the whole pack of'
  r=. r,' cards: the Knave was standing before them, in chains, with a'
  r=. r,' soldier on each side to guard him; and near the King was the'
  r=. r,' White Rabbit, with a trumpet in one hand, and a scroll of'
  r=. r,' parchment in the other.'
else.
  r=. ' Alice had never been in a court of justice before, but she had'
  r=. r,' read about them in books, and she was quite pleased to find that'
  r=. r,' she knew the name of nearly everything there. That''s the judge,'
  r=. r,' she said to herself, because of his great wig.'
end.
r=. <r,LF,LF
_2 }. ;(('Par',":) each 1 + i.par) ,each r
)
