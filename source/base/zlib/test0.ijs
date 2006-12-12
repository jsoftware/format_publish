NB. test0

cocurrent 'base'

a=. jpath '~home\zlib.dll'
b=. jpath '~addons\zip\lib\zlibapi.so'
b=. '/usr/lib/libz.so.1'
ZLIBDLL_pzlib_=: IFUNIX pick a;b

zlibinit_pzlib_''
old=: fread jpath '~system\main\trig.ijs'
cmp=: compress_pzlib_ old
new=: uncompress_pzlib_ cmp
smoutput old -: ($old) {. new

