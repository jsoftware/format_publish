NB. section

NB. =========================================================
NB. sections
NB.
NB. this runs top-level sections
NB.
NB. Each section is a 3 column table of:
NB.   level;newpage flag;text
NB.
NB. There may be several rows with the same level
NB.
NB. Short name is used for bookmarks, and long name for
NB. table of contents
sections=: 3 : 0
r=. ''
for_s. Sections do.
  setsxywh Dxywh
  r=. r,<draw__s ''
end.
)

