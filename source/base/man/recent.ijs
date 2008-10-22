NB. recent

RECENT=: 0 : 0
pc precent nomin owner;pn "Recent Publish Files";
xywh 4 8 51 10;cc s0 static;cn "Publish Files:";
xywh 3 18 174 123;cc l0 listbox ws_vscroll rightmove bottommove;
xywh 95 5 40 12;cc cancel button leftmove rightmove;cn "Cancel";
xywh 136 5 40 12;cc ok button bs_defpushbutton leftmove rightmove;cn "OK";
pas 2 2;pcenter;
rem form end;
)

NB. =========================================================
precent_run=: 3 : 0
if. 0 e. #PUBRECFILES do.
  info 'No recent pubman files' return.
end.
pubsave 0
rp=. pubshortname PUBRECFILES
pos=. wd 'qformx'
wd RECENT
wdcenter pos
wd 'set l0 *', tolist rp
wd 'setselect l0 0'
wd 'setfocus l0'
wd 'pshow'
)

NB. =========================================================
precent_close=: 3 : 0
wd 'pclose'
wd 'psel ',HWNDP,';pactive'
)

NB. =========================================================
precent_doit=: 3 : 0
wd 'pclose'
if. #l0 do.
  wd 'psel ',HWNDP
  pubopen l0
  pubaddrecent''
  pubformshow''
end.
wd 'psel ',HWNDP,';pactive'
)

NB. =========================================================
precent_enter=: precent_ok_button=: precent_l0_button=: precent_doit
precent_cancel=: precent_cancel_button=: precent_close

NB. =========================================================
NB. last only
plast_run=: 3 : 0
j=. PUBRECFILES -. < PUBFILE
if. 0 e. #j do.
  info 'No other recent pubman files' return.
end.
pubsave 0
pubopen >{.j
pubaddrecent''
pubformshow''
)
