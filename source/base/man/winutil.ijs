NB. selection

NB. =========================================================
NB. following used for new window positioning:
3 : 0''
qm=. 0 ". wd 'qm'
if. IFWIN32 > IFJAVA do.
  DESK=: 14 15 { qm
  BLK=: +/ <: 9 10 { qm
else.
  DESK=: (2 {. qm) - 0 33
  BLK=: 26
end.
)

NB. =========================================================
NB. getcascade
NB. get cascade position for a new window
getcascade=: 3 : 0
lcs=. }:LOCS NB. ignore most recent
if. 0 = #lcs do. 0 0,SIZE return. end.
top=. i.0 2
for_loc. lcs do.
  wd 'psel ',HWNDP__loc
  top=. top,2 {. 0 ". wd 'qformx'
end.
wd 'psel ',HWNDP
len=. 1 + 0 >. <. <./ (DESK - SIZE) % BLK
bgn=. (BLK * i.len) - -: BLK
end=. bgn + BLK
top=. top #~ *./"1 top < {: end
x=. {."1 top
y=. {:"1 top
x=. (i.<./) +/ (x >/ bgn) *. x </ end
y=. (i.<./) +/ (y >/ bgn) *. y </ end
SIZE ,~ BLK * x,y
)

NB. =========================================================
select_line=: 3 : 0

txt=. read ''
'bgn end'=. oldsel=. getsel ''

if. 0 = #txt do.
  wdinfo 'Selection';'No text selected' return.
end.

sel=. bgn }. end {. txt
ndx=. LF i.~ |. bgn {. txt
bgn=. bgn - ndx
if. LF ~: {: sel do.
  txt=. txt, LF
  ndx=. 1 + LF i.~ end }. txt
  end=. end + ndx
end.

sel=. bgn }. end {. txt

csl=. <;.2 sel

select. y
case. 'minus' do.
  msk=. -. (8 {. each csl) e. 'NB. ----';'NB. ===='
  csl=. msk # csl
  msk4=. (<'NB. ') = 4 {. each csl
  msk3=. msk4 < (<'NB.') = 3 {. each csl
  new=. ; ((msk4 * 4) + msk3 * 3) }. each csl
  set=. bgn + 0, <: #new
case. 'plus' do.
  msk=. 1 < # &> csl
  hdr=. (3 + msk) {. each <'NB.'
  new=. ; hdr ,each csl
  set=. bgn + 0, <: #new
case. 'plusline1' do.
  cmt=. 'NB. ',(57#'-'),LF
  new=. ; cmt ; csl
  set=. oldsel + #cmt
case. 'plusline2' do.
  cmt=. 'NB. ',(57#'='),LF
  new=. ; cmt ; csl
  set=. oldsel + #cmt
case. 'sort' do.
  new=. ; /:~ csl
  set=. bgn + 0, <: #new
end.

if. -. new -: sel do.
  setsel bgn, end
  replace new
  setsel set <. <: #read''
end.

)

NB. =========================================================
select_text=: 3 : 0

txt=. read ''
'bgn end'=. getsel ''

if. bgn = end do.
  wdinfo 'Selection';'No text selected' return.
end.

sel=. bgn }. end {. txt
select. y
case. 'lower' do.
  new=. tolower sel
case. 'toggle' do.
  lwr=. a. {~ (i.26) + a. i. 'a'
  upr=. a. {~ (i.26) + a. i. 'A'
  ndx=. (lwr,upr,a.) i. sel
  new=. ndx { upr,lwr,a.
case. 'upper' do.
  new=. toupper sel
case. 'wrap' do.
  new=. 61 foldtext sel
end.

if. -. new -: sel do.
  replace new
  setsel bgn + 0,#new
end.

)

