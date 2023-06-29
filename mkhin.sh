#out_base=/afs/ihep.ac.cn/users/m/moxin/scratch/samples/4fermions/
#out_base=/besfs/groups/higgs/data/workarea_mx/samples/2fermions/

#need 4 inputs: process name, higgs production, sqrts, epol, ppol
str1="process_id = \"\""
str2="process_id = \"${1}\""
if [ $# -ne 5 ]; then
echo "correct input needed!"
else
proc=$1 hprod=$2 sqrts=$3 epol=$4 ppol=$5
fi

if [ $epol = "el" ];then
str_epol=" 1.0 0.0"
elif [ $epol = "er" ];then
str_epol=" 0.0 1.0"
elif [ $epol = "e0" ];then
str_epol=" 0.0 0.0"
else
echo "correct epol needed"
fi

if [ $ppol = "pl" ];then
str_ppol=" 1.0 0.0"
elif [ $ppol = "pr" ];then
str_ppol=" 0.0 1.0"
elif [ $ppol = "p0" ];then
str_ppol=" 0.0 0.0"
else
echo "correct ppol needed"
fi

filepath=$out_dir"${proc}_${hprod}.${epol}.${ppol}"

proc_input=" &process_input\n
 process_id = \"${proc}\"\n
 sqrts = ${sqrts}\n
 luminosity = 5600\n
 polarized_beams = T\n
 structured_beams = T\n
 beam_recoil = T\n
! directory =\n
 /\n
"
int_input=" &integration_input\n
  calls = 1 100000 10 100000 1 500000\n
  seed = ${RANDOM}\n
  read_grids = F\n
! read_grids = T\n
! default_mass_cut = 40.\n
! default_q_cut = 40.\n
! phase_space_only = T\n
! accuracy_goal = 10.0\n
! efficiency_goal = 50.0\n
! time_limit_adaptation = 10000\n
/\n
"
sim_input=" &simulation_input\n
 n_events = 1000000\n
 write_events_raw = F\n
 keep_beam_remnants = T\n
 fragment = T\n
 fragmentation_method = 3\n
! OPAL tune\n
  write_events = T\n
  write_events_format = 20\n
  write_events_file = \"${filepath}\"\n
! bytes_per_file = 500000000\n
 events_per_file = 1000\n
 max_file_count = 1000\n
\n
"
#py_para=" pythia_parameters = \"PMAS(25,1)=125.0; PMAS(25,2)=0.0043; MDME(174,1)=0; MDME(175,1)=0; MDME(176,1)=0; MDME(177,1)=0; MDME(178,1)=0; MDME(179,1)=0; MDME(182,1)=0; MDME(183,1)=0; MDME(184,1)=0; MDME(185,1)=0; MDME(186,1)=0; MDME(187,1)=0; MDME(210,1)=0; MDME(211,1)=0; MDME(212,1)=0; MDME(213,1)=0; MDME(214,1)=0; MDME(215,1)=0; MDME(216,1)=0; MDME(217,1)=0; MDME(218,1)=0; MDME(219,1)=0; MDME(220,1)=0; MDME(221,1)=0; MDME(222,1)=0; MDME(223,1)=0; MDME(224,1)=0; MDME(225,1)=0; MDME(226,1)=0; MSTJ(41)=2; MSTU(22)=20; PARJ(21)=0.40000; PARJ(41)=0.11000; PARJ(42)=0.52000; PARJ(81)=0.25000; PARJ(82)=1.90000; PARJ(54)=-0.03100; PARJ(55)=-0.00200; PARJ(1)=0.08500; PARJ(3)=0.45000; PARJ(4)=0.02500; PARJ(2)=0.31000; PARJ(11)=0.60000; PARJ(12)=0.40000; PARJ(13)=0.72000; PARJ(14)=0.43000; PARJ(15)=0.08000; PARJ(16)=0.08000; PARJ(17)=0.17000; MSTP(3)=1; MWID(25)=2\"\n
#!pythia_parameters = \"BRAT(212)=0.00044;BRAT(213)=0.0268;BRAT(214)=0.578;BRAT(219)=0.000221;BRAT(220)=0.0637;\"\n
#!pythia_parameters = \"BRAT(222)=0.0856;BRAT(223)=0.0023;BRAT(224)=0.00155;BRAT(225)=0.0267;\"\n
#!pythia_parameters = \"BRAT(226)=0.216;\"\n
#/\n"
py_para=" pythia_parameters = \"PMAS(25,1)=125.0; PMAS(25,2)=0.3605E-02;\n
  MSTJ(41)=2; MSTU(22)=20; MSTJ(28)=2;\n
  PARJ(21)=0.40000; PARJ(41)=0.11000; PARJ(42)=0.52000; PARJ(81)=0.25000;\n
  PARJ(82)=1.90000; MSTJ(11)=3; PARJ(54)=-0.03100; PARJ(55)=-0.00200;\n
  PARJ(1)=0.08500; PARJ(3)=0.45000; PARJ(4)=0.02500; PARJ(2)=0.31000;\n
  PARJ(11)=0.60000; PARJ(12)=0.40000; PARJ(13)=0.72000; PARJ(14)=0.43000;\n
  PARJ(15)=0.08000; PARJ(16)=0.08000; PARJ(17)=0.17000; MSTP(3)=1;\n"

hdecay_X="  MDCY(23,1)=1; MDCY(25,1)=1; MWID(25)=2;\n
  BRAT(212)=0.00044;BRAT(213)=0.0268;BRAT(214)=0.578;BRAT(219)=0.000221;\n
  BRAT(210)=0.00000057;BRAT(211)=0.00000015;BRAT(220)=0.0637;BRAT(222)=0.0856;BRAT(223)=0.0023;BRAT(224)=0.00155;\n
  BRAT(225)=0.0267;BRAT(226)=0.216\"\n/"

hdecay_dd="  MDCY(23,1)=1; MDCY(25,1)=1; MWID(25)=2;\n
  MDME(210,1)=1;MDME(211,1)=0;MDME(212,1)=0;MDME(213,1)=0;MDME(214,1)=0;MDME(215,1)=0;MEME(218,1)=0;\n
  MDME(219,1)=0;MDME(220,1)=0;MDME(222,1)=0;MDME(223,1)=0;MDME(224,1)=0;MDME(225,1)=0;MDME(226,1)=0;\n
  BRAT(210)=0.00000057;BRAT(211)=0.00000015;BRAT(212)=0.00044;BRAT(213)=0.0268;BRAT(214)=0.578;BRAT(219)=0.000221;\n
  BRAT(220)=0.0637;BRAT(222)=0.0856;BRAT(223)=0.0023;BRAT(224)=0.00155;\n
  BRAT(225)=0.0267;BRAT(226)=0.216\"\n/"

hdecay_uu="  MDCY(23,1)=1; MDCY(25,1)=1; MWID(25)=2;\n
  MDME(210,1)=0;MDME(211,1)=1;MDME(212,1)=0;MDME(213,1)=0;MDME(214,1)=0;MDME(215,1)=0;MEME(218,1)=0;\n
  MDME(219,1)=0;MDME(220,1)=0;MDME(222,1)=0;MDME(223,1)=0;MDME(224,1)=0;MDME(225,1)=0;MDME(226,1)=0;\n
  BRAT(210)=0.00000057;BRAT(211)=0.00000015;BRAT(212)=0.00044;BRAT(213)=0.0268;BRAT(214)=0.578;BRAT(219)=0.000221;\n
  BRAT(220)=0.0637;BRAT(222)=0.0856;BRAT(223)=0.0023;BRAT(224)=0.00155;\n
  BRAT(225)=0.0267;BRAT(226)=0.216\"\n/"

hdecay_ss="  MDCY(23,1)=1; MDCY(25,1)=1; MWID(25)=2;\n
  MDME(210,1)=0;MDME(211,1)=0;MDME(212,1)=1;MDME(213,1)=0;MDME(214,1)=0;MDME(215,1)=0;MEME(218,1)=0;\n
  MDME(219,1)=0;MDME(220,1)=0;MDME(222,1)=0;MDME(223,1)=0;MDME(224,1)=0;MDME(225,1)=0;MDME(226,1)=0;\n
  BRAT(212)=0.00044;BRAT(213)=0.0268;BRAT(214)=0.578;BRAT(219)=0.000221;\n
  BRAT(220)=0.0637;BRAT(222)=0.0856;BRAT(223)=0.0023;BRAT(224)=0.00155;\n
  BRAT(225)=0.0267;BRAT(226)=0.216\"\n/"

hdecay_cc="  MDCY(23,1)=1; MDCY(25,1)=1; MWID(25)=2;\n
  MDME(210,1)=0;MDME(211,1)=0;MDME(212,1)=0;MDME(213,1)=1;MDME(214,1)=0;MDME(215,1)=0;MEME(218,1)=0;\n
  MDME(219,1)=0;MDME(220,1)=0;MDME(222,1)=0;MDME(223,1)=0;MDME(224,1)=0;MDME(225,1)=0;MDME(226,1)=0;\n
  BRAT(212)=0.00044;BRAT(213)=0.0268;BRAT(214)=0.578;BRAT(219)=0.000221;\n
  BRAT(220)=0.0637;BRAT(222)=0.0856;BRAT(223)=0.0023;BRAT(224)=0.00155;\n
  BRAT(225)=0.0267;BRAT(226)=0.216\"\n/"

hdecay_bb="  MDCY(23,1)=1; MDCY(25,1)=1; MWID(25)=2;\n
  MDME(210,1)=0;MDME(211,1)=0;MDME(212,1)=0;MDME(213,1)=0;MDME(214,1)=1;MDME(215,1)=0;MEME(218,1)=0;\n
  MDME(219,1)=0;MDME(220,1)=0;MDME(222,1)=0;MDME(223,1)=0;MDME(224,1)=0;MDME(225,1)=0;MDME(226,1)=0;\n
  BRAT(212)=0.00044;BRAT(213)=0.0268;BRAT(214)=0.578;BRAT(219)=0.000221;\n
  BRAT(220)=0.0637;BRAT(222)=0.0856;BRAT(223)=0.0023;BRAT(224)=0.00155;\n
  BRAT(225)=0.0267;BRAT(226)=0.216\"\n/"

hdecay_tt="  MDCY(23,1)=1; MDCY(25,1)=1; MWID(25)=2;\n
  MDME(210,1)=0;MDME(211,1)=0;MDME(212,1)=0;MDME(213,1)=0;MDME(214,1)=0;MDME(215,1)=1;MEME(218,1)=0;\n
  MDME(219,1)=0;MDME(220,1)=0;MDME(222,1)=0;MDME(223,1)=0;MDME(224,1)=0;MDME(225,1)=0;MDME(226,1)=0;\n
  BRAT(212)=0.00044;BRAT(213)=0.0268;BRAT(214)=0.578;BRAT(219)=0.000221;\n
  BRAT(220)=0.0637;BRAT(222)=0.0856;BRAT(223)=0.0023;BRAT(224)=0.00155;\n
  BRAT(225)=0.0267;BRAT(226)=0.216\"\n/"

hdecay_e1e1="  MDCY(23,1)=1; MDCY(25,1)=1; MWID(25)=2;\n
  MDME(210,1)=0;MDME(211,1)=0;MDME(212,1)=0;MDME(213,1)=0;MDME(214,1)=0;MDME(215,1)=0;MEME(218,1)=1;\n
  MDME(219,1)=0;MDME(220,1)=0;MDME(222,1)=0;MDME(223,1)=0;MDME(224,1)=0;MDME(225,1)=0;MDME(226,1)=0;\n
  BRAT(212)=0.00044;BRAT(213)=0.0268;BRAT(214)=0.578;BRAT(219)=0.000221;\n
  BRAT(220)=0.0637;BRAT(222)=0.0856;BRAT(223)=0.0023;BRAT(224)=0.00155;\n
  BRAT(225)=0.0267;BRAT(226)=0.216\"\n/"

hdecay_e2e2="  MDCY(23,1)=1; MDCY(25,1)=1; MWID(25)=2;\n
  MDME(210,1)=0;MDME(211,1)=0;MDME(212,1)=0;MDME(213,1)=0;MDME(214,1)=0;MDME(215,1)=0;MEME(218,1)=0;\n
  MDME(219,1)=1;MDME(220,1)=0;MDME(222,1)=0;MDME(223,1)=0;MDME(224,1)=0;MDME(225,1)=0;MDME(226,1)=0;\n
  BRAT(212)=0.00044;BRAT(213)=0.0268;BRAT(214)=0.578;BRAT(219)=0.000221;\n
  BRAT(220)=0.0637;BRAT(222)=0.0856;BRAT(223)=0.0023;BRAT(224)=0.00155;\n
  BRAT(225)=0.0267;BRAT(226)=0.216\"\n/"

hdecay_e3e3="  MDCY(23,1)=1; MDCY(25,1)=1; MWID(25)=2;\n
  MDME(210,1)=0;MDME(211,1)=0;MDME(212,1)=0;MDME(213,1)=0;MDME(214,1)=0;MDME(215,1)=0;MEME(218,1)=0;\n
  MDME(219,1)=0;MDME(220,1)=1;MDME(222,1)=0;MDME(223,1)=0;MDME(224,1)=0;MDME(225,1)=0;MDME(226,1)=0;\n
  BRAT(212)=0.00044;BRAT(213)=0.0268;BRAT(214)=0.578;BRAT(219)=0.000221;\n
  BRAT(220)=0.0637;BRAT(222)=0.0856;BRAT(223)=0.0023;BRAT(224)=0.00155;\n
  BRAT(225)=0.0267;BRAT(226)=0.216\"\n/"

hdecay_gg="  MDCY(23,1)=1; MDCY(25,1)=1; MWID(25)=2;\n
  MDME(210,1)=0;MDME(211,1)=0;MDME(212,1)=0;MDME(213,1)=0;MDME(214,1)=0;MDME(215,1)=0;MEME(218,1)=0;\n
  MDME(219,1)=0;MDME(220,1)=0;MDME(222,1)=1;MDME(223,1)=0;MDME(224,1)=0;MDME(225,1)=0;MDME(226,1)=0;\n
  BRAT(212)=0.00044;BRAT(213)=0.0268;BRAT(214)=0.578;BRAT(219)=0.000221;\n
  BRAT(220)=0.0637;BRAT(222)=0.0856;BRAT(223)=0.0023;BRAT(224)=0.00155;\n
  BRAT(225)=0.0267;BRAT(226)=0.216\"\n/"

hdecay_aa="  MDCY(23,1)=1; MDCY(25,1)=1; MWID(25)=2;\n
  MDME(210,1)=0;MDME(211,1)=0;MDME(212,1)=0;MDME(213,1)=0;MDME(214,1)=0;MDME(215,1)=0;MEME(218,1)=0;\n
  MDME(219,1)=0;MDME(220,1)=0;MDME(222,1)=0;MDME(223,1)=1;MDME(224,1)=0;MDME(225,1)=0;MDME(226,1)=0;\n
  BRAT(212)=0.00044;BRAT(213)=0.0268;BRAT(214)=0.578;BRAT(219)=0.000221;\n
  BRAT(220)=0.0637;BRAT(222)=0.0856;BRAT(223)=0.0023;BRAT(224)=0.00155;\n
  BRAT(225)=0.0267;BRAT(226)=0.216\"\n/"

hdecay_az="  MDCY(23,1)=1; MDCY(25,1)=1; MWID(25)=2;\n
  MDME(210,1)=0;MDME(211,1)=0;MDME(212,1)=0;MDME(213,1)=0;MDME(214,1)=0;MDME(215,1)=0;MEME(218,1)=0;\n
  MDME(219,1)=0;MDME(220,1)=0;MDME(222,1)=0;MDME(223,1)=0;MDME(224,1)=1;MDME(225,1)=0;MDME(226,1)=0;\n
  BRAT(212)=0.00044;BRAT(213)=0.0268;BRAT(214)=0.578;BRAT(219)=0.000221;\n
  BRAT(220)=0.0637;BRAT(222)=0.0856;BRAT(223)=0.0023;BRAT(224)=0.00155;\n
  BRAT(225)=0.0267;BRAT(226)=0.216\"\n/"

hdecay_zz="  MDCY(23,1)=1; MDCY(25,1)=1; MWID(25)=2;\n
  MDME(210,1)=0;MDME(211,1)=0;MDME(212,1)=0;MDME(213,1)=0;MDME(214,1)=0;MDME(215,1)=0;MEME(218,1)=0;\n
  MDME(219,1)=0;MDME(220,1)=0;MDME(222,1)=0;MDME(223,1)=0;MDME(224,1)=0;MDME(225,1)=1;MDME(226,1)=0;\n
  BRAT(212)=0.00044;BRAT(213)=0.0268;BRAT(214)=0.578;BRAT(219)=0.000221;\n
  BRAT(220)=0.0637;BRAT(222)=0.0856;BRAT(223)=0.0023;BRAT(224)=0.00155;\n
  BRAT(225)=0.0267;BRAT(226)=0.216\"\n/"

hdecay_ww="  MDCY(23,1)=1; MDCY(25,1)=1; MWID(25)=2;\n
  MDME(210,1)=0;MDME(211,1)=0;MDME(212,1)=0;MDME(213,1)=0;MDME(214,1)=0;MDME(215,1)=0;MEME(218,1)=0;\n
  MDME(219,1)=0;MDME(220,1)=0;MDME(222,1)=0;MDME(223,1)=0;MDME(224,1)=0;MDME(225,1)=0;MDME(226,1)=1;\n
  BRAT(212)=0.00044;BRAT(213)=0.0268;BRAT(214)=0.578;BRAT(219)=0.000221;\n
  BRAT(220)=0.0637;BRAT(222)=0.0856;BRAT(223)=0.0023;BRAT(224)=0.00155;\n
  BRAT(225)=0.0267;BRAT(226)=0.216\"\n/"

decay_info="
! Hdecay mode\n
!   dd            uu            ss            cc            bb            tt            e1e1\n
!  MDME(210,1)=0;MDME(211,1)=0;MDME(212,1)=0;MDME(213,1)=0;MDME(214,1)=0;MDME(215,1)=0;MDME(218,1)=0;\n
!  e2e2           e3e3          gg            gammagamma    gammaZ0       ZZ            WW\n
!  MDME(219,1)=0;MDME(220,1)=0;MDME(222,1)=0;MDME(223,1)=0;MDME(224,1)=0;MDME(225,1)=1;MDME(226,1)=0;\n
! Z decay mode\n
!  dd            uu             ss             cc            bb            tt           e1e1\n
!  MDME(174,1)=0;MDME(175,1)=0;MDME(176,1)=0;MDME(177,1)=0;MDME(178,1)=0;MDME(179,1)=0;MDME(182,1)=0;\n
!  n1n1          e2e2           n2n2           e3e3         n3n3\n
!  MDME(183,1)=1;MDME(184,1)=0;MDME(185,1)=1;MDME(186,1)=0;MDME(187,1)=1;\n
"
diag_input=" &diagnostics_input\n
! show_phase_space = T\n
! time_limit = 10050\n
! chattiness = 5\n
! show_histories = T\n
! show_histograms = T\n
! screen_histograms = T\n
 /\n
"
para_input=" &parameter_input\n
 Me   = 0\n
 Mmu  = 0.10566\n
 Ms   = 0\n
 Mc   = 0\n
 Mb   = 0\n
 MH   = 125\n
 wH   = 0.0043\n
 alphas = 1.e-6\n
/
\n
"
beam_e_input=" &beam_input\n
 particle_name = 'e1'\n
 polarization = ${str_epol}\n 
 USER_spectrum_on = F\n
 USER_spectrum_mode = 22\n
 ISR_on = T\n
 ISR_alpha = 0.0072993\n
 ISR_m_in = 0.000511\n
 EPA_on = F\n
 EPA_alpha = 0.0072993\n
 EPA_m_in = 0.000511\n
 EPA_mX = 4.\n
 EPA_Q_max = 4.\n
 /\n
"

beam_p_input=" &beam_input\n
 particle_name = 'E1'\n
 polarization = ${str_ppol}\n
 USER_spectrum_on = F\n
 USER_spectrum_mode = 22\n
 ISR_on = T\n
 ISR_alpha = 0.0072993\n
 ISR_m_in = 0.000511\n
 EPA_on = F\n
 EPA_alpha = 0.0072993\n
 EPA_m_in = 0.000511\n
 EPA_mX = 4.\n
 EPA_Q_max = 4.\n
 /\n
"
case $hprod in
X)    hdecay=$hdecay_X;;
uu)   hdecay=$hdecay_uu;;
dd)   hdecay=$hdecay_dd;;
cc)   hdecay=$hdecay_cc;;
ss)   hdecay=$hdecay_ss;;
bb)   hdecay=$hdecay_bb;;
tt)   hdecay=$hdecay_tt;;
e1e1) hdecay=$hdecay_e1e1;;
e2e2) hdecay=$hdecay_e2e2;;
e3e3) hdecay=$hdecay_e3e3;;
gg)   hdecay=$hdecay_gg;;
aa)   hdecay=$hdecay_aa;;
az)   hdecay=$hdecay_az;;
zz)   hdecay=$hdecay_zz;;
ww)   hdecay=$hdecay_ww;;
*)    echo "Please set proper higgs decay production!"
esac

echo -e $proc_input"\n"$int_input"\n"$sim_input$py_para$hdecay"\n\n"$diag_input"\n"$para_input"\n"$beam_e_input"\n"$beam_p_input>./whizard.in
