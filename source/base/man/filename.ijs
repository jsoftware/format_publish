NB. standard filename utils
NB.
NB. main definitions:

PUBEXT=: <;.1 '.jpb.ijs.sty.txt'

NB. =========================================================
fexist=: 1:@(1!:4)@boxopen :: 0:
fexists=: #~ fexist&>
jpathsep=: '/' & (I.@(=&'\')@]})
pathfile=: 3 : '(b#y);(-.b=.+./\.y=''/'')#y'
fpath=: 0 pick pathfile

NB. =========================================================
addext=: 4 : 0
if. 0 e. (#x),#y do. y return. end.
y, (-.x -: (-#x) {. y) # x
)

extjpb=: '.jpb' & addext

NB. =========================================================
NB. removes jpb, ijs, txt extensions
extnone=: 3 : 0
(- 4 * (<_4 {. y) e. PUBEXT) }. y
)

NB. =========================================================
NB. convert file/directory name into full pathfile:
pubfullname=: 3 : 0
if. 0 = #y do. '' return. end.
d=. filecase jpathsep y
if. +:/ '/:' = 2 {. d do.
  if. '/' e. d do.
    PUBPID,d
  else.
    PUBPATH,d
  end.
end.
)

NB. =========================================================
pubshortname=: 3 : 0
PUBPID drophead PUBPATH drophead extnone y
)

