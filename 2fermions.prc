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
alias electron e1:E1

# Tree ffh process
#ff      e1,E1  f,F                  omega  w:c,c
#ll      e1,E1  l,L                  omega  w:c,c
nn      e1,E1  n,N                  omega  w:c,c
qq      e1,E1  q,Q                  omega  w:c,c
#
uu      e1,E1  u,U                  omega  w:c,c
dd      e1,E1  d,D                  omega  w:c,c
ss      e1,E1  s,S                  omega  w:c,c
cc      e1,E1  c,C                  omega  w:c,c
bb      e1,E1  b,B                  omega  w:c,c
tt      e1,E1  t,T                  omega  w:c,c
#
#e1e1    e1,E1  e1,E1                omega  w:c,c
e2e2    e1,E1  e2,E2                omega  w:c,c
e3e3    e1,E1  e3,E3                omega  w:c,c
n1n1    e1,E1  n1,N1                omega  w:c,c
n2n2    e1,E1  n2,N2                omega  w:c,c
n3n3    e1,E1  n3,N3                omega  w:c,c
#
bhabha  e1,E1   electron,electron,A  omega  w:c,c
