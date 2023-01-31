#include <stdio.h>
#include <stdlib.h>

main()
{
	unsigned int x = 19653;
	FILE *fptr;

	fptr = fopen("output.dat","w");
	if (fptr == NULL) {
		printf("Error creating file!\n");
		exit(-1);
	}
	fprintf(fptr, "%d", x);
	fclose(fptr);
	return(0);
}
