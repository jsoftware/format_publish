NB. zlib compress
NB.
NB. default compress uses fastest method (level 1)
NB.  - much less time
NB.  - little additional space

NB. =========================================================
NB. ZMINSIZE is the minimum string length to be compressed
NB. for count compression
ZMINSIZE=: 512

NB. =========================================================
NB. compress
NB.
NB. level compress data
compress=: 3 : 0
1 compress y
:
dat=. y
len=. >. 1.01 * 12 + #dat
'rc res wid j j j'=. zcompress2 ((len$' ');,len),y;(#y);x
if. rc do.
  dat
else.
  dat=. wid {. res
end.
)

NB. =========================================================
NB. compress with count
compress_count=: 3 : 0
1 compress_count y
:
dat=. y
cnt=. #dat
if. cnt >: ZMINSIZE do.
  len=. >. 1.01 * 12 + cnt
  'rc res wid j j j'=. zcompress2 ((len$' ');,len),y;(#y);x
  if. rc do.
    throw 3002;'Compress error: ',":rc
  else.
    dat=. wid {. res
  end.
end.
(z2chr cnt), dat
)

NB. =========================================================
NB. uncompress
uncompress=: 3 : 0
dat=. y
cnt=. ZMINSIZE >. 10 * #dat
while. 1 do.
  'rc res wid j j'=. zuncompress ((cnt$' ');,cnt),dat;#dat
  if. rc = Z_MEM_ERROR do.
    cnt=. cnt * 1.1
  elseif. rc do.
    throw 3002;'Uncompress error: ',":rc
  elseif. do.
    res return.
  end.
end.
)

NB. =========================================================
NB. uncompress with count
uncompress_count=: 3 : 0
cnt=. z2num 4 {. y
dat=. 4 }. y
if. cnt >: ZMINSIZE do.
  'rc res wid j j'=. zuncompress ((cnt$' ');,cnt),dat;#dat
  if. rc do.
    throw 3002;'Uncompress error: ',":rc
  else.
    res
  end.
end.
)

