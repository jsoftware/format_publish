NB. publish zlib
NB.
NB. note - this needs to use the zip addon

z2chr=: 2 & ic
z2num=: _2 & ic

Z_MEM_ERROR=: _4

NB. =========================================================
NB. returns success flag
zlibinit=: 3 : 0
if. IFUNIX do.
  p=. find_dll :: (''"_) 'z'
else.
  p=. 'zlib.dll'
  p=. (fexist p) # p
end.
res=. 0 < #p
if. res do.
  zcompress2=: (p,' compress2 i * *i * i i') & cd
  zuncompress=: (p,' uncompress i * *i * i') & cd
end.
res
)



