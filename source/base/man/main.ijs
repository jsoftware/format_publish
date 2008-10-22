NB. main pubman window

NB. =========================================================
PUBFORM=: 0 : 0
pc pubform;pn "Publish Manager";
menupop "&File";
menu pnew "&New..." "" "" "";
menu popen "&Open..." "" "" "";
menusep;
menu plast "&Last" "Ctrl+L" "" "";
menu precent "&Recent..." "" "" "";
menusep;
menu save "&Save" "Ctrl+S" "" "";
menusep;
menu exit "E&xit" "" "" "";
menupopz;
menupop "&Tools";
menu pubdir "Publish &Directory" "" "" "";
menusep;
menu viewlog "&View Publish Log..." "" "" "";
menupopz;
menupop "&Windows";
menu closewin "&Close Windows" "" "" "";
menupopz;
xywh 4 5 30 11;cc s0 static;cn "Report:";
xywh 33 4 104 300;cc pubmanfile combodrop ws_vscroll rightmove;
xywh 0 20 198 1;cc s2 staticbox ss_etchedhorz rightmove;
xywh 154 4 42 12;cc run button leftmove rightmove;cn "&Run";
xywh 5 28 33 11;cc btext radiobutton;cn "Text";
xywh 38 28 33 10;cc bstyle radiobutton group;cn "Style";
xywh 71 28 35 10;cc bscript radiobutton group;cn "Script";
xywh 107 28 33 10;cc bother radiobutton group;cn "Other";
xywh 2 43 148 162;cc filelist listbox ws_vscroll lbs_extendedsel rightmove bottommove;
xywh 154 51 42 12;cc open button leftmove rightmove;cn "&Open";
xywh 154 64 42 12;cc openall button leftmove rightmove;cn "O&pen All";
xywh 154 77 42 12;cc view button leftmove rightmove;cn "&View";
xywh 154 90 42 12;cc add button leftmove rightmove;cn "&Add";
xywh 154 103 42 12;cc delete button leftmove rightmove;cn "&Remove";
xywh 154 190 42 12;cc cancel button leftmove topmove rightmove bottommove;cn "Close";
pas 0 2;pcenter;
rem form end;
)

NB. =========================================================
pubform_run=: 3 : 0
if. wdisparent 'pubform' do.
  if. -. pubclose'' do. return. end.
end.
TABNDX=: 0
wd PUBFORM
HWNDP=: wd 'qhwndp'
pubformshow''
wd 'setfocus run'
wpset_j_ 'pubform'
wd 'pshow;'
)

NB. =========================================================
NB. return success
pubclose=: 3 : 0
saveall_ppubwin_''
closeall_ppubwin_''
pubsave 0
try.
  wd 'psel wnote;pclose'
catch. end.
try.
  wd 'psel ',HWNDP
  wpsave_j_ 'pubform'
  wd 'pclose'
catch. end.
HWNDP=: ''
1
)

NB. =========================================================
pubform_pubmanfile_select=: 3 : 0
if. #pubmanfile_select do.
  f=. (".pubmanfile_select) pick PUBFILES
  if. f -: PUBFILE do. return. end.
  pubsave 0
  pubopen f
  tab_refresh''
end.
)

NB. =========================================================
pubform_save_button=: 3 : 0
if. 0=#PUBFILE do. infonopub'' return. end.
pubsave 1
info 'Saved: ',PUBFILE
)

NB. =========================================================
NB. pubformshow
pubformshow=: 3 : 0
wd 'psel ',HWNDP
showpubman''
wd 'psel ',HWNDP,';pactive'
wd 'setfocus run'
tab_show''
)

NB. =========================================================
pubform_viewlog_button=: 3 : 0
if. fexist LOG_ppublish_ do.
  fview LOG_ppublish_
else.
  info 'No Publish log file'
end.
)

NB. =========================================================
showpubdir=: 3 : 'dirs PUBPATH'

NB. =========================================================
showpubman=: 3 : 0
if. #PUBFILES do.
  len=. 1 + # &> dirname each PUBFILES
  nms=. (#PUBPID) }. each (-len) }.each PUBFILES
  wd 'set pubmanfile *', tolist nms
  wd 'setselect pubmanfile ',": PUBFILES bcfind <PUBFILE
  wd 'setenable pubmanfile 1'
else.
  wd 'set pubmanfile *'
  wd 'setenable pubmanfile 0'
end.
)

NB. =========================================================
pubform_enter=: ]
pubform_cancel=: pubform_close=: pubclose
pubform_cancel_button=: pubclose

NB. =========================================================
pubform_closewin_button=: closeall_ppubwin_
pubform_delete_button=: deletefile
pubform_exit_button=: pubform_close
pubform_run_button=: pubmanrun
pubform_plast_button=: plast_run
pubform_pnew_button=: pubnewbrowse
pubform_popen_button=: pubopenbrowse
pubform_precent_button=: precent_run
pubform_pubdir_button=: showpubdir
pubform_pubmanfile_button=: pubform_pubmanfile_select
pubform_sctrl_fkey=: pubform_save_button

NB. =========================================================
NB. "tab" definitions
pubform_btext_button=: tab_button bind 0
pubform_bstyle_button=: tab_button bind 1
pubform_bscript_button=: tab_button bind 2
pubform_bother_button=: tab_button bind 3

pubform_add_button=: tab_add_button
pubform_configure_button=: pubconfigure
pubform_filelist_button=: tab_open
pubform_open_button=: tab_open
pubform_openall_button=: tab_openall
pubform_delete_button=: tab_delete_button
pubform_view_button=: tab_view

