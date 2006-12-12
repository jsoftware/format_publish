NB. zlib api
NB. 
NB. requires global ZLIBDLL

z2chr=: 2 & ic
z2num=: _2 & ic

Z_MEM_ERROR=: _4

NB. =========================================================
makezlib=: 1 : 0
if. '"' ~: {. ZLIBDLL do.
  dll=. '"',ZLIBDLL,'"'
else.
  dll=. ZLIBDLL
end.
(dll,' ',x) & cd
)

NB. =========================================================
zlibinit=: 3 : 0
zcompress2=: 'compress2 i * *i * i i' makezlib
zuncompress=: 'uncompress i * *i * i' makezlib
i.0 0
)
