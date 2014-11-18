
CC = g++-4.7
CFLAGS = -O3

all: randtrack 

randtrack: list.h hash.h defs.h randtrack.cc
	$(CC) $(CFLAGS) -lpthread randtrack.cc -o randtrack
	
randtrack_global_lock: list.h hash.h defs.h randtrack_global_lock.cc
	$(CC) $(CFLAGS) -lpthread randtrack_global_lock.cc -o randtrack_global_lock
	
randtrack_tm: list.h hash.h defs.h randtrack_tm.cc
	$(CC) $(CFLAGS) -lpthread randtrack_tm.cc -o randtrack_tm
	
randtrack_list_lock: list.h hash.h defs.h randtrack_list_lock.cc
	$(CC) $(CFLAGS) -lpthread randtrack_list_lock.cc -o randtrack_list_lock

randtrack_element_lock: list.h hash.h defs.h randtrack_element_lock.cc
	$(CC) $(CFLAGS) -lpthread randtrack_element_lock.cc -o randtrack_element_lock
	
randtrack_reduction: list.h hash.h defs.h randtrack_reduction.cc
	$(CC) $(CFLAGS) -lpthread randtrack_reduction.cc -o randtrack_reduction

clean:
	rm -f *.o randtrack randtrack_global_lock randtrack_tm randtrack_list_lock
