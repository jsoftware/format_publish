NB. tab utilities

BPREFIX=: 'tsjw'
BFILES=: ;: 'TEXTFILES STYLEFILES SCRIPTFILES OTHERFILES'
BEXTS=: '.txt';'.sty';'.ijs';''
BLABELS=: ;: 'Text Style Script All'

BTYPES=: <;._2 (0 : 0)
Text Files(*.txt)|*.txt
Style Files(*.sty)|*.sty
Script Files(*.ijs)|*.ijs
All Files(*.*)|*.*
)

NB. =========================================================
tab_add_button=: 3 : 0
if. 0=#PUBFILE do. infonopub'' return. end.

NB. ---------------------------------------------------------
p=. jhostpath }:PUBPATH
typ=. dquote TABNDX pick BTYPES
lab=. TABNDX pick BLABELS
ext=. TABNDX pick BEXTS
fls=. TABNDX pick BFILES

while. 1 do.
  j=. typ,' ofn_nochangedir'
  f=. wd 'mbsave "New ',lab,' File" "',p,'" "" ',j
  if. ''-:f do. return. end.
  if. TABNDX<3 do.
    f=. ext addext f
    if. ext -: _4 {.f do. break. end.
    info lab,' filename extension should be ',ext
  end.
end.

NB. ---------------------------------------------------------
f=. filecase f
path=. 0 pick pathfile jpathsep f

if. path -: PUBPATH do.
  if. fexist f do.
    info 'already in pubman: ',pubshortname f return.
  end.
  '' fwritesnew f
else.
  if. -. fexist f do.
    '' fwritesnew f
  end.
end.

(fls)=: sortfiles (fls~),<jpathsep f
tab_show''
)

NB. =========================================================
tab_button=: 3 : 0
TABNDX=: y
tab_refresh''
)

NB. =========================================================
tab_delete_button=: 3 : 0
if. 0= #files=. tab_selected '' do. return. end.
ff=. tolist pubshortname files
if. 1=2 query 'OK to delete:',LF,LF,ff do. return. end.
fls=. TABNDX pick BFILES
for_f. files do.
  f=. >f
  if. PUBPATH -: 0 pick pathfile jpathsep f do.
    ferase jhostpath f
  else.
    (fls)=: fls~ -. <jpathsep f
  end.
end.
tab_refresh''
)

NB. =========================================================
tab_open=: 3 : 'tab_open1 tab_selected 0'
tab_openall=: 3 : 'tab_open1 ". TABNDX pick BFILES'

NB. =========================================================
tab_open1=: 3 : 0
fls=. y
if. 0 = #fls do. return. end.
ext=. (fls i: &> '.') }. each fls
msk=. ext e. '.pdf';'.jpf';'.jpg';'.jpeg'
view msk # fls

ext=. (-.msk)#ext
fls=. (-.msk) # fls

msk=. ext e. PUBEXT
if. 0 e. msk do.
  info 'Cannot open: ',LF,LF,tolist (0=msk)#fls
end.
fls=. msk # fls
if. 0 = #fls do. return. end.
open_ppubwin_ jhostpath each fls
)

NB. =========================================================
tab_refresh=: 3 : 0
pubrefresh''
tab_show''
)

NB. =========================================================
tab_selected=: 3 : 0
if. 0=#filelist do. '' return. end.
nms=. <;._2 filelist
if. TABNDX<3 do.
  nms=. (TABNDX{BEXTS) addext each nms
end.
pubfullname each nms
)

NB. =========================================================
tab_show=: 3 : 0
fls=. ". TABNDX pick BFILES
wd 'psel ',HWNDP
if. 0=#PUBFILE do.
  wd 'set filelist *'
else.
  wd 'set filelist *', jhostpath tolist pubshortname each fls
end.
)

NB. =========================================================
tab_view=: 3 : 0
fls=. jhostpath each tab_selected ''
if. #fls do. view fls end.
)

NB. =========================================================
view=: 3 : 0

ext=. (y i: &> '.') }. each y
dun=. (#y) $ 0

NB. ---------------------------------------------------------
pdf=. getPDFreader_ppublish_''
msk=. ext = <'.pdf'
dun=. dun +. msk
for_t. msk#y do.
  cmd=. pdf,' "',(>t),'"'
  if. IFUNIX do.
    2!:1 cmd,' &'
  else.
    if. #pdf do.
      wd 'winexec *',cmd
    else.
      shell }.cmd
    end.
  end.
end.

NB. ---------------------------------------------------------
msk=. IFUNIX < ext e. '.jpg';'.jpeg'
dun=. dun +. msk
for_t. msk#y do.
  shell '"',(>t),'"'
end.

NB. ---------------------------------------------------------
msk=. ext e. '.ijs';'.jpf';'.sty';'.txt'
dun=. dun +. msk

for_t. msk#y do.
  try.
    (>t) wdview 1!:1 t
  catch. end.
end.

NB. ---------------------------------------------------------
if. 0 e. dun do.
  info 'Cannot view: ',LF,LF,tolist (0=dun)#y
end.

NB. ---------------------------------------------------------
wd 'psel ',HWNDP,';pactive'

)
