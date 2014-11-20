#!/bin/bash

echo "Running randtrack ... "

#./randtrack 1 50 > randtrack.out
#sort -n randtrack.out > randtrack.outs
echo "STARTING ..." > timing_global_lock
echo "STARTING ..." > timing_tm
echo "STARTING ..." > timing_list_lock
echo "STARTING ..." > timing_element_lock
echo "STARTING ..." > timing_reduction



for prog in global_lock tm list_lock element_lock reduction
do
	echo "STARTING RANDTRACK_$prog"
	for thread_num in 1 2 4
	do
		echo "Running randtrack_$prog with $thread_num threads" 
		echo "NUMBER OF THREAD = $thread_num" >> timingResults/timing_$prog
		for j in {1..5}
		do
		   echo "Running randtrack_$prog with $thread_num thread for $j time ..." 
		   (/usr/bin/time ./randtrack_$prog $thread_num 50 >> randtrack_$prog.out) &>> timingResults/timing_$prog
		done
	done
done

