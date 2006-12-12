NB. util

NB. =========================================================
NB. delNB
delNB=: 3 : 0
txt=. <;._2 y
txt=. txt #~ (<'NB.') ~: 3 {.each txt
; txt ,each LF
)

NB. =========================================================
NB. findrx
NB. return boolean mask of hits
findrx=: 4 : 0
hit=. x rxmatches y
res=. (#y)$0
if. #hit do.
  1 ({."1 {."2 hit) } res
end.
)

NB. =========================================================
NB. check if begin pairs with end
pairs=: 4 : 0
r=. +/\x - y
*./ (0={:r), 0<:r
)

NB. =========================================================
NB. premask
NB. return boolean mask where 1=<pre> section.
NB. <pre> sections may not be nested.
premask=: 3 : 0
bgn=. I. '<pre>' E. y
res=. (#y)$0
if. 0 = #bgn do. return. end.
end=. I. '</pre>' E. y
assert. (#bgn) = #end
end=. (end+6) -. #res
msk=. +/\ _1 end } 1 bgn } res
assert. *./ msk e. 0 1
0 < msk
)

NB. =========================================================
NB. tagsplit
NB.
NB. splits block on first tag
tagsplit=: 3 : 0
assert. 1 = > {.{.y
tags=. 1 {"1 y
tag0=. > {. tags
if. '/' = {:tag0 do.
  (,:{.y);<}.y
else.
msk=. tags = {.tags
cnt=. ;msk # {."1 y
ndx=. 1 i.~ 0 = +/\cnt
len=. ndx { (1 + I. msk),1
(len{.y);<len}.y
end.
)