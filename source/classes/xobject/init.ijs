NB. xobject init
NB.
NB. File   filename
NB. Type   file type
NB. Shape  shape

Shape=: ''

NB. =========================================================
create=: 3 : 0
coinsert locP=: COCREATOR
NAME=: 'Im',":#XObjects
XObjects__locS=: XObjects,coname''
)

NB. =========================================================
add=: 3 : 0
File=: filename y
Type=: tolower (1+File i: '.') }. File
if. Type -: 'jpeg' do. Type=: 'jpg' end.
assert. (<Type) e. 'bmp';'jpg'
Shape=: readshape''
)

NB. =========================================================
read=: 3 : 0
('read',Type)~File
)

NB. =========================================================
readshape=: 3 : 0
dat=. read''
select. Type
case. 'bmp' do.
  $dat
case. 'jpg' do.
  readjpgshape dat
end.
)

