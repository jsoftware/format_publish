NB. pubman config

NB. =========================================================
CFGHDR=: ; < @ ('NB. '&,) ;.2 (0 : 0)
Publish configuration

defines:
PUBRECFILES        recent pubman files
)

NB. =========================================================
NB. add to recent files:
pubaddrecent=: 3 : 0
recfiles=. ~. (<PUBFILE),PUBRECFILES
PUBRECFILES=: ({.~ MAXRECENT <. #) recfiles
pubcfgsave''
)

NB. =========================================================
NB. pubcfgread
pubcfgread=: 3 : 0
PUBRECFILES=: ''
try. 0!:0 <PUBCFG catch. end.
PUBRECFILES=: cutLF jpathsep PUBRECFILES
EMPTY
)

NB. =========================================================
pubcfgsave=: 3 : 0
PUBRECFILES=: fexists PUBRECFILES
recfiles=. 'PUBRECFILES' nounrep tolist PUBRECFILES
dat=. CFGHDR,LF,recfiles
dat fwritesnew PUBCFG
)

