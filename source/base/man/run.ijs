NB. pubman run

NB. =========================================================
NB. called by Run button
pubmanrun=: 3 : 0
if. 0=#PUBFILE do. infonopub'' return. end.
saveall_ppubwin_''
mas=. jhostpath PUBPATH,'master.txt'
if. -. fexist mas do.
  info 'Master file not found: ',mas return.
end.
res=. publish_ppublish_ mas;1
if. #res do.
  info (1+res i. ' ') }. res
end.
)

NB. =========================================================
pubman=: 3 : 0
if. -. pubinit y do. return. end.
pubform_run''
)

NB. =========================================================
NB. z definitions
pubman_z_=: pubman_ppubman_
