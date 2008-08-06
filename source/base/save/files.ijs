NB. files

cocurrent 'jprojsave'

SOURCEPATH=: jpath '~Publish/'
RELEASEPATH=: jpath '~.Publish/release/'
FILES=: jpath '~Publish/base/save/files.ijs'

NB. =========================================================
NB. define source projects - each project builds a file
NB. of the same name in release
SOURCEFILES=: a: -.~ <;._2 (0 : 0)
base/util
base/main
base/build
base/draw
base/font
base/read
base/zlib

classes/group
classes/image
classes/list
classes/page
classes/plot
classes/pre
classes/section
classes/skip
classes/table
classes/text
classes/url
classes/xobject

classes/header
classes/toc

)

NB. base/zlib

NB. =========================================================
NB. set this project last
SOURCELAST=: 'classes/table'
