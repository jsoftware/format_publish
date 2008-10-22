NB. pubman nouns
NB.
NB. file are full pathnames with extension
NB.
NB. paths have a trailing path separator
NB.
NB. internally, all paths use / separator and are
NB. converted to host separator on display
NB.
NB. PUBFILE           current pubman file
NB. PUBPATH           corresponding path
NB.
NB. PUBPID            top level path
NB. PUBFILES          list of pubman files at PUBPID level
NB.
NB. PUBRECFILES       recent pubman files
NB.
NB. ---------------------------------------------------------
NB. read from the pubman file:
NB. TEXTFILES         text files
NB. STYLEFILES        style files
NB. SCRIPTFILES       script files
NB. OTHERFILES        other files
NB.
NB. ---------------------------------------------------------
NB. other:
NB. MAXRECENT         maximum recent files
NB. PUBCFG            pubman configuration file
NB. PUBSNAPS          number of snapshots
NB. PUBSNAPX          snapshot exclusions
NB.
NB. paths
NB.
NB. pubman is run with an argument that is either a pubman file
NB. (*.jpb) or a top-level path.
NB.
NB. If a pubman file is given, the top level path is the parent
NB. directory. The file selection box shows all pubman files in
NB. subdirectories of the top level path

MAXRECENT=: 20
PUBSNAPS=: 5
PUBSNAPX=: ''
PUBCFG=: jpath '~config\pubmancfg.ijs'
PUBOLD=: ''
PUBDEFS=: ;:'OTHERFILES SCRIPTFILES STYLEFILES TEXTFILES'

NB. =========================================================
pubdefs=: 3 : '". each PUBDEFS'

NB. =========================================================
pubreset=: 3 : 0
PUBFILE=: PUBFILES=: PUBPATH=: PUBPID=: PUBRECFILES=: ''
(PUBDEFS)=: <''
)

