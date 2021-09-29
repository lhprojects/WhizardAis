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
#   t,tbar processes 
#
tt_dtdtutdtutdt    e1,E1 down_type_q,down_type_q,down_type_q,up_type_q,down_type_q,up_type_q       omega w:c,c
tt_dtdtutdtlv      e1,E1 down_type_q,down_type_q,down_type_q,up_type_q,lepton,neutrino             omega w:c,c
tt_dtdtlvlv        e1,E1 down_type_q,down_type_q,lepton,neutrino,lepton,neutrino                   omega w:c,c
#
#   Z,W,W processes
zww_utututdtutdt     e1,E1 up_type_q,up_type_q,down_type_q,up_type_q,down_type_q,up_type_q         omega w:c,c
zww_utututdtlv       e1,E1 up_type_q,up_type_q,down_type_q,up_type_q,lepton,neutrino               omega w:c,c
zww_ututlvlv         e1,E1 up_type_q,up_type_q,lepton,neutrino,lepton,neutrino                     omega w:c,c
zww_vvutdtutdt       e1,E1 neutrino,neutrino,down_type_q,up_type_q,down_type_q,up_type_q           omega w:c,c
zww_vvutdtlv         e1,E1 neutrino,neutrino,down_type_q,up_type_q,lepton,neutrino                 omega w:c,c
zww_vvlvlv           e1,E1 neutrino,neutrino,lepton,neutrino,lepton,neutrino                       omega w:c,c
zww_llutdtutdt       e1,E1 lepton,lepton,down_type_q,up_type_q,down_type_q,up_type_q               omega w:c,c
zww_llutdtlv         e1,E1 lepton,lepton,down_type_q,up_type_q,lepton,neutrino                     omega w:c,c
zww_lllvlv           e1,E1 lepton,lepton,lepton,neutrino,lepton,neutrino                           omega w:c,c
#
#   Z,Z,Z processes
zzz_uuuuuu           e1,E1 up_type_q,up_type_q,up_type_q,up_type_q,up_type_q,up_type_q             omega w:c,c
zzz_uuuull           e1,E1 up_type_q,up_type_q,up_type_q,up_type_q,lepton,lepton                   omega w:c,c
zzz_uuuunn           e1,E1 up_type_q,up_type_q,up_type_q,up_type_q,neutrino,neutrino               omega w:c,c
zzz_uullll           e1,E1 up_type_q,up_type_q,lepton,lepton,lepton,lepton                         omega w:c,c
zzz_uunnnn           e1,E1 up_type_q,up_type_q,neutrino,neutrino,neutrino,neutrino                 omega w:c,c
zzz_dddddd           e1,E1 down_type_q,down_type_q,down_type_q,down_type_q,down_type_q,down_type_q omega w:c,c
zzz_ddddll           e1,E1 down_type_q,down_type_q,down_type_q,down_type_q,lepton,lepton           omega w:c,c
zzz_ddddnn           e1,E1 down_type_q,down_type_q,down_type_q,down_type_q,neutrino,neutrino       omega w:c,c
zzz_ddllll           e1,E1 down_type_q,down_type_q,lepton,lepton,lepton,lepton                     omega w:c,c
zzz_ddnnnn           e1,E1 down_type_q,down_type_q,neutrino,neutrino,neutrino,neutrino             omega w:c,c
zzz_llllll           e1,E1 lepton,lepton,lepton,lepton,lepton,lepton                               omega w:c,c
zzz_nnnnnn           e1,E1 neutrino,neutrino,neutrino,neutrino,neutrino,neutrino                   omega w:c,c
