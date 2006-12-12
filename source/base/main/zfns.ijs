NB. zfns
NB.
NB. publish       main definition
NB. publishload   load scripts in master.ijs

NB. =========================================================
publish_z_=: 3 : 0
a=. conew 'publish'
locRW_publish_=: a
res=. publishrun__a y
destroy__a''
res
)

NB. =========================================================
publishload_z_=: 3 : 0
if. -. 1 e. '/\' e. y do.
  loc=. locRW_publish_
  y=. MasterPath__loc,y
end.
load y
)