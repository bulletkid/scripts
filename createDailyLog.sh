#!/bin/bash
## Create daily journalling template for next one yr
## NOTE: These can be passed as args and number of remaining weeks can be determined

cur=01
mon=01
year=2021

## Set cur properly
d=$(date -d $year"0101" '+%Y%m01'); w=$(date -d $d '+%w'); i=$(( (8 - $w) % 7));
answer=$(( $d + $i ));
cur=`date -d $answer '+%d'`
echo "Date: $d Cur: $cur"

for i in `seq -f "%02g" 1 1 52`
do
	echo "Week $i"
	for j in `seq 7`
	do
		dateStr=`printf %04d%02d%02d $year $mon $cur`
		echo "Date: $dateStr"

		if [ $cur -gt 27 ]
		then
			err=`date -d $dateStr 2>&1 | grep invalid | wc -l`
			if [ $err -eq 1 ]
			then
				echo "Adjusting date"
				let "cur=1"
				let "mon=mon+1"
				if [ $mon -gt 12 ]
				then
					let "mon=1"
					let "year=year+1"
				fi
				dateStr=`printf %04d%02d%02d $year $mon $cur`
				echo "Adjusted Date: $dateStr"
			fi
		fi
		#echo "Date: $year$mon$cur"
		
		#cp DailyLog.md $year$mon$cur".md"
		let "cur=cur+1"
	done 
done






####cp createDailyLog.sh DailyLog.md
##for i in `seq 1 1 52`
##do
##	##echo Operating on Week_$i
##	##mkdir -p tmp/Week_$i
##	##cd tmp/Week_$i
##	##cp ../../DailyLog.md .
##	for j in `seq 7`
##		do
##			if [ $cur -gt 27 ]
##			then
##				dateStr=$year$mon$cur
##				err=`date -d $dateStr 2>&1 | wc -l`
##				if [ $err -eq 1 ]
##				then
##					echo "Adjusting date"
##					let "cur=1"
##					let "mon=mon+1"
##				fi
##			fi
##			echo "Date: $year$mon$cur"
##			
##			#cp DailyLog.md $year$mon$cur".md"
##			let "cur=cur+1"
##		done 
##done
