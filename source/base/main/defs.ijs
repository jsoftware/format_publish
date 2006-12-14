NB. defs

NB. =========================================================
Padchar=: 'W' NB. pad/spacer for PDF output W=widest
Txm_port=: '1 0 0 1 '
Txm_land=: '0 1 -1 0 '

NB. =========================================================
NB. page sizes:
PSletter=: 612 792    NB. 72 * 8.5 11
PSa4=: 595.28 841.89  NB. 72 * 210 297 % 25.4

NB. =========================================================
setdefaults=: 3 : 0
NB. 0!:100 RWdefaults
NB. 0!:100 MyRWdefaults
locS=: coname''
buf=: ''
Sections=: ''
Level=: ''
Urls=: UrlIds=: ''
XObjects=: ''
Plots=: ''
)

NB. =========================================================
pageinit=: 3 : 0
'Px Py Pw Ph'=: Pxywh=: 0 0,PAGESIZE
'Lm Tm Rm Bm'=: PAGEMARGINS
setframe Pxywh shrinkmargins PAGEMARGINS
setdraw Fxywh
)