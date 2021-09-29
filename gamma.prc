# WHIZARD configuration file


# The selected model (O'Mega)
model	SM_CKM


alias l e2:e3
alias L E2:E3
alias v n1:n2:n3
alias V N1:N2:N3
alias x u:c
alias y d:s:b
alias X U:C
alias Y D:S:B

# Processes 0-2-4-fermion
# (Methods: chep=CompHEP, mad=MadGraph, omega=O'Mega)
# (Options: s=selected diagrams, number=QCD order [Madgraph])
#           f=fudged width [O'Mega]
#
# Tag    	In      Out     	Method	Option
#=====================================================
#########################################################################

#

#
#################~/###########################################
# 1-fermion production with photon
ea_ea  	e1,A	e1,A                     	omega	w:c,c
ae_ea  	A,E1	E1,A                     	omega	w:c,c

#

#

#
# 4-fermion production
# type \gamma\gamma or e^- \gamma or \gamma e^+ --> ...
#

aa_ee  	A,A	e1,E1 	                   	omega	w:c,c
aa_ll  	A,A	l,L	                    	omega	w:c,c
aa_xx  	A,A	x,X                     	omega	w:c,c
aa_yy  	A,A	y,Y                     	omega	w:c,c

ea_evv  	e1,A	e1,v,V               	  	omega	w:c,c
ea_lvv  	e1,A	l,v,V                 		omega	w:c,c
ea_vxy  	e1,A	v,X,y                  		omega	w:c,c

ea_exx  	e1,A	e1,x,X	                  	omega	w:c,c
ea_eee  	e1,A	e1,e1,E1        	        omega	w:c,c
ea_ell  	e1,A	e1,l,L	                 	omega	w:c,c
ea_eyy  	e1,A	e1,y,Y	                  	omega	w:c,c

ae_evv  	A,E1	E1,v,V                	 	omega	w:c,c
ae_lvv  	A,E1	L,v,V                	 	omega	w:c,c
ae_vxy  	A,E1	V,x,Y           		omega	w:c,c

ae_exx  	A,E1	E1,x,X	                  	omega	w:c,c
ae_eee  	A,E1	e1,E1,E1                  	omega	w:c,c
ae_ell  	A,E1	E1,l,L    	            	omega	w:c,c
ae_eyy  	A,E1	E1,y,Y	                  	omega	w:c,c
