/* autoline v3.01 */
#include <stdio.h>
#define TRUE 1
#define FALSE 0

int isGbCh(char ch);

int main(int argc, char *argv[])
{
	if (argc < 3) {
		printf("Usage: autoline [length] [input file] [output file]\n");
		return 0;
	}

	FILE *fpin, *fpout;

	if ((fpin = fopen(argv[2], "r")) == NULL) {
		printf("Error. Can't open %s\n", argv[2]);
		printf
		    ("Usage: autoline [length] [input file] [output file(default:stdout)]\n");
		return 1;
	}

	if ((fpout = fopen(argv[3], "w+")) == NULL)
		fpout = stdout;

	int str_len = atoi(argv[1]);
	char str[str_len + 1];
	while (fgets(str, str_len, fpin) != NULL) {
		int i;
		int newline = TRUE;
		int errch = FALSE;
		int strend = str_len;
		for (i = 0; i < (str_len + 1); i++) {
			if (str[i] == '\n')
				newline = FALSE;
			if (isGbCh(str[i]))
				errch = ((errch == FALSE) ? TRUE : FALSE);
			if (str[i] == '\0') {
				strend = i;
				break;
			}
		}
		if (errch) {
			str[strend] = fgetc(fpin);
			str[strend + 1] = '\0';
		}
		fprintf(fpout, "%s", str);
		if (newline)
			fprintf(fpout, "\n");
	}
	fclose(fpin);
	fclose(fpout);
	return 0;
}

int isGbCh(char ch)
{
	return (ch >= 0xA1 && ch <= 0xFE);
}
