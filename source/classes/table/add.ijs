NB. table add
NB.
NB. if row not given, treat as empty row label
NB. if col not given, tread as empty col header

NB. =========================================================
TableTags=: <;._2 (0 : 0)
align
bold
col
data
gridh
gridv
high
row
top
)

NB. =========================================================
add=: 3 : 0
assert. 2 = #y
assert. (1;_1) -: {."1 y
'off tag prm val'=. {.y
set prm
val=. TableTags parseml val
assert. *./ (<'data') e. 1{"1 val
msk=. (<1) = {."1 val
addopts msk # val

NB. ---------------------------------------------------------
NB. set data globals:
NB. Data=: ,Data
IfRow=: 0 < #Row
IfCol=: 0 < #Col

NB. ---------------------------------------------------------
select. IfRow,IfCol
case. 0 0 do.
  if. 0=#SHAPE do.
    'Shape not given' assert. 0
  end.
  'Crws Ccls'=: SHAPE
  Clen=: Crws * Ccls
  Row=: Crws#<''
  Col=: Ccls#<''
  Top=: ''
case. 1 0 do.
  Clen=: #Data
  Crws=: #Row
  Ccls=: <. Clen % Crws
  Col=: Ccls#<''
  Top=: ''
case. 0 1 do.
  Clen=: #Data
  Ccls=: #Col
  Crws=: <. Clen % Ccls
  Row=: Crws#<''
case. 1 1 do.
  Crws=: #Row
  Ccls=: #Col
  Clen=: Crws * Ccls
end.
assert. Clen = #Data

NB. ---------------------------------------------------------
hc=. <;._1 &> LF ,each Top;Col
Top=: {.hc
Col=: |:}.hc
assert. Ccls = {:$Col

NB. ---------------------------------------------------------
Hrws=: #Col
Trws=: Hrws+Crws
Tcls=: 1 + Ccls
Tlen=: Trws * Tcls
)

NB. =========================================================
addopts=: 3 : 0
for_d. y do.
  'off nam prm val'=. d
  set prm
  val=. u2a val
  select. nam
  case. 'align' do.
    Align=: fix val
  case. 'bold' do.
    Bold=: fix val
  case. 'col' do.
    Col=: br2lf each cutlist val
  case. 'data' do.
    Data=: cutlist val
  case. 'gridh' do.
    Gridh=: fix val
  case. 'gridv' do.
    Gridv=: fix val
  case. 'high' do.
    High=: fix val
  case. 'row' do.
    Row=: cutlist val
  case. 'top' do.
    Top=: br2lf deb val
  end.
end.
)
