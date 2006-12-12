NB. fixed

NB. =========================================================
NB. get fixed text
NB. remove comments
NB. extract properties
fixedtext=: 3 : 0
txt=. y
var=. -. premask txt
msk=. '' fixedtag txt;var;'comment'
msk=. 'AUTHOR' fixedtag txt;msk;'author'
msk=. 'TITLE' fixedtag txt;msk;'title'
msk=. msk >: var
msk#txt
)

NB. =========================================================
NB. returns updated mask and tag value
fixedtag=: 4 : 0
'txt msk tag'=. y
b=. msk *. ('<',tag,'>') E. txt
e=. msk *. ('</',tag,'>') E. txt
assert. b pairs e
if. 0=+/b do. msk return. end.
b=. I.b
e=. I.e
len=. 2+#tag
ndx=. b (+i.) each 1+len+e-b
tag=. len }. (-1+len) }. (_1 pick ndx) { txt
if. (#x) *. #tag do. (x)=: tag end.
0 (;ndx) } msk
)