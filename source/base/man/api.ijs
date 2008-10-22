NB. api

NB. =========================================================
NB. file copy for snapshot
NB. y - source;destination
NB. returns success flag
snapfilecopy=: 3 : 0
'source dest'=. y
if. IFWIN32 do.
  0 pick 'kernel32 CopyFileA i *c *c i' cd source;dest;0
else.
  if. 0 = pathcreate fpath dest do. 0 return. end.
  if. _1 -: dat=. fread source do. 0 return. end.
  -. _1 -: dat fwrite dest
end.
)

