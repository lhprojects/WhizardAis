# WHIZARD configuration file

# The selected model (O'Mega)
model	SM

# Processes for test8
# (Methods: chep=CompHEP, mad=MadGraph, omega=O'Mega)
# (Options: s=selected diagrams, number=QCD order [Madgraph])
#           f=fudged width [O'Mega]
#
# Tag    	In      Out     	Method	Option
#=====================================================
#########################################################################
#

#opqrstuvwxyz
#XXXXXXXXXXXX
#abcdefghijklmn
#
alias f u:d:s:c:b:e1:e2:e3:n1:n2:n3
alias F U:D:S:C:B:E1:E2:E3:N1:N2:N3
alias q u:d:s:c:b
alias Q U:D:S:C:B
alias l e1:e2:e3
alias L E1:E2:E3
alias n n1:n2:n3
alias N N1:N2:N3

# Tree ffh process
#ffh      e1,E1  f,F,h                  omega  w:c,c
#llh      e1,E1  l,L,h                  omega  w:c,c
nnh      e1,E1  n,N,h                  omega  w:c,c
qqh      e1,E1  q,Q,h                  omega  w:c,c
#
uuh      e1,E1  u,U,h                  omega  w:c,c
ddh      e1,E1  d,D,h                  omega  w:c,c
ssh      e1,E1  s,S,h                  omega  w:c,c
cch      e1,E1  c,C,h                  omega  w:c,c
bbh      e1,E1  b,B,h                  omega  w:c,c
#
e1e1h    e1,E1  e1,E1,h                omega  w:c,c
e2e2h    e1,E1  e2,E2,h                omega  w:c,c
e3e3h    e1,E1  e3,E3,h                omega  w:c,c
n1n1h    e1,E1  n1,N1,h                omega  w:c,c
n2n2h    e1,E1  n2,N2,h                omega  w:c,c
n3n3h    e1,E1  n3,N3,h                omega  w:c,c
