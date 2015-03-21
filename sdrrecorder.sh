#########################################################
#							#
# sdrrecorder v1.0 by MichelinoK			#
#							#
# Let you record i/q stream and reencode it to be used	#
# in gqrx						#
#							#
# ./megascript hh:mm mm/dd/yyyy mins filename		#
#							#
# example:						#
#							#
# ./sdrrecorder.sh 12:52 12/21/2014 6 primo		#
#							#
#=======================================================#
# REMOVE '-X' if not using MichelinoK's modded packages #
# MichelinoK's moddem package can be found here:	#
#							#
#	https://github.com/michelinok/rtl-sdr/		#
#							#
# It adds the ability to enable RTL AGC on rtl_sdr	#
#########################################################


#!/bin/bash
freq=145800000		# ...so gqrx center must be on 146100000   ( i use  145800000 for iss)
fwshift=300000          # this is freqtuned-yourfreq (will tune to freq+fwshift) (i use 300000Hz as shift)
samprate=1200000        # recording samplerate
donglenum=1             # dongle number to be used
gain=0                  # gain to be used , i use auto
ppm=15                  # ppm correction
dest=/media             # destination folder

let samplestorec=$3*60*$samprate
let tuneto=$freq+$fwshift

#shbuilt=$4.sh		#maybe not needed....need to check!


echo '#!/bin/bash' > $dest'/'$4.sh
echo 'rtl_sdr -f '$tuneto ' -d '$donglenum ' -s '$samprate ' -p '$ppm ' -g '$gain ' -n '$samplestorec ' -X '$dest'/'$4 >> $dest'/'$4.sh
echo 'sox -t raw -r '$samprate' -b 8 -c 1 -e unsigned-integer '$dest'/'$4' -t raw -r '$samprate' -c 1 -e float '$dest'/'$4'.out' >> $dest'/'$4.sh
echo 'rm '$dest'/'$4 >> $dest'/'$4.sh
echo 'rm '$dest'/'$4'.sh' >> $dest'/'$4.sh
chmod a+x $dest/$4.sh

at $1 $2 -f $dest/$4.sh
