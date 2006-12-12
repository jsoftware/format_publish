NB. zip
NB.
NB. main functions:
NB. 
NB.  to zip from
NB.  to unzip from
NB.     readzip from

uint2=: 0 & ic

NB. =========================================================
NB. note i86 byte order
uint4=: 3 : 0
(65536 * uint2 2}.y.) + uint2 2{.y.
)

gzopen=: 'gzopen i *c *c' makezlib
gzdopen=: 'gzdopen i i *c' makezlib
gzread=: 'gzread i * * i' makezlib
gzwrite=: 'gzwrite i * * i' makezlib
gzclose=: 'gzclose i *' makezlib

NB. =========================================================
NB. to zip from
NB. returns number of uncompressed bytes written
zip=: 4 : 0
to=. x.
fm=. y.
if. -. fexist fm do. _1 return. end.
JCHAR map_jmf_ 'infil';fm
insz=. #infil__
map=. showmap_jmf_''
inaddr=. 5{ ,('infil_base_' findkey_jmf_ map){map
gzout=. gzopen to;'wb1'
gzfaddr=. {.gzout
len=. gzwrite gzfaddr;inaddr;insz
ret=. gzclose <gzfaddr
unmap_jmf_ 'infil'
>{.len
)

NB. =========================================================
NB. to unzip from
NB. returns number of uncompressed bytes written
unzip=: 4 : 0
to=. x.
fm=. y.
JCHAR map_jmf_ 'infil';fm
outsz=. {. uint4 _4{.infil__
unmap_jmf_'infil'
pout=. mema outsz
res=. gzopen fm;'rb'
gzfaddr=. {. res
gzread gzfaddr;(<pout);outsz
outdat=. memr pout,0,outsz
outdat fwrite to
gzclose <gzfaddr
memf pout
outdat fwrite to
)

NB. =========================================================
NB. readzip
NB. reads compressed file y.
NB. returns file contents
readzip=: 3 : 0
fm=. y.
if. -.fexist fm do.
  empty''
  return.
end.
JCHAR map_jmf_ 'infil';fm
outsz=. {. uint4 _4{.infil__
unmap_jmf_'infil'
pout=. mema outsz
res=. gzopen fm;'rb'
gzfaddr=. {. res
gzread gzfaddr;(<pout);outsz
outdat=. memr pout,0,outsz
gzclose <gzaddr
memf pout
outdat
)
