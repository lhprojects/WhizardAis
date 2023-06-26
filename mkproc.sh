#parameter 1 is option for -p(process) -h(higgs) -a(gamma), parameter 2 is the prc file, parameter 3 is the e_mc
#parameter 4 is the location for the samples

#/afs/ihep.ac.cn/users/m/moxin/besfs
#MOXIN_BESFS=/besfs/groups.orig/higgs/users/moxin
export topdir=$PWD
export softdir=/cefs/higgs/liangh/software3/whizard_deps/
export GCCPATH=/cefs/higgs/liangh/software3/whizard_deps/gcc-4.6.2_install
export PATH_TO_GFORTRAN=${GCCPATH}/bin

export F95=${GCCPATH}/bin/gfortran
export F77=${F95}
export FCFLAGS=" -fPIC -ffree-line-length-0"
export FFLAGS="  -fPIC -ffree-line-length-0"
export CXXFLAGS=" -fPIC "

export CERN=/cefs/higgs/liangh/software3/whizard_deps/cern_lib/cernlib_64
#export CERN=/besfs5/users/manqi/Software/Generator/cernlib_64
export CERN_LEVEL=2005
export CERN_ROOT=${CERN}/${CERN_LEVEL}
export CVSCOSRC=${CERN}/${CERN_LEVEL}/src

export COPIED_LIBS=/cefs/higgs/liangh/software3/whizard_deps/copied_libs
export HEPMC_DIR=/cefs/higgs/liangh/software3/whizard_deps/HepMC2
export OCAML_DIR=/cefs/higgs/liangh/software3/whizard_deps/ocaml-3.12.1-install
export STDHEP_DIR=$COPIED_LIBS
export TAUOLALIB=/workfs2/bes/lig/higgs/generator/tauola/tauola_desy/TAUOLA/tauola
export PHOTOSLIB=/workfs2/bes/lig/higgs/generator/tauola/tauola_desy/TAUOLA/photos


for dir in $CERN $CERN_ROOT $HEPMC_DIR $OCAML_DIR $STDHEP_DIR $TAUOLALIB $PHOTOSLIB $COPIED_LIBS
do
    echo $dir
    ls $dir
done

export PATH=${OCAML_DIR}/bin:${GCCPATH}/bin:${PATH_TO_GFORTRAN}:${CERN_ROOT}/bin:${PATH}
export LD_LIBRARY_PATH=$COPIED_LIBS:${OCAML_DIR}/lib/ocaml:${GCCPATH}/lib64:${GCCPATH}/lib:$LD_LIBRARY_PATH

echo "uzip file"
cd ${topdir}
mkdir -p whizard-1.95
tar -xzvf ${softdir}/whizard-1.95-lc.tar.gz -C ${topdir}/whizard-1.95
cd  whizard-1.95


echo ./configure --enable-pythia --enable-stdhep --enable-chep --enable-mad --enable-omega \
    USERLIBS="$(pwd)/a6f/include/pytaud.o $(pwd)/a6f/lib/libinclude.a $TAUOLALIB/libtauola.a $PHOTOSLIB/libphotos.a"

./configure --enable-pythia --enable-stdhep --enable-chep --enable-mad --enable-omega \
	USERLIBS="$(pwd)/a6f/include/pytaud.o $(pwd)/a6f/lib/libinclude.a $TAUOLALIB/libtauola.a $PHOTOSLIB/libphotos.a"
	
make libs
make -C a6f/include/ A6F=.. WHIZ=../.. WH195=../.. SHELL=/bin/bash

echo "make completed"


workspace=$topdir"/"
name=${2%%.*}
out_base=$4"/"
whizard=$topdir"/whizard-1.95/"
con_base=$workspace
cd $topdir
echo $1

case $1 in
	-p) shift
		mkdir -p $workspace$name
		df=`diff $1 $whizard"conf/whizard.prc"`
		if [[ $df != "" ]]
		then
			/bin/cp -f $1 $whizard"conf/whizard.prc"
			cd $whizard
			make prg install
		fi
		cd $workspace$name
		echo "for dir in \`ls\`
	do
		for file in \`ls \$dir | grep .pbs\`
		do
			hep_sub \$dir/\$file
		done
	done">sub_all.sh
	cd $topdir
	while read line
	do
		if [[ $line != *alias* && $line != \#* && $line != model* && $line != "" ]] 
		then
			proc=${line%% *}
			procname=${proc%%0*}
			fs=${proc##*0}
			if [ ! -d $workspace${name}/E$2.P${proc}.e0.p0.whizard195 ]
			then
				cp ${whizard}results $workspace${name}/E$2.P${proc}.e0.p0.whizard195/ -rf
			fi
			cp mkin.sh $workspace${name}/E$2.P${proc}.e0.p0.whizard195 -f
			cd $workspace${name}/E$2.P${proc}.e0.p0.whizard195/
			out_dir=$out_base$name/E$2.P${procname}.e0.p0.whizard195/
			mkdir -p $out_dir
			. mkin.sh $proc $2 "e0" "p0"
			echo "source /afs/ihep.ac.cn/users/m/moxin/setup/whizard1.95-setup.sh
			cd ${workspace}${name}/E$2.P${proc}.e0.p0.whizard195/
			./whizard" >${proc}.e0.p0.pbs
			chmod +x ${proc}.e0.p0.pbs
			cd $topdir
		fi
	done<$1
	;;

	#para 1 is higgs.prc, para 2 is the e_mc
	-h) shift
	mkdir -p $workspace${name}
	df=`diff $1 $whizard/conf/whizard.prc`
	if [[ $df != "" ]]
	then
		/bin/cp -f $1 $whizard"conf/whizard.prc"
		cd $whizard
		make prg install
	fi
	cd $workspace$name
	echo "for dir in \`ls\`
do
	for file in \`ls \$dir | grep .pbs\`
	do
		hep_sub \$dir/\$file
	done
done">sub_all.sh
cd $topdir
while read line
do
	if [[ $line != *alias* && $line != \#* && $line != model* && $line != "" ]] 
	then
		proc=${line%% *}
		for hprod in "gg" "bb" "cc" "uu" "dd" "ss"
		do
			if [ ! -d $workspace${name}/E$2.P${proc}_${hprod}.e0.p0.whizard195 ]
			then
				cp ${whizard}results "$workspace${name}/E$2.P${proc}_${hprod}.e0.p0.whizard195" -rf
				printf "process higgs\n" >  "$workspace${name}/E$2.P${proc}_${hprod}.e0.p0.whizard195/whizard.cut1"
			fi
			cp mkhin.sh $workspace${name}/E$2.P${proc}_${hprod}.e0.p0.whizard195 -f
			cd $workspace${name}/E$2.P${proc}_${hprod}.e0.p0.whizard195
			out_dir=$out_base${name}/E$2.P${proc}_${hprod}.e0.p0.whizard195/
			mkdir -p $out_dir
			. mkhin.sh $proc $hprod $2 "e0" "p0"
			echo "source /afs/ihep.ac.cn/users/m/moxin/setup/whizard1.95-setup.sh
			cd ${workspace}${name}/E$2.P${proc}_${hprod}.e0.p0.whizard195/
			./whizard" >${proc}_${hprod}.e0.p0.pbs
			chmod +x ${proc}_${hprod}.e0.p0.pbs
			cd $topdir
		done
	fi
done<$1
;;

-a) shift
	mkdir -p $workspace$name
	df=`diff $1 $whizard/conf/whizard.prc`
	if [[ $df != "" ]]
	then
		/bin/cp -f $1 $whizard"conf/whizard.prc"
		cd $whizard
		make prg install
	fi
	cd $workspace$name
	echo "for dir in \`ls\`
do
	for file in \`ls \$dir | grep .pbs\`
	do
		hep_sub \$dir/\$file
	done
done">sub_all.sh
cd $topdir
while read line
do
	if [[ $line != *alias* && $line != \#* && $line != model* && $line != "" ]]
	then
		proc=${line%% *}
		procname=${proc%%_*}
		fs=${proc##*_}

		if [ $procname = "ae" ]; then
			for eb in "aB" "eW"
			do
				pb="pB"
				if [ ! -d $workspace${name}/E$2.P${proc}.${eb}.${pb}.whizard195 ]
				then
					cp ${whizard}results $workspace${name}/E$2.P${proc}.${eb}.${pb}.whizard195/ -rf
				fi
				cp mkgammain.sh $workspace${name}/E$2.P${proc}.${eb}.${pb}.whizard195 -f
				cd $workspace${name}/E$2.P${proc}.${eb}.${pb}.whizard195/
				out_dir=$out_base$name/E$2.P${proc}.${eb}.${pb}.whizard195/
				mkdir -p $out_dir
				. mkgammain.sh $proc $2 $eb $pb
				echo "source /afs/ihep.ac.cn/users/m/moxin/setup/whizard1.95-setup.sh
				cd ${workspace}${name}/E$2.P${proc}.${eb}.${pb}.whizard195/
				./whizard" >${proc}.${eb}.${pb}.pbs
				chmod +x ${proc}.${eb}.${pb}.pbs
				cd $topdir
			done
		fi

		if [ $procname = "ea" ]; then
			for pb in "aB" "pW"
			do
				eb="eB"
				if [ ! -d $workspace${name}/E$2.P${proc}.${eb}.${pb}.whizard195 ]
				then
					cp ${whizard}results $workspace${name}/E$2.P${proc}.${eb}.${pb}.whizard195/ -rf
				fi
				cp mkgammain.sh $workspace${name}/E$2.P${proc}.${eb}.${pb}.whizard195 -f
				cd $workspace${name}/E$2.P${proc}.${eb}.${pb}.whizard195/
				out_dir=$out_base$name/E$2.P${proc}.${eb}.${pb}.whizard195/
				mkdir -p $out_dir
				. mkgammain.sh $proc $2 $eb $pb
				echo "source /afs/ihep.ac.cn/users/m/moxin/setup/whizard1.95-setup.sh
				cd ${workspace}${name}/E$2.P${proc}.${eb}.${pb}.whizard195/
				./whizard" >${proc}.${eb}.${pb}.pbs
				chmod +x ${proc}.${eb}.${pb}.pbs
				cd $topdir
			done
		fi

		if [ $procname = "aa" ]; then
			for pb in "aB" "pW"
			do
				for eb in "aB" "eW"
				do
					if [ ! -d $workspace${name}/E$2.P${proc}.${eb}.${pb}.whizard195 ]
					then
						cp ${whizard}results $workspace${name}/E$2.P${proc}.${eb}.${pb}.whizard195/ -rf
					fi
					cp mkgammain.sh $workspace${name}/E$2.P${proc}.${eb}.${pb}.whizard195 -f
					cd $workspace${name}/E$2.P${proc}.${eb}.${pb}.whizard195/
					out_dir=$out_base$name/E$2.P${proc}.${eb}.${pb}.whizard195/
					mkdir -p $out_dir
					. mkgammain.sh $proc $2 $eb $pb
					echo "source /afs/ihep.ac.cn/users/m/moxin/setup/whizard1.95-setup.sh
					cd ${workspace}${name}/E$2.P${proc}.${eb}.${pb}.whizard195/
					./whizard" >${proc}.${eb}.${pb}.pbs
					chmod +x ${proc}.${eb}.${pb}.pbs
					cd $topdir
				done
			done
		fi

	fi

done<$1
;;

*) echo "wrong option";;
esac
