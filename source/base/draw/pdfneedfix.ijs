

NB. =========================================================
pdfcircle=: 3 : 0
'v s f e c p'=. y
if. isempty c do.
  if. is1color e do.
    pbuf e pdf_pen v
    clr=. (#p) $ citemize pdf_color e
    for_i. i.#p do.
      pbuf i{clr
      pos=. pdf_circle i{p
      mov=. (pfmt 2 {. {. pos) , ' m '
      pbuf mov
      crv=. (pfmt 2 }."1 pos) ,"1 ' c '
      pbuf crv
      pbuf 'B'
    end.
  end.
end.
)

NB. =========================================================
pdfdot=: 3 : 0
'v s f e c p'=. y
pbuf e pdf_pen v
for_i. i.#p do.
  pos=. pdf_circle (i{p), v
  pbuf (pfmt 2 {. {. pos) , ' m '
  pbuf (pfmt pos) ,"1 ' c '
  pbuf 'B'
end.
)

NB. =========================================================
NB. set graph box clipping
pdffxywh=: 3 : 0
p=. _1 pick y
if. #p do.
  PDFClip=: >: PDFClip
  pbuf 'q ',(":p),' re W n'
else.
  if. PDFClip do.
    PDFClip=: <: PDFClip
    pbuf 'Q'
  end.
end.
)

NB. =========================================================
NB. pdfline
pdfline=: 3 : 0
'v s f e c p'=. y
if. (is1color e) *. 1 = #s do.
  pbuf e pdf_pen v
  pbuf pdf_lines p
else.
  rws=. #p
  e=. rws $ citemize e
  v=. rws $ v
  pen=. e pdf_pens v
  pbuf pen ,. pdf_lines p
end.
)

NB. =========================================================
pdfmarker=: 3 : 0
's m f e c p'=. y
pbuf e pdf_pen 1
s ('pdfmark_',m)~ citemize p
)

NB. =========================================================
pdfpie=: 3 : 0
'v s f e c p'=. y
pbuf e pdf_pen v
clr=. (pdf_colorfill c),"1 pdf_colorstroke e
clr=. (#p) $ citemize clr
for_i. i.#p do.
  pbuf i{clr
  pos=. bezierarc i{p
  pbuf (pfmt 2{.i{p), ' m ',(pfmt 2{.{.pos),' l '
  pbuf (pfmt 2}."1 pos),"1 ' c '
  pbuf 'b'
end.
)

NB. =========================================================
NB. pdfline - patterned line
pdfpline=: 3 : 0
'v s f e c p'=. y
if. *./ s = 0 do.
  pdfline y return.
end.
s=. s { PENPATTERN
if. (is1color e) *. 1 = #v do.
  pos=. s linepattern"0 1 p
  pdfline (<pos) _1 } y
else.
  rws=. #p
  e=. rws $ citemize e
  v=. rws $ v
  s=. rws $ s
  for_i. i.#p do.
    pos=. (i{s) linepattern i{p
    pdfline (i{v);0;0;(i{e);0;pos
  end.
end.
)

NB. =========================================================
pdfpoly=: 3 : 0
'v s f e c p'=. y
pbuf e pdf_pen v
clr=. (pdf_colorfill c),"1 pdf_colorstroke e
pos=. (pdf_makelines p) ,"1 (v=0) pick ' b';' h f'
pbuf clr ,"1 pos
)

NB. =========================================================
pdfrect=: 3 : 0
'v s f e c p'=. y
p=. pdf_boxrs2wh p
NB. PDF has no line-width 0
if. v=0 do.
  clr=. (pdf_colorfill c),"1 pdf_colorstroke c
else.
  pbuf e pdf_pen v
  clr=. (pdf_colorfill c),"1 pdf_colorstroke e
end.
pbuf clr ,"1 (pfmt p) ,"1 ' re B'
)

NB. =========================================================
NB. pdf_circle
NB.
NB. returns bezier points to draw circle
NB. with given center and radius
NB.
NB. result is 4 row table, each row being a 90 degree arc.
pdf_circle=: 3 : 0
'x y r'=. y
arc=. _2 [\ 0 1 2 1 1 2 1 0 { 0 1, 4r3*<:%:2
arr=. |."1 arc *"1 [ _1 1
mat=. _4 ,\ arc,arr,-arc,arr
(mat * r) + ($mat) $ x,y
)

NB. =========================================================
pdf_colorstroke=: 3 : 0
(": y % 255),"1 ' RG '
)

NB. =========================================================
pdf_colorfill=: 3 : 0
(": y % 255),"1 ' rg '
)

NB. =========================================================
pdf_color=: 3 : 0
clr=. ": y % 255
clr ,"1 ' RG ' ,"1 clr ,"1 ' rg '
)

NB. =========================================================
pdf_makelines=: 3 : 0
if. 2 > #$y do.
  ,: (pfmt 2 {. y),' m ',,(pfmt _2 [\ 2 }. y) ,"1 ' l '
else.
  mov=. (pfmt 2 {."1 y) ,"1 ' m '
  lns=. ,"2 (pfmt _2 [\"1 [ 2 }."1 y) ,"1 ' l '
  mov,.lns
end.
)

NB. =========================================================
NB. codes to set pen
NB.
NB. pdf_pen    one color, one size
NB. pdf_pens   several colors, several sizes
pdf_pens=: 4 : 0
(pdf_color x) ,"1 (":,.PDF_PENSCALE*y) ,"1 ' w '
)

NB. =========================================================
pdf_pen=: 4 : 0
(pdf_color ,x), (":PDF_PENSCALE*y) ,' w '
)

NB. =========================================================
pdf_lines=: 3 : 0
(pdf_makelines y) ,"1 ' S'
)

