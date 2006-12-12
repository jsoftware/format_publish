NB. section
NB.
NB. source text is chopped into top-level sections on the <h1>
NB. tag.  Each top-level section starts a new page, and has a
NB. locale in locRW.
NB.
NB. material before the first such tag is the Front Page.

NB. =========================================================
NB. parse a section.
parsesec=: 3 : 0
txt=. parsej y
sec=. StructTags parseml txt
if. 1 e. '<pre>' E. y do.
  sec=. parsepre sec
end.
a=. newsection''
make__a sec
)

NB. =========================================================
parsej=: 3 : 0
txt=. y
msk=. ('<j>' E. txt) > premask txt
if. -. 1 e. msk do. txt return. end.
ndx=. msk i. 1
res=. ndx {. txt
txt=. 3 }. each msk <;.1 txt
for_t. txt do.
  t=. >t
  x=. ('</j>' E. t) i. 1
  exp=. jcmdr x {. t
  res=. res,exp,(x+4) }. t
end.
)

NB. =========================================================
parsepre=: 3 : 0
r=. i.0 4
for_s. y do.
  txt=. 3 pick s
  msk=. '<pre>' E. txt
  if. 1 e. msk do.
    ndx=. msk i. 1
    hdr=. ndx {. txt
    r=. r,(3 {. s),<hdr
    for_t. msk <;.1 txt do.
      t=. >t
      ndx=. 1 i.~ '</pre>' E. t
      r=. r,1;'pre';'';5 }. ndx {. t
      r=. r,_1;'pre';'';(ndx+6) }. t
    end.
  else.
    r=. r,s
  end.
end.
)