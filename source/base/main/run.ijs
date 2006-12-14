NB. run

NB. =========================================================
publish=: 3 : 0
locS=:  conew 'ppublish'
res=. publishrun__locS y
destroy__locS ''
res
)

NB. =========================================================
publishconfig=: 3 : 0
PDFCompress=: zlibinit_ppubzlib_''
)

NB. =========================================================
publishinit=: 3 : 0
rxinit''
setdefaults ''
Counth1=: 0
Contents=: i.0 3
MasterFile=: jhostpath y
if. -. fexist MasterFile do.
  info 'File not found: ',MasterFile
  0 return.
end.
MasterPath=: getpath MasterFile
OutputFile=: ((i:&'.'{.])MasterFile),'.pdf'

NB. ---------------------------------------------------------
NB. load ijs in base:
dat=. pread MasterPath,'master.ijs'
if. -. dat -: _1 do. jcmd dat end.

NB. ---------------------------------------------------------
NB. load sty in current locale
dat=. pread MasterPath,'master.sty'
if. -. dat -: _1 do. 0!:100 dat end.

NB. ---------------------------------------------------------
1
)

NB. =========================================================
publishfini=: 3 : 0
rxfree Rxhnd
)

NB. =========================================================
publishrun=: 3 : 0
locT=: ''
if. 0=publishinit y do. '' return. end.
txt=. readtext MasterFile
if. 0=#txt do.
  info 'No text in file: ',MasterFile
  0 return.
end.
colorinit''
pageinit''
txt=. fixedtext txt
'sec front'=. parsetext txt
FrontPage=: front
for_s. sec do.
  parsesec >s
end.
b=. build front
write b
view ''
publishfini''
)
