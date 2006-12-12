NB. load all edit source files

cocurrent 'jprojsave'
load '~Publish/base/save/files.ijs'

rel=. jpath '~.Publish/release/'
files=. SOURCEFILES
files=. ((1: + i:&'/') }. ]) each SOURCEFILES
files=. (rel&, @ (,&'.ijs')) each files
load files
