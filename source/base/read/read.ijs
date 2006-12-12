NB. readd

NB. =========================================================
NB. read text from files, and resolve includes
readtext=: 3 : 0
txt=. pread y
txt=. delNB txt
inc=. ('<include>' E. txt) > premask txt
if. 0=#inc do. txt return. end.
ndx=. inc i. 1
res=. ndx {. txt
txt=. inc <;.1 txt
for_t. txt do.
  t=. >t
  ndx=. 1 i.~ '</include>' E. t
  assert. ndx <#t
  f=. filename 9 }. ndx {. t
  t=. (ndx+10) }. t
  h=. ''
  select. tolower _4 {. f
  case. '.ijs' do.
    jcmd pread f
  case. '.sty' do.
    0!:100 pread f
  case. '.txt' do.
    h=. readtext f
  case. do.
    assert. 0
  end.
  res=. res,h,t
end.
trimWS res
)

