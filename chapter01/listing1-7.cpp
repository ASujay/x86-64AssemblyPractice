#include <stdio.h>
#include <string.h>

extern "C" {
    void asmMain(void);
    char* getTitle(void);
    int readLine(char *dest, int maxLen);
}

int readLine(char *dest, int maxLen) {
    char *result = fgets(dest, maxLen, stdin);
    if (result != NULL) {
        int len = strlen(result);
        if(len > 0) {
            dest[len - 1] = 0;
        }
        return len;
    }

    return -1;
}

int main(void) {
    try {
        char *title = getTitle();
        printf("Calling %s:\n", title);
        asmMain();
        printf("%s terminated\n", title);
    } catch(...) {
        printf(
            "Exception occurred during rpogram execution"
            "Abnormal program termination\n"
        );
    }
}