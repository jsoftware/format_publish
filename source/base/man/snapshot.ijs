NB. snapshot

NB. =========================================================
snapdir=: 3 : 0
jhostpath PUBPATH,'/.pub'
)

NB. =========================================================
snapshot=: 3 : 0

NB. snapshot not yet
return.

today=. 's', 2 }. ": <. 100 #. 3 {.6!:0''
p=. snapdir''

NB. ---------------------------------------------------------
if. 0 = #1!:0 p do.
  if. -. ss_makedir p do. return. end.
end.

NB. ---------------------------------------------------------
NB. make a snapshot if none
p=. p,PATHSEP_j_
d=. 1!:0 p,'*'
pfx=. p,today
if. 0=#d do. ss_make pfx,'001' return. end.

NB. ---------------------------------------------------------
d=. \:~ {."1 d #~ 'd' = 4{"1 > 4{"1 d
last=. 0 pick d
iftoday=. today -: 7 {. last

NB. ---------------------------------------------------------
NB. force snap
if. y -: 1 do.
  if. (p,last) ss_match PUBPATH do.
    ss_info 'Last snapshot matches current pubman.' return.
  end.
  if. iftoday do.
    f=. pfx,_3 {. '00',": 1 + 0 ". _3 {. last
  else.
    f=. pfx,'001'
  end.
  ss_make f
  ss_info 'New snapshot: ',1 pick pathfile f

NB. ---------------------------------------------------------
NB. auto snap
else.
  if. iftoday do. return. end.
  if. (p,last) ss_match PUBPATH do. return. end.
  ss_make pfx,'001'
end.

NB. ---------------------------------------------------------
NB. only get here if new snapshot
d=. (PUBSNAPS-1) }. d
for_s. d do.
  f=. p,(>s),PATHSEP_j_
  1!:55 f&, each {."1 [ 1!:0 f,'*'
  1!:55 <f
end.
)

NB. =========================================================
snapview=: 3 : 0
'require'~'~system\extras\util\dirmatch.ijs'
PJPROJ_jdirmatch_=: ''
dmrun_jdirmatch_ 1 1
)

NB. =========================================================
NB. ss_files get directory list of files
NB. ignores exclusion list and hidden files
ss_files=: 3 : 0
t=. 1!:0 y,'*'
if. 0=#t do. return. end.
att=. > 4{"1 t
msk=. ('h' = 1{"1 att) +: 'd' = 4{"1 att
t=. /:~ msk # t
if. #PUBSNAPX do.
  t #~ -. +./ PUBSNAPX (1: e. E.) &>/ {."1 t
end.
)

NB. =========================================================
ss_info=: wdinfo @ ('Snapshot'&;)

NB. =========================================================
NB. ss_make - make a snapshot
ss_make=: 3 : 0
fm=. jhostpath PUBPATH,'/'
to=. jhostpath y,'/'
if. 0 -: 1!:5 :: 0: <to do.
  ss_info 'Unable to create snapshot directory.'
  0 return.
end.
f=. {."1 ss_files fm
fm=. (<fm) ,each f
to=. (<to) ,each f
res=. snapfilecopy"1 fm ,. to
if. 0 e. res do.
  txt=. 'Unable to copy:',LF,LF,tolist (res=0)#fm
  ss_info txt
end.
)

NB. =========================================================
NB. ss_makedir - make snapshot directory
ss_makedir=: 3 : 0

NB. ---------------------------------------------------------
if. 0 -: 1!:5 :: 0: <y do.
  ss_info 'Unable to create snapshot directory.'
  0 return.
end.

NB. ---------------------------------------------------------
arw=. 'rw' 0 1 } 1!:7 <y
if. 0 -: arw 1!:7 :: 0: <y do.
  ss_info 'Unable to set read/write attributes for snapshot directory.'
  0 return.
end.

NB. ---------------------------------------------------------
if. -.IFUNIX do.
  ph=. 'h' 1 } 1!:6 <y
  if. 0 -: ph 1!:6 :: 0: <y do.
    ss_info 'Unable to set hidden attribute for snapshot directory.'
  end.
end.
1
)

NB. =========================================================
NB. ss_match match directories
ss_match=: 4 : 0
x=. addsep x
y=. addsep y
a=. ss_files x
b=. ss_files y
ra=. #a
rb=. #b
if. 0 e. ra,rb do.
  ra = rb return.
end.
fa=. {."1 a
fb=. {."1 b
if. -. fa -: fb do. 0 return. end.
if. -. (2 {"1 a) -: (2 {"1 b) do. 0 return. end.
fx=. x&, each fa
fy=. y&, each fa
(<@(1!:1) fy) -: <@(1!:1) fx
)

