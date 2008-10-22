NB. this script builds each grid source file,
NB. and runs before the saveall build

cocurrent 'jprojsave'

'load'~ jpath '~Publish/base/save/files.ijs'
'require'~ 'dates files strings'

NB. =========================================================
FOOTER=: 0 : 0
cocurrent 'ppublish'
publishconfig''
cocurrent 'base'
)

NB. =========================================================
NB. clean up release dir:
cleanrelease=: 3 : 0
ferase 1 dir RELEASEPATH,'*.ijs'
)

NB. =========================================================
makeprojfile=. 3 : 0
nam=. (*./\. y ~: '/') # y
SOURCEPATH, y,'/', nam,'.ijp'
)

NB. =========================================================
makesavefile=. 3 : 0
nam=. (*./\. y ~: '/') # y
RELEASEPATH, nam,'.ijs'
)

NB. =========================================================
PROJECTS=: makeprojfile each SOURCEFILES
SAVEFILES=: makesavefile each }:SOURCEFILES
MANFILE=: makesavefile _1 pick SOURCEFILES
LASTPROJECT=: makeprojfile SOURCELAST

NB. =========================================================
NB. do the saves:
cleanrelease''

NB. close Project Manager if open:
3 : 0''
if. wdisparent 'projectform' do.
  closeproject_jproject_''
end.
)

saveproject_jproject_ &> PROJECTS
openpr_jproject_ LASTPROJECT

NB. =========================================================
NB. build the target script:
dat=. ;freads each ~.SAVEFILES
dat=. decomment_jproject_ dat
dat=. dat,LF,FOOTER
dat fwrites jpath '~.Publish/publish.ijs'
dat fwrites jpath '~addons/format/publish/publish.ijs'
dat=. decomment_jproject_ freads MANFILE
dat fwrites jpath '~.Publish/pubman.ijs'
dat fwrites jpath '~addons/format/publish/pubman.ijs'
