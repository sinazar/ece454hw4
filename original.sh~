#!/bin/bash

echo "Running randtrack ... "

echo "STARTING RANDTRACK"
echo "STARTING ..." > timingResults/timing_randtrack

for j in {1..5}
do
   echo "Running randtrack with 1 thread for $j time ..." 
   (/usr/bin/time ./randtrack 1 50 >> randtrack.out) &>> timingResults/timing_randtrack
done

