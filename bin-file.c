#include <stdio.h>
#include <stdlib.h>

main()
{
	unsigned int x = 19653;
	FILE *fptr;

	fptr = fopen("output.dat","wb");
	if (fptr == NULL) {
		printf("Error creating file!\n");
		exit(-1);
	}
	fwrite(&x, sizeof(x), 1, fptr);
	fclose(fptr);
	return(0);
}
