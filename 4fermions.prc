# WHIZARD configuration file

# The selected model
model	SM_CKM

# Processes
#  Methods: chep=CompHEP, mad=MadGraph, omega=O'Mega, test=trivial)
#  Options: s      selected diagrams (CompHEP/MadGraph)
#           r      restricted intermediate state (O'Mega)
#           c      apply exact color algebra (O'Mega)
#           d      Feynman diagram option (O'Mega)
#           n:XXX  coupling order (MadGraph)
#           w:XXX  width scheme (O'Mega)
#           p      transfer polarization (test)
#           u      unit matrix element (test)
#
# Tag    	In      Out     	Method	Option
#=====================================================
   alias q u:d:s:c:b
   alias r u:d:s:c
   alias p u:d:s
   alias x u:c
   alias y d:s:b
   alias v n1:n2:n3
   alias w e2:e3
   alias Q U:D:S:C:B
   alias R U:D:S:C
   alias P U:D:S
   alias X U:C
   alias Y D:S:B
   alias V N1:N2:N3
   alias W E2:E3
#
   alias uq u:U
   alias dq d:D
   alias cq c:C
   alias sq s:S
   alias bq b:B
#
   alias electron e1:E1
   alias mu e2:E2
   alias tau e3:E3
#
   alias nu_e n1:N1
   alias nu_mu n2:N2
   alias nu_tau n3:N3
#
   alias up_type_q u:c:U:C
   alias down_type_q d:s:b:D:S:B
   alias not_dq s:b:S:B
   alias not_sq d:b:D:B
#
   alias lepton e1:e2:e3:E1:E2:E3
   alias not_electron e2:e3:E2:E3
#
   alias neutrino n1:n2:n3:N1:N2:N3   
   alias not_nu_tau n1:n2:N1:N2
   alias not_nu_mu n1:n3:N1:N3
   alias not_nu_e n2:n3:N2:N3
#
   alias fermion u:d:c:s:b:e1:e2:e3:n1:n2:n3:U:D:C:S:B:E1:E2:E3:N1:N2:N3
wwbosons e1,E1 W+,W-  omega
zzbosons e1,E1 Z,Z omega 
#-- zz1 e1,E1 up,anti_down,down,anti_up  omega  c, r: 3+6~Z && 4+5~Z || 3+6~A && 4+5~A ||  3+6~A && 4+5~Z ||  3+6~Z && 4+5~A 
#-- zz2 e1,E1 up,anti_up,up,anti_up  omega  c, r: 3+6~Z && 4+5~Z || 3+6~A && 4+5~A ||  3+6~A && 4+5~Z ||  3+6~Z && 4+5~A 
#-- zz3 e1,E1 down,anti_down,down,anti_down  omega  c, r: 3+6~Z && 4+5~Z || 3+6~A && 4+5~A ||  3+6~A && 4+5~Z ||  3+6~Z && 4+5~A 
#-- ww e1,E1 up,anti_down,down,anti_up  omega  c, r: 3+4~W- && 5+6~W+ 
#-- wwfourq e1,E1 q,Q,q,Q  omega  c, r: 3+4~W-&&5+6~W+ || 3+4~W+&&5+6~W- || 3+6~W- && 5+4~W+ ||  3+6~W+ && 5+4~W-  
#-- zz e1,E1 q,Q,q,Q   omega w:c,c, r:  3+4~Z && 5+6~Z || 3+6~Z && 5+4~Z 
#-- fourq e1,E1 q,Q,q,Q   omega w:c,c
#-- wwnoc e1,E1 x,Y,y,X   omega w:c,c 
#--- fourf e1,E1 fermion,fermion,fermion,fermion omega w:c,c
#
#    Fully hadronic
#
#       ZZ : only one flavour, or two but not ud or cs
#
zz_h0utut       e1,E1 up_type_q,up_type_q,up_type_q,up_type_q             omega w:c,c    
zz_h0dtdt       e1,E1 down_type_q,down_type_q,down_type_q,down_type_q     omega w:c,c
zz_h0uu_notd    e1,E1 uq,uq,not_dq,not_dq                                 omega w:c,c
zz_h0cc_nots    e1,E1 cq,cq,not_sq,not_sq                                 omega w:c,c
#
#       WW: more than 2 flavours
#
ww_h0cuxx       e1,E1 cq,down_type_q,uq,down_type_q                       omega w:c,c
ww_h0uubd       e1,E1 uq,bq,uq,dq                                         omega w:c,c
ww_h0uusd       e1,E1 uq,sq,uq,dq                                         omega w:c,c
ww_h0ccbs       e1,E1 cq,bq,cq,sq                                         omega w:c,c
ww_h0ccds       e1,E1 cq,dq,cq,sq                                         omega w:c,c
#
#       ZZ/WW mix: two flavours ud or cs
#
zzorww_h0udud   e1,E1 uq,dq,dq,uq                                         omega w:c,c
zzorww_h0cscs   e1,E1 cq,sq,sq,cq                                         omega w:c,c
#
# Semi-leptonic
#
#      ZZ : qq + two charged or two neutral leptons
#
zz_sl0nu_up     e1,E1 not_nu_e,not_nu_e,up_type_q,up_type_q               omega w:c,c
zz_sl0tau_down  e1,E1 tau,tau,down_type_q,down_type_q                     omega w:c,c
zz_sl0mu_down   e1,E1 mu,mu,down_type_q,down_type_q                       omega w:c,c
zz_sl0nu_down   e1,E1 not_nu_e,not_nu_e,down_type_q,down_type_q           omega w:c,c
zz_sl0tau_up    e1,E1 up_type_q,up_type_q,tau,tau                         omega w:c,c
zz_sl0mu_up     e1,E1 up_type_q,up_type_q,mu,mu                           omega w:c,c
#
#      WW : qq l nu
#
ww_sl0tauq      e1,E1 up_type_q,down_type_q,tau,neutrino                  omega w:c,c
ww_sl0muq       e1,E1 up_type_q,down_type_q,mu,neutrino                   omega w:c,c
#
# leptonic
#
#      ZZ : four charged, or charged and neutral of differnt flavour
#
zz_l04tau       e1,E1 tau,tau,tau,tau                                     omega w:c,c
zz_l04mu        e1,E1 mu,mu,mu,mu                                         omega w:c,c
zz_l0taumu      e1,E1 tau,tau,mu,mu                                       omega w:c,c
zz_l0mumu       e1,E1 nu_tau,nu_tau,mu,mu                                 omega w:c,c
zz_l0tautau     e1,E1 nu_mu,nu_mu,tau,tau                                 omega w:c,c
#
#      WW :  two charged of different flavour
#
ww_l0ll         e1,E1 nu_mu,mu,nu_tau,tau                                 omega w:c,c
#
#      ZZ/WW mix ll nunu, all same flavour
#
zzorww_l0mumu   e1,E1 nu_mu,mu,mu,nu_mu                                   omega w:c,c
zzorww_l0tautau e1,E1 nu_tau,tau,tau,nu_tau                               omega w:c,c
#
#  two electrons or e nue in f.s. 
#
#   Single Z+ee:         two elctrons+ anything except two nu_e  
#
sze_l0tau       e1,E1 electron,electron,tau,tau                           omega w:c,c
sze_l0mu        e1,E1 electron,electron,mu,mu                             omega w:c,c
sze_l0e         e1,E1 electron,electron,electron,electron                 omega w:c,c
sze_sl0dd       e1,E1 electron,electron,down_type_q,down_type_q           omega w:c,c
sze_sl0uu       e1,E1 up_type_q,up_type_q,electron,electron               omega w:c,c
sze_l0nunu      e1,E1 not_nu_e,not_nu_e,electron,electron                 omega w:c,c
#
#   Single W         e nu_e + anything except e nu_e
#
sw_sl0qq        e1,E1 up_type_q,down_type_q,electron,nu_e                 omega w:c,c
sw_l0tau        e1,E1 not_nu_e,tau,electron,nu_e                          omega w:c,c
sw_l0mu         e1,E1 not_nu_e,mu,electron,nu_e                           omega w:c,c
#
#   Single Z/Single W mix: ee e_nu e_nu
#
szeorsw_l0l     e1,E1  nu_e,electron,electron,nu_e                        omega w:c,c
#
#  Single Z + nunu  two nu_e + any pair except two electrons
#
sznu_l0mumu     e1,E1 nu_e,nu_e,mu,mu                                     omega w:c,c
sznu_l0tautau   e1,E1 nu_e,nu_e,tau,tau                                   omega w:c,c
sznu_sl0nu_up   e1,E1 nu_e,nu_e,up_type_q,up_type_q                       omega w:c,c
sznu_sl0nu_down e1,E1 nu_e,nu_e,down_type_q,down_type_q                   omega w:c,c
#
