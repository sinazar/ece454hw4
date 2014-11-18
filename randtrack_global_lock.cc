
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

#include "defs.h"
#include "hash.h"

#define SAMPLES_TO_COLLECT   10000000
#define RAND_NUM_UPPER_BOUND   100000
#define NUM_SEED_STREAMS            4

/* 
 * ECE454 Students: 
 * Please fill in the following team struct
 */
team_t team = {
    "Team Canada",                /* Team name */

    "Sina Zargaran",              /* First member full name */
    "998363621",                  /* First member student number */
    "sina.zargaran@utoronto.ca",  /* First member email address */

    "Allan Jonhs",                /* Second member full name */
    "998256603",                           /* Second member student number */
    "allan.johns@utoronto.ca"     /* Second member email address */
};

unsigned num_threads;
unsigned samples_to_skip;

class sample;

class sample {
  unsigned my_key;
 public:
  sample *next;
  unsigned count;

  sample(unsigned the_key){my_key = the_key; count = 0; next = NULL;};
  unsigned key(){return my_key;}
  void print(FILE *f){printf("%d %d\n",my_key,count);}
};

// This instantiates an empty hash table
// it is a C++ template, which means we define the types for
// the element and key value here: element is "class sample" and
// key value is "unsigned".  
hash<sample,unsigned> h;

void* process_seed_streams(void* arg) {
	int thread_num = *((int*)arg);

	int i,j,k;
	int rnum;
	unsigned key;
	sample *s;

	int from = (thread_num * NUM_SEED_STREAMS)/num_threads;
	int to = ((thread_num+1) * NUM_SEED_STREAMS)/num_threads;

	// process streams starting with different initial numbers
	for (i=from; i<to; i++){
		rnum = i;

		// collect a number of samples
		for (j=0; j<SAMPLES_TO_COLLECT; j++){

		  // skip a number of samples
		  for (k=0; k<samples_to_skip; k++){
			  rnum = rand_r((unsigned int*)&rnum);
		  }

		  // force the sample to be within the range of 0..RAND_NUM_UPPER_BOUND-1
		  key = rnum % RAND_NUM_UPPER_BOUND;

		  __transaction_atomic {
			  // if this sample has not been counted before
			  if (!(s = h.lookup(key))){

				// insert a new element for it into the hash table
				s = new sample(key);
				h.insert(s);
			  }

			  // increment the count for the sample
			  s->count++;
		  }
		}
	}
	return NULL;
}

int  
main (int argc, char* argv[]){

  // Print out team information
  printf( "Team Name: %s\n", team.team );
  printf( "\n" );
  printf( "Student 1 Name: %s\n", team.name1 );
  printf( "Student 1 Student Number: %s\n", team.number1 );
  printf( "Student 1 Email: %s\n", team.email1 );
  printf( "\n" );
  printf( "Student 2 Name: %s\n", team.name2 );
  printf( "Student 2 Student Number: %s\n", team.number2 );
  printf( "Student 2 Email: %s\n", team.email2 );
  printf( "\n" );

  // Parse program arguments
  if (argc != 3){
    printf("Usage: %s <num_threads> <samples_to_skip>\n", argv[0]);
    exit(1);  
  }
  sscanf(argv[1], " %d", &num_threads); // not used in this single-threaded version
  sscanf(argv[2], " %d", &samples_to_skip);

  pthread_t tid[num_threads];
  int err;

  // initialize a 16K-entry (2**14) hash of empty lists
  h.setup(14);

  if (num_threads == 1 || num_threads == 2 || num_threads == 4){
	  //Create threads for the number of threads specified
	  int i;
	  for (i=0; i < num_threads; i++) {
		  int thread_num = i;
		  err = pthread_create(&(tid[i]), NULL, process_seed_streams, (void*)&thread_num);
		  if (err) {
			  printf("\ncan't create thread :[%d]\n", err);
			  exit(EXIT_FAILURE);
		  }
		  else
			  printf("\n Thread created successfully\n");
	  }

	  for (i=0; i < num_threads; i++) {
		  pthread_join(tid[i], NULL);
	  }
  } else {
	  printf ("\nWrong number of threads specified.\n");
	  exit(0);
  }
  // print a list of the frequency of all samples
  h.print();
}
