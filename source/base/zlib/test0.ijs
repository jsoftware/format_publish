NB. test0

cocurrent 'base'

zlibinit_ppubzlib_''
DAT=: fread jpath '~system/main/pack.ijs'
A=: compress_ppubzlib_ DAT
smoutput DAT -: uncompress_ppubzlib_ DAT
