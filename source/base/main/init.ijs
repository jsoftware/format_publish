NB. init
NB.
NB. 1. A document is a list of:
NB.
NB.    xobjects
NB. sections
NB.
NB. 2. XObjects are named im0, im1 etc.
NB.
NB. 3. A section is numbered with an integer list, which may
NB. be empty:
NB.
NB.   section 1
NB.   section 1 1
NB.   section 2
NB.   section 2 1 1
NB.
NB. 4. A section is a list:
NB.
NB.    Section
NB.    List
NB.    Image
NB.    Plot
NB.    Table
NB.    Text
NB.    Toc    (table of contents)
NB.    ... etc.
NB.
NB. Note that a section may contain a section
NB.
NB. Contents is a 3 column table of:
NB.   level;shortname;longname

NB. PDFreader=: PDFREADER_j_
getPDFreader=: 3 : 0
if. 0~: 4!:0 <'PDFREADER_j_' do.
  ''
else.
  PDFREADER_j_
end.

ShowFrames=: 0

addcontents=: 3 : 'Contents__locS=: Contents,y'

NB. =========================================================
newsection=: 3 : 0
cocurrent locS
y newinstance 'ppubsection'
)

NB. =========================================================
newurl=: 3 : 0
cocurrent locS
if. (<y) e. UrlIds do. return. end.
y newinstance 'ppuburl'
)

NB. =========================================================
newxobject=: 3 : 0
cocurrent locS
y newinstance 'ppubxobject'
)

NB. =========================================================
newplot=: 3 : 0
cocurrent locS
y newinstance 'ppubplot'
)
