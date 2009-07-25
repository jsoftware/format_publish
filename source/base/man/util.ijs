NB. utils

EMPTY=: i. 0 0

NB. =========================================================
NB. convert case (not if unix)
3 : 0''
if. IFUNIX do.
  filecase=: [
else.
  filecase=: tolower
end.
0
)

NB. =========================================================
bcfind=: #@[ (| - =) i. &: (filecase each)

addsep=: , '/' -. {:
cutLF=: <;._2 @ (, LF -. {:)
deb=: #~ (+. 1: |. (> </\))@(' '&~:)
delfret=: }: @ addsep
drophead=: ] }.~ #@[ * [ -: &: filecase #@[ {. ]
dtb=: #~ [: +./\. ' '&~:
fix=: _1&".
hostcmd=: [: 2!:0 '(' , ,&' || true)'
index=: #@[ (| - =) i.
info=: wdinfo @ ('Publish Manager'&;)
infonopub=: info bind 'First select a Publish Manager file'
infonosel=: info bind 'No file selected'
infonospec=: info bind 'No file specified'
intersect=: e. # [
isboxed=: 0 < L.
isempty=: 0: e. $
dirname=: ] #~ [: *./\. '/' ~: ]
matchhead=: [ -: &: filecase #@[ {. ]
pathname=: 3 : '(b#y);(-.b=.+./\.y=PATHSEP_j_)#y'
query=: wdquery 'Publish Manager'&;
subs=. 2 : 'x I. @(e.&y)@]} ]'
termLF=: , (0: < #) # LF -. _1&{.    NB. ensure LF terminated
termdelLF=: {.~ 1: i.~ [: *./\. =&LF   NB. ensure not LF terminated
toblank=: ' ' subs '_'
tolist=: }. @ ; @: (LF&, each)
tounderscore=: '_' subs ' '

NB. =========================================================
a=. ''''
quote=: (a&,@(,&a))@ (#~ >:@(=&a))
dquote=: '"'&, @ (,&'"')

NB. =========================================================
addNB=: 3 : 0
if. 0=#y do. '' return. end.
y=. cutLF termLF y
b=. 0='NB.'&-: @ (3&{.) &> y
add=. b #each <'NB. '
tolist add ,each y
)

NB. =========================================================
NB.*dpath v get directory path
NB. directory search is recursive through subdirectories
NB. argument is a pathname
NB. argument is not in result if it ends in a path separator
NB.   dpath 'e:\mywork\'
NB. ignore hidden files/directories
dpath=: 3 : 0
y=. '/' (I. y='\')} y
p=. (+./\. y = '/') # y
d=. 1!:0 y,('/' = {:y) # '*'
if. 0 = #d do. '' return. end.
d=. d #~ '-d' -:"1 [ 1 4 {"1 > 4 {"1 d
if. 0 = #d do. '' return. end.
f=. (<p) ,each {."1 d
f, ; dpath each f ,each <'/*'
)

NB. =========================================================
NB. writes text to file (if changed)
fwritesnew=: 4 : 0
dat=. x
if. -. 0 e. $dat do.
  if. 1>:#$dat do.
    dat=. toHOST dat
    dat=. dat,(LF ~: {:dat)#CRLF
  else. dat=. dat,"1 CRLF
  end.
end.
dat fwritenew y
)

NB. =========================================================
NB. writes data to file (if changed)
fwritenew=: 4 : 0
dat=. ,x
new=. -. dat -: fread y
if. new do. dat fwrite y end.
new
)

NB. =========================================================
NB. namerep
namerep=: 3 : 0
LF ,~ y,'=: ',nounrep1 ".y
)

NB. =========================================================
NB. nounrep
nounrep=: 4 : 0
LF ,~ x,'=: ',nounrep1 y
)


NB. =========================================================
NB. nounrep1
nounrep1=: 3 : 0
dat=. y
if. 0=#dat do. '''''' return. end.
if. isboxed dat do.
  dat=. ; (": each dat) ,each LF
end.
select. 3!:0 dat
case. 2 do.
  if. LF e. dat do.
    dat=. dat, LF -. {:dat
    '0 : 0', LF, ; <;.2 dat,')'
  else.
    quote dat
  end.
case. do.
  ": dat
end.
)

NB. =========================================================
shellcmd=: 3 : 0
if. IFUNIX do.
  'res err'=. unixshell y
  if. #err do.
    res=. res,((0<#res)#LF,LF),err
  end.
  res
else.
  spawn_jtask_ y
end.
)

NB. =========================================================
NB. sort pubman files in alpha order within source path
sortfiles=: 3 : 0
files=. sort y
files /: (<PUBPATH) ~: (#PUBPATH) {.each files
)

NB. =========================================================
NB. unixshell v return result;error msg
unixshell=: 3 : 0
f=. jpath '~temp/shell.sh'
t=. jpath '~temp/shell.txt'
e=. jpath '~temp/shell.err'
('#!/bin/sh',LF,y,LF) fwrite f
'rwx------' 1!:7 <f
hostcmd '"',f,'" > "',t,'" 2> "',e,'"'
r=. (fread t);fread e
ferase f;t;e
r
)

NB. =========================================================
NB. unixshellx v do shell cmd, display any error
unixshellx=: 3 : 0
'res err'=. unixshell y
if. #err do.
  info 'Shell command error: ',LF,LF,err
end.
res
)

