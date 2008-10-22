NB. win

coclass 'ppubwin'
coinsert 'ppubman'

SIZE=: 0 0

NB. =========================================================
create=: 3 : 0
FILE=: >y
TEXT=: freads FILE
IFSAVED=: 0
add FILE;coname''
win_run''
)

NB. =========================================================
destroy=: 3 : 0
delete FILE
try.
  wd 'psel ',HWNDP
  wd 'pclose'
catch. end.
codestroy''
)

NB. =========================================================
add=: 3 : 0
cocurrent 'ppubwin'
FILES=: FILES,0{y
LOCS=: LOCS,1{y
)

NB. =========================================================
close=: 3 : 0
save 1
destroy''
)

NB. =========================================================
closeall=: 3 : 0
refresh''
for_loc. LOCS do.
  close__loc 1
end.
)

NB. =========================================================
delete=: 3 : 0
cocurrent 'ppubwin'
msk=. FILES ~: <y
FILES=: msk#FILES
LOCS=: msk#LOCS
refresh''
)

NB. =========================================================
NB.getsaveas v get a save as file name
getsaveas=: 3 : 0
fn=. FILE
types=. '"Text (*.txt)|*.txt|Scripts (*.ijs)|*.ijs|Styles (*.sty)|*.sty|All Files (*.*)|*.*"'
types=. types,' ofn_nochangedir'
while. 1 do.
  'p f'=. pathname fn
  fn=. wd 'mbsave "Save As" "',p,'" "',f,'" ',types
  if. 0=#fn do. return. end.
  if. -. '.' e. fn do. fn=. fn,'.txt' end.
  if. fn -: FILE do. return. end.
  if. 0=fexist fn do. return. end.
  j=. fn,LF,'This file already exists.',LF,LF
  msg=. j,'Replace existing file?'
  if. 0=2 query msg do. fn return. end.
end.

)

NB. =========================================================
getsel=: 3 : 0
dat=. wd 'qd'
ndx=. ({."1 dat) i. <'e_select'
0 ". 1 pick ndx { dat
)

NB. =========================================================
marksaved=: 3 : 0
wd 'psel ',HWNDP
wd 'setmodified e 0'
)

NB. =========================================================
NB. open files
open=: 3 : 0
refresh''
for_f. boxxopen y do.
  if. f e. FILES do.
    ndx=. FILES i. f
    loc=. ndx{LOCS
    wd 'psel ',HWNDP__loc
    wd 'pactive'
  else.
    f conew 'ppubwin'
  end.
end.
)

NB. =========================================================
read=: 3 : 0
wd 'psel ',HWNDP
dat=. wd 'qd'
ndx=. ({."1 dat) i. <,'e'
1 pick ndx { dat
)

NB. =========================================================
refresh=: 3 : 0
cocurrent 'ppubwin'
if. _1=nc <'FILES' do.
  FILES=: LOCS=: ''
else.
  msk=. LOCS e. 18!:1[1
  LOCS=: msk#LOCS
  FILES=: msk#FILES
end.
)

NB. =========================================================
replace=: 3 : 0
wd 'psel ',HWNDP
wd 'setreplace e *',utf8 y
)

NB. =========================================================
save=: 3 : 0
sel=. {. y , 1
new=. read''
if. TEXT -: new do. 1 return. end.
if. (sel=0) +. (sel=1) *. IFSAVED=0 do.
  q=. 3 query 'Save changes to ',FILE,'?'
  if. q do.
    (1 2 i. q) { 0 2 return.
  end.
end.
new fwrites FILE
marksaved ''
TEXT=: new
IFSAVED=: 1
)

NB. =========================================================
saveall=: 3 : 0
refresh''
for_loc. LOCS do.
  save__loc 1
end.
)

NB. =========================================================
saveas=: 3 : 0
fn=. getsaveas''
if. #fn do.
  FILE=: fn
  new=. read''
  new fwrites FILE
  TEXT=: new
  IFSAVED=: 1
  wd 'pn *',1 pick pathname FILE
  tab_refresh_ppubman_''
  wd 'psel ',HWNDP
end.
)

NB. =========================================================
setsel=: 3 : 0
wd 'psel ',HWNDP
wd 'setselect e ',": y
)

NB. =========================================================
WIN=: 0 : 0
pc win;
menupop "&File";
menu save "Save" "Ctrl+S" "" "";
menu saveas "Save &As..." "" "" "";
menusep;
menu close "Close" "" "" "";
menupopz;
menupop "&Edit";
menu editundo "&Undo" "Ctrl+Z" "" "";
menu editredo "&Redo" "Ctrl+Y" "" "";
menusep;
menu editcut "Cu&t" "Ctrl+X" "" "";
menu editcopy "&Copy" "Ctrl+C" "" "";
menu editpaste "&Paste" "Ctrl+V" "" "";
menusep;
menu editselectall "Select &All" "Ctrl+A" "" "";
menupopz;
menupop "Tools";
menu selminus "&Remove ZZ." "Ctrl+Shift+B" "" "";
menu selplus "&Add ZZ." "Ctrl+Shift+N" "" "";
menu selplusline1 "&Add ZZ. --" "Ctrl+Shift+K" "" "";
menu selplusline2 "&Add ZZ. ==" "Ctrl+Shift+L" "" "";
menusep;
menu sellower "&Lower Case" "" "" "";
menu selupper "&Upper Case" "" "" "";
menu seltoggle "&Toggle Case" "" "" "";
menusep;
menu selsort "&Sort" "" "" "";
menusep;
menu selwrap "&Wrap" "" "" "";
menupopz;
xywh 0 0 300 300;cc e edit ws_hscroll ws_vscroll es_nohidesel rightmove bottommove;
pas 0 0;
rem form end;
)

WINT=: WIN rplc 'e edit ';'e editijs ';'ZZ.';'NB.'

NB. =========================================================
win_run=: 3 : 0
wd WINT
HWNDP=: wd 'qhwndp'
wd 'pn *',1 pick pathname FILE
wd 'set e *',TEXT
wd 'setfont e ',FIXFONT
if. SIZE -: 0 0 do.
  SIZE_ppubwin_=: _2 {. 0 ". wd 'qformx'
else.
  wd 'pmovex ',":getcascade''
end.
wd 'pshow'
)

NB. =========================================================
win_cancel=: destroy
win_close_button=: win_close=: close
win_e_button=: ]
win_save_button=: save bind 2
win_saveas_button=: saveas
win_editcopy_button=: 3 : 'wd ''setedit e c'''
win_editcut_button=: 3 : 'wd ''setedit e x'''
win_editpaste_button=: 3 : 'wd ''setedit e v'''
win_editredo_button=: 3 : 'wd ''setedit e y'''
win_editselectall_button=: 3 : 'wd ''setselect e'''
win_editundo_button=: 3 : 'wd ''setedit e z'''
win_sellower_button=: select_text bind 'lower'
win_selminus_button=: select_line bind 'minus'
win_selplus_button=: select_line bind 'plus'
win_selplusline1_button=: select_line bind 'plusline1'
win_selplusline2_button=: select_line bind 'plusline2'
win_selsave_button=: ]
win_selsaveas_button=: ]
win_selsort_button=: select_line bind 'sort'
win_seltoggle_button=: select_text bind 'toggle'
win_selupper_button=: select_text bind 'upper'
win_selwrap_button=: select_text bind 'wrap'

win_bctrlshift_fkey=: win_selminus_button
win_kctrlshift_fkey=: win_selplusline1_button
win_lctrlshift_fkey=: win_selplusline2_button
win_nctrlshift_fkey=: win_selplus_button

NB. =========================================================
NB. on load define or refresh globals:
refresh''
