NB. wnote

WNOTE=: 0 : 0
pc wnote owner;
xywh 2 3 55 11;cc z0 static;cn "Notes:";
xywh 0 16 250 200;cc noteedit editm ws_border ws_hscroll ws_vscroll rightmove bottommove;
xywh 207 2 38 12;cc cancel button leftmove rightmove;cn "Close";
pas 0 0;
rem form end;
)

NB. =========================================================
wnote_run=: 3 : 0
if. wdisparent 'wnote' do.
  wd 'psel wnote;pactive' return.
end.
pos=. wd 'qformx'
wd WNOTE
wd 'set noteedit *',XNOTES
wd 'setfocus noteedit'
wdcenter pos
wd 'pshow'
)

NB. =========================================================
wnoteclose=: 3 : 0
XNOTES=: termLF (#~ +./\.@(~:&LF)) noteedit
wd 'pclose'
wd 'psel ',HWNDP,';pactive'
)

wnote_cancel_button=: wnote_cancel=: wnote_close=: wnoteclose
