#!/bin/bash

for i in {1..5}
do
   /usr/bin/time randtrack 1 50 | grep user >> timeOriginal.txt
   /usr/bin/time randtrack_global_lock 1 50 | grep user >> timeGl.txt
   /usr/bin/time randtrack_tm 1 50 | grep user >> timeTm.txt
   /usr/bin/time randtrack_list_lock 1 50 | grep user >> timeLl.txt
   /usr/bin/time randtrack_element_lock 1 50 | grep user >> timeEl.txt
done

for i in {1..5}
do
   /usr/bin/time randtrack_global_lock 2 50 | grep user >> timeGl2.txt
   /usr/bin/time randtrack_tm 2 50 | grep user >> timeTm2.txt
   /usr/bin/time randtrack_list_lock 2 50 | grep user >> timeLl2.txt
   /usr/bin/time randtrack_element_lock 2 50 | grep user >> timeEl2.txt
done

for i in {1..5}
do
   /usr/bin/time randtrack_global_lock 4 50 | grep user >> timeGl4.txt
   /usr/bin/time randtrack_tm 4 50 | grep user >> timeTm4.txt
   /usr/bin/time randtrack_list_lock 4 50 | grep user >> timeLl4.txt
   /usr/bin/time randtrack_element_lock 4 50 | grep user >> timeEl4.txt
done
