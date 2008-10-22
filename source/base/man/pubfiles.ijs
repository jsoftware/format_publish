NB. pubman files

NB. =========================================================
NB. deletefile
deletefile=: 3 : 0

p=. PUBID
j=. '"Script Files (*.ijs)|*.ijs|Text Files (*.txt)|*.txt|'
j=. j,'All Files (*.*)|*.*" ofn_nochangedir'
f=. wd 'mbopen "Remove File" "',p,'" "" ',j

if. ''-:f do. return. end.
if. 0=fexist f do. return. end.
if. 1=2 query 'OK to delete: ',f,'?' do. return. end.

file=. <f
1!:55 file
TEXTFILES=: TEXTFILES -. file
SCRIPTFILES=: SCRIPTFILES -. file
STYLEFILES=: STYLEFILES -. file
OTHERFILES=: OTHERFILES -. file
showfiles''
)

NB. =========================================================
pubdir=: 3 : 0
jpathsep each 1 dir y
)

NB. =========================================================
NB. initialize pubman files:
NB. this is called when the pubman manager form is loaded
NB. argument is pubman path or file
NB. return success
pubinit=: 3 : 0
pubreset''
p=. jpathsep filecase deb y
if. 0=#p do.
  info 'Empty argument given to pubman'
  0 return.
end.
pubcfgread''
if. '.jpb' -: _4 {. p do.
  pubopen p
else.
  pubopenpid p
end.
1
)

NB. =========================================================
pubmakemaster=: 3 : 0
mas=. PUBPATH,'master.txt'
if. -. fexist mas do.
  '' fwrite mas
end.
)

NB. =========================================================
pubmerge=: 4 : 0
f=. jpathsep each x,,y
if. #f do.
  fexists sortfiles ~.f
end.
)

NB. =========================================================
pubnewbrowse=: 3 : 0
pubsave 0
path=. jhostpath addsep PUBPID
while. 1 do.
  j=. '"Publish Files(*.jpb)|*.jpb" ofn_nochangedir'
  f=. wd 'mbsave "New Publish File" "',path,'" "" ',j
  if. 0=#f do. return. end.
  f=. extjpb jpathsep f
  if. -. '.jpb' -: _4 {.f do.
    info 'Publish filename extension should be .jpb' continue.
  end.
  'path file'=. pathfile f
  pid=. 1 pick pathfile }:path
  req=. jhostpath path,pid,'.jpb'
  f=. jhostpath f
  if. -. f -: req do.
    info 'Publish project file should be named: ',req,'. Using that name.'
    f=. req
  end.
  if. fexist f do.
    if.
      msg=. f,LF,'This file already exists.'
      msg=. msg,LF,LF,'Replace existing file?'
      0=2 1 query msg do. break.
    end.
  elseif. 1 do.
    '' fwrite f break.
  end.
end.
pubopen f
pubmakemaster''
pubformshow''
)

NB. =========================================================
NB. pubopenbrowse
pubopenbrowse=: 3 : 0
pubsave 0
path=. jhostpath }:PUBPID
while. 1 do.
  j=. '"Publish Files(*.jpb)|*.jpb" ofn_filemustexist ofn_nochangedir'
  f=. wd 'mbopen "Open Publish File" "',path,'" "" ',j
  if. 0=#f do. return. end.
  f=. extjpb f
  if. '.jpb' -: _4 {.f do. break. end.
  info 'Publish filename extension should be .jpb'
  path=. 0 pick pathfile jpathsep f
end.
pubopen f
pubformshow''
)


NB. =========================================================
NB. pubopen
NB. opens a pubman file
NB. return success
pubopen=: 3 : 0
file=. pubfullname y
if. -. '.jpb' -: _4 {. file do.
  info 'Not a pubman file: ',file
  0 return.
end.
if. -. fexist file do.
  info 'not found: ',file
  0 return.
end.
pubsetfile file
pubread''
snapshot''
1
)

NB. =========================================================
NB. pubopenpid
NB. opens a pubman path id
NB. return success
pubopenpid=: 3 : 0
pubsetpid addsep jpathsep deb y
if. #PUBFILES do.
  pubopen 0 pick PUBFILES
else.
  PUBFILE=: PUBPATH=: ''
end.
)

NB. =========================================================
NB. pubread - this reads the file and assigns globals
pubread=: 3 : 0
(PUBDEFS)=: <''
try. 0!:0 <PUBFILE
catch. info 'Unable to load: ',y
end.
SCRIPTFILES=: sortfiles cutopen jhostpath SCRIPTFILES
STYLEFILES=: sortfiles cutopen jhostpath STYLEFILES
TEXTFILES=: sortfiles cutopen jhostpath TEXTFILES
OTHERFILES=: sortfiles cutopen jhostpath OTHERFILES
OTHERFILES=: sortfiles OTHERFILES -. SCRIPTFILES,STYLEFILES,TEXTFILES
PUBOLD=: pubdefs''
pubrefresh''
)

NB. =========================================================
NB. pubrefresh - this reads the directory and
NB. updates corresponding globals
pubrefresh=: 3 : 0
p=. jhostpath addsep PUBPATH
TEXTFILES=: TEXTFILES pubmerge pubdir p,'*.txt'
STYLEFILES=: STYLEFILES pubmerge pubdir p,'*.sty'
SCRIPTFILES=: SCRIPTFILES pubmerge pubdir p,'*.ijs'
sel=. PUBFILE;TEXTFILES,STYLEFILES,SCRIPTFILES
bal=. (pubdir p,'*.*') -. sel
OTHERFILES=: (OTHERFILES -. sel) pubmerge bal
)

NB. =========================================================
NB. pubsave - saves pubman file
NB. y=1 force save
NB. only files outside directory are saved
pubsave=: 3 : 0
if. (y=0) *. PUBOLD -: pubdefs'' do. return. end.
pn=. jpathsep extnone PUBFILE
hdr=. 'NB. publish manager file: ',pn,LF,LF
hdr=. hdr,'coclass ''ppubman''',LF
pub=. pubdir jhostpath PUBPATH,'*.*'
r=. ''
r=. r,<'SCRIPTFILES' nounrep SCRIPTFILES -. pub
r=. r,<'STYLEFILES' nounrep STYLEFILES -. pub
r=. r,<'TEXTFILES' nounrep TEXTFILES -. pub
r=. r,<'OTHERFILES' nounrep OTHERFILES -. pub
dat=. hdr, ; LF&, each r
dat fwritesnew PUBFILE
PUBOLD=: pubdefs''
EMPTY
)

NB. =========================================================
NB. return success
pubsetfile=: 3 : 0
PUBFILE=: y
PUBPATH=: 0 pick pathfile PUBFILE
path=. PUBPID
if. (0=#path) >: path -: (#path){.PUBPATH do.
  path=. 0 pick pathfile }:PUBPATH
end.
pubsetpid path
pubaddrecent''
)

NB. =========================================================
NB. return success
pubsetpid=: 3 : 0
PUBPID=: y
t=. jpathsep each filecase each dpath PUBPID
t=. t ,each '/' ,each (dirname each t) ,each <'.jpb'
PUBFILES=: fexists t
)
