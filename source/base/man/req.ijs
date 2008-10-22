NB. req
NB.
NB. required files and libraries

RX=: '^(load|require|script<|script_z_<|script <|script_z_) *(''(''''|[^''])*'')'

reqread=: 1!:1 :: (''"_)
reqscripts=: fromfoldername @ getlibfiles @ ; @: (cutopen@".&.>)

NB. =========================================================
NB. get dependencies in library files:
reqlibs=: getlibids @: req @: getlibfiles

NB. =========================================================
reqlibs1=: 3 : 0
a=. y
b=. ''
while. -. '' -: r=. reqlibs a do.
  a=. r [ b=. r,b
end.
~.b,y
)

NB. =========================================================
getliball=: 3 : 0
sort STDLIBS -.~ ~. {."1 PUBLIC
)

NB. =========================================================
getlibfiles=: 3 : 0
f=. (0{"1 PUBLIC),y
t=. (1{"1 PUBLIC),y
t {~ f i. y
)

NB. =========================================================
getlibids=: 3 : 0
s=. jhostpath each y
f=. (1{"1 PUBLIC),y
t=. (0{"1 PUBLIC),s
t {~ f i. y
)

NB. =========================================================
NB. nodepends   - delete dependencies from text
nodepends=: 3 : 0
if. 0=#y do. '' return. end.
dat=. (LF,LF),y
hit=. RX rxmatches_jregex_ dat
if. 0=#hit do. y return. end.
ndx=. 0, {.@(1&{)"2 hit
dat=. ((i.#dat) e. ndx) <;.1 dat
dat=. 6 }. ; 'NB. '&, each dat
)

NB. =========================================================
NB. req - searches for dependencies in files
NB. returns system libraries in host foldername format
req=: 3 : 0
RXH=: rxcomp_jregex_ RX
files=. fromfoldername boxxopen y
done=. ''
found=. i.0 2
while. #files do.
  done=. done,f=. {.files
  r=. req1 f
  found=. found, r ,. f
  files=. ~. (}.files), r -. done
end.
rxfree_jregex_ RXH
reqsort found
)

NB. =========================================================
req1=: 3 : 0
dat=. reqread < jpath > y
if. 0=#dat do. '' return. end.
hit=. RXH rxmatches_jregex_ LF,dat
if. 0=#hit do. '' return. end.
reqscripts (2{"2 hit) rxfrom_jregex_ LF,dat
)

NB. =========================================================
NB. reqsort  - sort required files in order
NB. and return in host foldername format
reqsort=: 3 : 0
b=. {."1 y
e=. {:"1 y
r=. ''
while. #b do.
  n=. b -. e
  if. 0=#n do. n=. {.b end.
  r=. r,n
  msk=. -. b e. n
  e=. msk#e
  b=. msk#b
end.
r=. ~. r
s=. 1{"1 PUBLIC
t=. fromfoldername s
(s,r) {~ (t,r) i. r
)
