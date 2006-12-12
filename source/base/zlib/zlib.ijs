NB. built from project: ~Core\other\zlib\zlib
NB. zlib api
NB. 
NB. requires global ZLIBDLL

coclass 'pzlib'


z2chr=: 2 & ic
z2num=: _2 & ic

NB. =========================================================
makezlib=: 1 : 0
if. '"' ~: {. ZLIBDLL do.
  dll=. '"',ZLIBDLL,'"'
else.
  dll=. ZLIBDLL
end.
(dll,' ',x.) & cd
)

NB. =========================================================
zlibinit=: 3 : 0
zcompress2=: 'compress2 i * *i * i i' makezlib
zuncompress=: 'uncompress i * *i * i' makezlib
i.0 0
)

NB. zlib compress
NB.
NB. compress always uses fastest method (level 1)
NB.  - much less time
NB.  - little additional space

NB. =========================================================
NB. ZMINSIZE is the minimum string length to be compressed
NB. for count compression
ZMINSIZE=: 512

NB. =========================================================
NB. compress
compress=: 3 : 0
dat=. y.
len=. >. 1.01 * 12 + #dat
'rc res wid j j j'=. zcompress2 ((len$' ');,len),y.;(#y.);1
if. rc do.
  dat
else.
  dat=. wid {. res
end.
)

NB. =========================================================
NB. compress with count
compress_count=: 3 : 0
dat=. y.
cnt=. #dat
if. cnt >: ZMINSIZE do.
  len=. >. 1.01 * 12 + cnt
  'rc res wid j j j'=. zcompress2 ((len$' ');,len),y.;(#y.);1
  if. rc do.
    throw 3002;'Compress error: ',":rc
  else.
    dat=. wid {. res
  end.
end.
(z2chr cnt), dat
)

NB. =========================================================
NB. uncompress with count
uncompress_count=: 3 : 0
cnt=. z2num 4 {. y.
dat=. 4 }. y.
if. cnt >: ZMINSIZE do.
  'rc res wid j j'=. zuncompress ((cnt$' ');,cnt),dat;#dat
  if. rc do.
    throw 3002;'Uncompress error: ',":rc
  else.
    res
  end.
end.
)

