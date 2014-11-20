#!/bin/bash

echo "Running randtrack ... "

#./randtrack 1 100 > randtrack.out
#sort -n randtrack.out > randtrack.outs
echo "STARTING ..." > timingResults/timing_global_lock100
echo "STARTING ..." > timingResults/timing_tm100
echo "STARTING ..." > timingResults/timing_list_lock100
echo "STARTING ..." > timingResults/timing_element_lock100
echo "STARTING ..." > timingResults/timing_reduction100
#echo "STARTING ..." > timingResults/timing_randtrack100

#for j in {1..5}
#do
#   echo "Running randtrack with 1 thread for $j time ..." 
#   (/usr/bin/time ./randtrack 1 100 >> randtrack.out) &>> timingResults/timing_randtrack100
#done



for prog in global_lock tm list_lock element_lock reduction
do
	echo "STARTING RANDTRACK_$prog"
	for thread_num in 1 2 4
	do
		echo "Running randtrack_$prog with $thread_num threads" 
		echo "NUMBER OF THREAD = $thread_num" >> timingResults/timing_$prog\100
		for j in {1..5}
		do
		   echo "Running randtrack_$prog with $thread_num thread for $j time ..." 
		   (/usr/bin/time ./randtrack_$prog $thread_num 100 >> randtrack_$prog.out) &>> timingResults/timing_$prog\100
		done
	done
done

